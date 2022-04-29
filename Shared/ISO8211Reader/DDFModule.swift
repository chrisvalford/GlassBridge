//
//  DDFModule.swift
//  CatScan
//
//  Created by Christopher Alford on 11.04.20.
//  Copyright © 2020 Marine+Digital. All rights reserved.
//

import Foundation
import Combine

public class DDFModule: ObservableObject {

    var sourceUrl: URL?
    fileprivate var record: DDFRecord?
    private(set) var firstRecordOffset: UInt64?
    var cloneCount = 0
    var maxCloneCount = 0
    fileprivate var ddfRecordClones = [DDFRecord]()
    var fieldDefinitionCount = 0
    var fieldDefinitions = [DDFFieldDefinition]()

    var data: Data?
    var file: FileHandle?

    var interchangeLevel: UInt8?
    var leaderIdentifier: UInt8?
    var inlineCodeExtensionIndicator: UInt8?
    var versionNumber: UInt8?
    var appIndicator: UInt8?
    var extendedCharSet: [UInt8]?
    var sizeFieldLength: Int?
    var sizeFieldPosition: Int?
    var sizeFieldTag: Int?
    var recordLength: Int?
    @Published var fieldControlLength = 0
    @Published var fieldAreaStart = 0

    func close() {
        if file != nil {
            do {
                try file?.close()
                file = nil
            } catch {
                print(error.localizedDescription)
            }
        }
        if record != nil {
            record = nil
        }
        if cloneCount > 0 {
            ddfRecordClones.removeAll()
            cloneCount = 0
        }
        maxCloneCount = 0
        fieldDefinitions.removeAll()
        fieldDefinitionCount = 0
    }

    init() {}

    init?(url: URL) {
        self.sourceUrl = url
        if !open(url: sourceUrl!) {
            return nil
        }
    }

    func open(url: URL) -> Bool {
        sourceUrl = url
        var leader = [UInt8](repeating: 0, count: headerLength)
        if file != nil {
            close()
        }
        do {
            file = try FileHandle.init(forReadingFrom: sourceUrl!)
        } catch {
            print(error.localizedDescription)
            return false
        }
        if let data = file?.readData(ofLength: headerLength) {
            leader = Array(data)
            //print("<<< Offset: \(try? file?.offset() ?? 0)")
        } else {
            print("Unable to read leader data!")
            return false
        }

        // Validate the leader
        var bValid = true
        for i in 0..<headerLength {
            if leader[i] < 32 || leader[i] > 126 {
                bValid = false
            }
        }
        if leader[5] != one && leader[5] != two && leader[5] != three {
            bValid = false
        }
        if leader[6] != upperL {
            bValid = false
        }
        if leader[8] != 49 && leader[8] != 32 {
            bValid = false
        }
        if bValid == true {
            recordLength                 = DDFScanInt(pszString: leader, from: 0, nMaxChars: 5)
            interchangeLevel             = leader[5]
            leaderIdentifier             = leader[6]
            inlineCodeExtensionIndicator = leader[7] //FIXME: nil??? Should be 69
            versionNumber                = leader[8]
            appIndicator                 = leader[9]
            fieldControlLength           = DDFScanInt(pszString: leader, from: 10, nMaxChars: 2) ?? 0
            fieldAreaStart               = DDFScanInt(pszString: leader, from: 12, nMaxChars: 5) ?? 0
            extendedCharSet              = Array(leader[17...19])
            sizeFieldLength              = DDFScanInt(pszString: leader, from: 20, nMaxChars: 1)
            sizeFieldPosition            = DDFScanInt(pszString: leader, from: 21, nMaxChars: 1)
            sizeFieldTag                 = DDFScanInt(pszString: leader, from: 23, nMaxChars: 1)
        }

        if recordLength! < 12 || fieldControlLength == 0
            || fieldAreaStart < 24 || sizeFieldLength == 0
            || sizeFieldPosition == 0 || sizeFieldTag == 0 {
            bValid = false
        }

        // Read the whole record
        var recordBytes = [UInt8](repeating: 0, count: recordLength ?? 0)
        do {
            try file?.seek(toOffset: 0)
        } catch {
            print(error)
        }
        //print("<<< Offset: \(try? file?.offset() ?? 0)")
        if let data = file?.readData(ofLength: recordLength ?? 0) {
            //print("<<< Offset: \(try? file?.offset() ?? 0)")
            recordBytes = Array(data)
            print("Read \(recordBytes.count) bytes")
        } else {
            print("Unable to read record Bytes!")
            return false
        }

        // Make a pass counting the directory entries
        let fieldEntryWidth = sizeFieldLength! + sizeFieldPosition! + sizeFieldTag!
        //var fieldDefinitionCount = 0

        for i in stride(from: headerLength, to: recordLength!, by: fieldEntryWidth) {
            if recordBytes[i] == fieldTerminator {
                break
            }
            fieldDefinitionCount += 1
        }

        // Allocate, and read field definitions
        for i in 0..<fieldDefinitionCount {

            var entryOffset = headerLength + i*fieldEntryWidth

            // Tag
            var fieldName = [UInt8](repeating: 0, count: 128)
            fieldName = Array(recordBytes[entryOffset..<(entryOffset+sizeFieldTag!)])

            entryOffset += sizeFieldTag!

            // Field Length
            var fieldLength = 0
            if let tFieldLength = DDFScanInt(pszString: recordBytes,
                                             from: entryOffset,
                                             nMaxChars: sizeFieldLength!) {
                fieldLength = tFieldLength
            }

            entryOffset += sizeFieldLength!

            // Field Position
            var fieldPosition = 0
            if let tFieldPos = DDFScanInt(pszString: recordBytes,
                                          from: entryOffset,
                                          nMaxChars: sizeFieldPosition!) {
                fieldPosition = tFieldPos
            }

            var subRecord = [UInt8](repeating: 0, count: fieldLength)
            subRecord = Array(recordBytes[fieldAreaStart + fieldPosition...(fieldAreaStart + fieldPosition + fieldLength - 1)])

            var ddfFieldDefinition = DDFFieldDefinition()
            if ddfFieldDefinition.initialize(ddfModule: self,
                                  tagIn: fieldName,
                                  size: fieldLength,
                                  byteBuffer: subRecord) {
                fieldDefinitionCount += 1
                fieldDefinitions.append(ddfFieldDefinition)
            }
        }
        do {
            if #available(OSX 10.15.4, *) {
                firstRecordOffset = try file?.offset()
            } else {
                print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX")
            }
            //print("<<< firstRecordOffset: \(firstRecordOffset ?? 0)")
        } catch {
            print(error.localizedDescription)
        }
        leader.removeAll()
        return true
    }

    func reopen() {
        if file == nil {
            do {
                file = try FileHandle.init(forReadingFrom: sourceUrl!)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func DDFScanInt(pszString: [UInt8], nMaxChars: Int ) -> Int? {
        var maxChars = nMaxChars
        if maxChars > 32 || maxChars == 0 {
            maxChars = 32
        }
        let data = Data(pszString[0...nMaxChars-1])
        if let str = String(data: data, encoding: .utf8) {
            return Int(str)
        }
        return nil
    }

    func DDFScanInt(pszString: [UInt8], from: Int, nMaxChars: Int ) -> Int? {
        var maxChars = nMaxChars
        if maxChars > 32 || maxChars == 0 {
            maxChars = 32
        }
        if from+nMaxChars-1 > pszString.count {
            return nil
        }
        let data = Data(pszString[from...from+nMaxChars-1])
        if let str = String(data: data, encoding: .utf8) {
            return Int(str)
        }
        return nil
    }

    //==
    func initialize(chInterchangeLevel: UInt8,
                    chLeaderIden: UInt8,
                    chCodeExtensionIndicator: UInt8,
                    chVersionNumber: UInt8,
                    chAppIndicator: UInt8,
                    pszExtendedCharSet: [UInt8],
                    nSizeFieldLength: Int,
                    nSizeFieldPos: Int,
                    nSizeFieldTag: Int ) {

        interchangeLevel = chInterchangeLevel
        leaderIdentifier = chLeaderIden
        inlineCodeExtensionIndicator = chCodeExtensionIndicator
        versionNumber = chVersionNumber
        appIndicator = chAppIndicator
        extendedCharSet = pszExtendedCharSet
        sizeFieldLength = nSizeFieldLength
        sizeFieldPosition = nSizeFieldPos
        sizeFieldTag = nSizeFieldTag
    }

    /**
         * Read one record from the file, and return to the application.
         * The returned record is owned by the module, and is reused from
         * call to call in order to preserve headers when they aren't
         * being re-read from record to record.
         *
         * @return A pointer to a DDFRecord object is returned, or null if
         *         a read error, or end of file occurs. The returned
         *         record is owned by the module, and should not be
         *         deleted by the application. The record is only valid
         *         until the next readRecord() at which point it is
         *         overwritten.
         */
    func readRecord() -> DDFRecord? {
        if record == nil {
            record = DDFRecord(self)
            do {
                try record?.read()
                return record
            } catch {
                print(error)
                return nil
            }
        }
        return nil
        //return record
    }

    /**
         * Fetch a field definition by index.
         *
         * @param i (from 0 to GetFieldCount() - 1.
         * @return the returned field pointer or null if the index is out
         *         of range.
         */
    func getField(i: Int) -> DDFFieldDefinition? {
        if i < 0 || i >= fieldDefinitionCount {
            return nil
        } else {
            return fieldDefinitions[i]
        }
    }

    //==
    func addCloneRecord(ddfRecord: DDFRecord) {
        // Do we need to enlarge the container?
        if cloneCount == maxCloneCount {
            maxCloneCount = cloneCount * 2 + 20
            // The cpp reallocs the papoClones array
        }
        ddfRecordClones.append(ddfRecord)
    }

    //==
    func removeClonedRecord(ddfRecord: DDFRecord) {
        for i in 0..<cloneCount {
            if ddfRecordClones[i] === ddfRecord {
                ddfRecordClones.remove(at: i)
                cloneCount -= 1
                return
            }
        }
    }

    //==
    func ddfRewind(nOffset: UInt64?) {

        var offset = nOffset
        if offset == nil {
            offset = firstRecordOffset
        }

        if file == nil {
            return
        }

        do {
            try file?.seek(toOffset: offset!)
            //print("<<< Offset: \(try? file?.offset() ?? 0)")
        } catch {
            print(error.localizedDescription)
        }

        if offset == firstRecordOffset && record != nil {
            record?.clear()
        }
    }

    /**
         * Method for other components to call to get the DDFModule to
         * read bytes into the provided array.
         *
         * @param toData the bytes to put data into.
         * @param offset the byte offset to start reading from, whereever
         *        the pointer currently is.
         * @param length the number of bytes to read.
         * @return the number of bytes read.
         */
    func read(toData: inout [UInt8], offset: UInt64, length: Int) -> Int {
            if file == nil {
                reopen()
                //print("<<< Offset: \(try? file?.offset() ?? 0)")
            }
            if file != nil {
                do {
                    try file?.seek(toOffset: offset)
                    if let data = file?.readData(ofLength: length) {
                        //print("<<< Offset: \(try? file?.offset() ?? 0)")
                        toData = Array(data)
                        return toData.count
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
            return 0
        }
}

public extension DDFModule {
    /**
         * Fetch the definition of the named field.
         *
         * This function will scan the DDFFieldDefn's on this module, to
         * find one with the indicated field tag.
         *
         * @param pszFieldName The tag of the field to search for. The
         *        comparison is case insensitive.
         *
         * @return A pointer to the request DDFFieldDefn object is
         *         returned, or null if none matching the tag are found.
         *         The return object remains owned by the DDFModule, and
         *         should not be deleted by application code.
         */
    func findFieldDefinition(named: String) -> DDFFieldDefinition? {
        if fieldDefinitions.isEmpty {
            return nil
        }
        for i in 0..<fieldDefinitionCount {
            let pszThisName = fieldDefinitions[i].name
            if named == pszThisName {
                return fieldDefinitions[i]
            }
        }
        return nil // not found
    }
}

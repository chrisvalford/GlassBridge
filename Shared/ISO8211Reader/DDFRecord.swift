//
//  DDFRecord.swift
//  CatScan
//
//  Created by Christopher Alford on 11.04.20.
//  Copyright © 2020 Marine+Digital. All rights reserved.
//

import Foundation

public class DDFRecord {

    private(set) var ddfModule: DDFModule
    var reuseHeaderFlag = false
    var fieldDataOffset = -1 // field data area, not dir entries.
    private(set) var count = 0   // Whole record except leader with header
    private(set) var data: [UInt8]?
    private(set)var fieldCount = 0
    var ddfFields: [DDFField] = []
    var isClone = false
    var sizeFieldTag = 4
    var sizeFieldPos = 0
    var sizeFieldLength = 0

    init(_ ddfModule: DDFModule) {
        self.ddfModule = ddfModule
    }

    deinit {
        if isClone == true {
            ddfModule.removeClonedRecord(ddfRecord: self)
        }
    }

    /**
     * Read a record of data from the file, and parse the header to
     * build a field list for the record (or reuse the existing one if
     * reusing headers). It is expected that the file pointer will be
     * positioned at the beginning of a data record. It is the
     * DDFModule's responsibility to do so.
     *
     * This method should only be called by the DDFModule class.
     */
    func read() throws {

        /* -------------------------------------------------------------------- */
        /* Redefine the record on the basis of the header if needed. */
        /*
         * As a side effect this will read the data for the record as
         * well.
         */
        /* -------------------------------------------------------------------- */
        if !reuseHeaderFlag {
            print("DDFRecord reusing header, calling readHeader()")
            do {
                try readHeader()
                return
            } catch {
                throw DDFException.recordLength
            }
        }

        /* -------------------------------------------------------------------- */
        /* Otherwise we read just the data and carefully overlay it on the previous
         records data without disturbing the rest of the record. */
        /* -------------------------------------------------------------------- */

        var tempData = [UInt8](repeating: 0, count:(self.count - fieldDataOffset))
        let bytesRead = ddfModule.read(toData: &tempData, offset: 0, length: tempData.count)

        //System.arraycopy(data, fieldDataOffset, tempData, 0, tempData.length);

        let start = fieldDataOffset
        let end = (fieldDataOffset+tempData.count)
        let a = data?[start...end]
        tempData = Array(a ?? [])

        if bytesRead != (self.count - fieldDataOffset) && bytesRead == -1 {
            throw DDFException.recordLength
        } else if bytesRead != (self.count - fieldDataOffset) {
            print("DDFRecord: Data record is short on DDF file.")
            throw DDFException.recordLength
        }

        // notdef: eventually we may have to do something at this point to notify the DDFField's that their data values have changed.
    }

    func clear() {}


    /// This perform the header reading and parsing job for the read()
    /// method. It reads the header, and builds a field list.
    func readHeader() throws {

        /* -------------------------------------------------------------------- */
        /* Clear any existing information. */
        /* -------------------------------------------------------------------- */
        clear();

        /* -------------------------------------------------------------------- */
        /* Read the 24 byte leader. */
        /* -------------------------------------------------------------------- */
        var data = [UInt8](repeating: 0, count: headerLength)
        guard let firstRecordOffset = ddfModule.firstRecordOffset else {
            print("Error - first record offset is missing!")
            throw DDFException.invalidOffset
        }
        let bytesRead = ddfModule.read(toData: &data, offset: firstRecordOffset, length: headerLength)
        if bytesRead == -1 {
            throw DDFException.recordLength
        } else if bytesRead != headerLength {
            print("DDFRecord.readHeader(): Leader is short on DDF file.")
            throw DDFException.recordLength
        }

        /* -------------------------------------------------------------------- */
        /* Extract information from leader. */
        /* -------------------------------------------------------------------- */
        var _recordLength = 0
        var _fieldAreaStart = 0
        var _sizeFieldLength: Int
        var _sizeFieldPosition: Int
        var _sizeFieldTag: Int
        var _leaderIdentifier: UInt8

        do {
            _fieldAreaStart = try data.int(start: 12, end: 17)
            _recordLength = try data.int(start: 0, end: 5)
        } catch {
            // Turns out, this usually indicates the end of the header information,
            // with "^^^^^^^" being in the file. This is filler.
            print("Finished reading headers")
            print(error)
            return
        }

        _leaderIdentifier = data[6];
        _sizeFieldLength = Int(data[20] - zero)
        _sizeFieldPosition = Int(data[21] - zero)
        _sizeFieldTag = Int(data[23] - zero)

        if _leaderIdentifier == upperR {
            reuseHeaderFlag = true
        }

        fieldDataOffset = _fieldAreaStart - headerLength

#if DEBUG
        print("\trecord length: \(_recordLength)")          // [0,5]
        print("\tfield area start: \(_fieldAreaStart)")     // [12,5]
        print("\tleader id: \(_leaderIdentifier)")          // [6]
        print("reuse header: \(reuseHeaderFlag)")
        print("\tfield length: \(_sizeFieldLength)")        // [20]
        print("\tfield position: \(_sizeFieldPosition)")    // [21]
        print("\tfield tag: \(_sizeFieldTag)")              // [23]
#endif
        // FIXME: false
        var readSubfields = false

        /* -------------------------------------------------------------------- */
        /* Is there anything seemly screwy about this record? */
        /* -------------------------------------------------------------------- */
        if _recordLength == 0 {
            // Looks like for record lengths of zero, we really want
            // to consult the size of the fields before we try to read
            // in all of the data for this record. Most likely, we
            // don't, and want to access the data later only when we
            // need it.
            self.count = _fieldAreaStart - headerLength;
        } else if _recordLength < 24 || _recordLength > 100000000
                    || _fieldAreaStart < 24 || _fieldAreaStart > 100000 {

            print("DDFRecord: Data record appears to be corrupt on DDF file.\n -- ensure that the files were uncompressed without modifying\n carriage return/linefeeds (by default WINZIP does this).");
            throw DDFException.invalidRecord
        } else {
            // Read the remainder of the record.
            self.count = _recordLength - headerLength
            readSubfields = true
        }

        data = [UInt8](repeating: 0, count: self.count)
        do {
            let n = ddfModule.read(toData: &data, offset: try ddfModule.file?.offset() ?? 0, length: self.count)
            if n != self.count {
                print("DDFRecord: Data record is short on DDF file.")
                throw DDFException.recordLength
            }
        } catch {
            throw error
        }


        // Loop over the directory entries, making a pass counting them.
        let fieldEntryWidth = _sizeFieldLength + _sizeFieldPosition + _sizeFieldTag
        fieldCount = 0
        for i in stride(from: 0, to: self.count, by: fieldEntryWidth) {
            if data[i] == fieldTerminator {
                break
            }
            fieldCount += 1
        }

        // Allocate, and read field definitions.
        ddfFields = [DDFField]() //fieldCount

        for i in 0..<fieldCount {
            var entryOffset = i * fieldEntryWidth

            // Read the position information and tag.
            let tag = Array(data[entryOffset...(entryOffset + _sizeFieldTag - 1)])
            entryOffset += _sizeFieldTag

            do {
                let fieldLength = try data.int(start: entryOffset, end: (entryOffset + _sizeFieldLength - 1))
                entryOffset += _sizeFieldLength
                let start = entryOffset
                let end = entryOffset + _sizeFieldPosition - 1
                let fieldPosition = try data.int(start: start, end: end)

                // Find the corresponding field in the module directory.
                // FIXME: therte are no field definitions???
                guard let fieldName = String(bytes: tag, encoding: .utf8),
                      let fieldDefinition: DDFFieldDefinition = ddfModule.findFieldDefinition(named: fieldName) else {
                          print("DDFRecord: Undefined field \(tag) encountered in data record.")
                          throw DDFException.undefinedField
                      }
                var ddff: DDFField?

                if readSubfields == true {
                    // Assign info the DDFField.
                    let start = _fieldAreaStart + fieldPosition - headerLength
                    let end = (_fieldAreaStart + fieldPosition - headerLength + fieldLength - 1)
                    let tempData: [UInt8] = Array((data[start...end]))
                    ddff = DDFField(ddfFieldDefinition: fieldDefinition, data: tempData, doSubfields: readSubfields)
                } else {
                    // Save the info for reading later directly out of the field.
                    ddff = DDFField(ddfFieldDefinition: fieldDefinition, dataPositionIn: fieldPosition, dataLengthIn: fieldLength)
                    ddff?.headerOffset = ddfModule.recordLength! + _fieldAreaStart
                }
                ddfFields.append(ddff!)
            } catch {
                print(error)
            }
        }
    }
    /************************************************************************/
    /*                              GetField()                              */
    /************************************************************************/

    /**
     * Fetch field object based on index.
     *
     * @param i The index of the field to fetch.  Between 0 and GetFieldCount()-1.
     *
     * @return A DDFField pointer, or NULL if the index is out of range.
     */

    func getField(at: Int) -> DDFField? {
        if at < 0 || at > fieldCount {
            return nil
        } else {
            return ddfFields[at]
        }
    }
}

extension DDFRecord: CustomStringConvertible {
    public var description: String {
        var value = ""
        value.append("DDFRecord:\n" )
        value.append("    nReuseHeader = \(reuseHeaderFlag)\n")
        value.append("    nDataSize = \(self.count)\n")
        value.append("    _sizeFieldLength=\(sizeFieldLength)\n")
        value.append("    _sizeFieldPos=\(sizeFieldPos)\n")
        value.append("    _sizeFieldTag=\(sizeFieldTag)\n")

        for field in ddfFields {
            value.append("        \(field.description)")
        }

        return value
    }
}



//
//  View8211.swift
//  CatScan
//
//  Created by Christopher Alford on 10/12/21.
//  Copyright © 2021 Marine+Digital. All rights reserved.
//

import Foundation

/// Class that uses the DDF* classes to read an 8211 file and print out the contents.

public class View8211 {

    private var fsptHack = false
    private var filePath: URL?

    public init(url: URL, fspt_repeating: Bool) {
        filePath = url
        fsptHack = fspt_repeating
        view()
    }

    private func view() {

        let ddfModule = DDFModule(url: filePath!)
        ddfModule?.open(url: filePath!)
        if fsptHack {
            if var poFSPT: DDFFieldDefinition = ddfModule?.findFieldDefinition(named: "FSPT") {
                poFSPT.hasRepeatingSubfields = true
            } else {
                print("View8211: unable to find FSPT field to set repeating flag.")
            }
        }

        /* -------------------------------------------------------------------- */
        /* Loop reading records till there are none left. */
        /* -------------------------------------------------------------------- */

        var iRecord = 1
        var moreRecords = true
        repeat {
            let record = ddfModule?.readRecord()
            if record == nil {
                moreRecords = false
            } else {
                print("Record \(iRecord += 1)(\(record!.count) bytes)")
                for field in record!.ddfFields {
                    viewRecordField(ddfField: field)
                }
            }
        } while moreRecords == true

        //            while ((ddfRecord = (ddfModule?.readRecord())!) != nil) {
        //                print("Record \(iRecord += 1)(\(ddfRecord.count) bytes)")
        //
        //                /* ------------------------------------------------------------ */
        //                /* Loop over each field in this particular record. */
        //                /* ------------------------------------------------------------ */
        //                for (Iterator it = ddfRecord.iterator(); it != null && it.hasNext();) {
        //                    // Debug.output(((DDFField)it.next()).toString()));
        //                    viewRecordField(((DDFField) it.next()));
        //                }
        //            }
    }

    /**
     * Dump the contents of a field instance in a record.
     */
    private func viewRecordField(ddfField: DDFField) {
        let ddfFieldDefinition = ddfField.fieldDefinition

        // Report general information about the field.
        print("    Field \(ddfFieldDefinition.name ?? "Missing tag") : \(String(describing: ddfFieldDefinition.name))")

        // Get pointer to this fields raw data. We will move through
        // it consuming data as we report subfield values.

        var pachFieldData = ddfField.data
        var nBytesRemaining: Int = ddfField.getDataSize()

        /* -------------------------------------------------------- */
        /* Loop over the repeat count for this fields */
        /* subfields. The repeat count will almost */
        /* always be one. */
        /* -------------------------------------------------------- */
        let repeatCount = ddfField.getRepeatCount()
        for iRepeat in 0..<repeatCount {
            if iRepeat > 0 {
                print("Repeating (\(iRepeat))...")
            }
            /* -------------------------------------------------------- */
            /* Loop over all the subfields of this field, advancing */
            /* the data pointer as we consume data. */
            /* -------------------------------------------------------- */

            let subfieldCount = ddfFieldDefinition.subfieldDefinitions.count
            for iSF in 0..<subfieldCount {
                do {
                    let poSFDefn = try ddfFieldDefinition.getSubfield(i: iSF)
                    let nBytesConsumed: Int = viewSubfield(poSFDefn: poSFDefn,
                                                           pachFieldData: pachFieldData,
                                                           nBytesRemaining: &nBytesRemaining)
                    nBytesRemaining -= nBytesConsumed
//                System.arraycopy(pachFieldData, nBytesConsumed, tempData, 0, tempData.length);
//                       arraycopy(source_arr, sourcePos: Int, dest_arr, destPos: Int, len: Int)
                    let end = nBytesConsumed + (pachFieldData.count - nBytesConsumed - 1)
                    pachFieldData = Array(pachFieldData[nBytesConsumed...end])
                } catch {
                    print(error)
                }
            }
        }
    }

    private func viewSubfield(poSFDefn: DDFSubfieldDefinition,
                              pachFieldData: [UInt8],
                              nBytesRemaining: inout Int) -> Int {

        var nBytesConsumed: Int? = 0

        switch poSFDefn.eType {
        case DDFDataType.DDFInt:
            let n = poSFDefn.extractIntData(pachSourceData: pachFieldData,
                                            nMaxBytes: nBytesRemaining,
                                            pnConsumedBytes: &nBytesConsumed)
            print("        \(poSFDefn.name) = \(n)")

        case DDFDataType.DDFFloat:
            let n = poSFDefn.extractFloatData(pachSourceData: pachFieldData,
                                              nMaxBytes: nBytesRemaining,
                                              pnConsumedBytes: &nBytesConsumed)
            print("        \(poSFDefn.name) = \(n)")

        case DDFDataType.DDFString:
            let n = poSFDefn.extractStringData(pachSourceData: pachFieldData,
                                               nMaxBytes: nBytesRemaining,
                                               pnConsumedBytes: &nBytesConsumed)
            print("        \(poSFDefn.name) = \(n)")

        case DDFDataType.DDFBinaryString:
            _ = poSFDefn.extractStringData(pachSourceData: pachFieldData,
                                           nMaxBytes: nBytesRemaining,
                                           pnConsumedBytes: &nBytesConsumed) // pabyBString
            print("        \(poSFDefn.name)")
        }
        return nBytesConsumed ?? 0
    }

    //    public static void main(String[] argv) {
    //
    //        Debug.init();
    //
    //        String pszFilename = null;
    //        boolean bFSPTHack = false;
    //
    //        for (int iArg = 0; iArg < argv.length; iArg++) {
    //            if (argv[iArg].equals("-fspt_repeating")) {
    //                bFSPTHack = true;
    //            } else {
    //                pszFilename = argv[iArg];
    //            }
    //        }
    //
    //        if (pszFilename == null) {
    //            Debug.output("Usage: View8211 filename\n");
    //            System.exit(1);
    //        }
    //
    //        new View8211(pszFilename, bFSPTHack);
    //
    //    }

}

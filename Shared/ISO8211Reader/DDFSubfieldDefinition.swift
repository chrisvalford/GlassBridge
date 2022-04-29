//
//  DDFSubfieldDefinition.swift
//  CatScan
//
//  Created by Christopher Alford on 26.09.20.
//  Copyright © 2020 Marine+Digital. All rights reserved.
//

import Foundation

public struct DDFSubfieldDefinition {

    var name: String
    private(set) var formatString: [UInt8]

    // This can be used to determine which of ExtractFloatData(), ExtractIntData()
    // or ExtractStringData() should be used.
    private(set) var eType: DDFDataType
    var eBinaryFormat: DDFBinaryFormat

    // isVariable determines whether we using the formatDelimeter (true), or the fixed width (false).
    var isVariable: Bool?
    var formatDelimeter: UInt8

    private(set) var formatWidth: Int

    public init(name: String) {
        self.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        isVariable = true
        formatWidth = 0
        formatDelimeter = unitTerminator
        eBinaryFormat = DDFBinaryFormat.NotBinary
        eType = DDFDataType.DDFString
        formatString = [UInt8]()
    }
    
    // For testing purposes only
    public init(name: String, isVariable: Bool,
                formatWidth: Int,
                formatDelimeter: UInt8,
                eBinaryFormat: DDFBinaryFormat,
                eType: DDFDataType,
                formatString : [UInt8]) {
        self.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        self.isVariable = isVariable
        self.formatWidth = formatWidth
        self.formatDelimeter = formatDelimeter
        self.eBinaryFormat = eBinaryFormat
        self.eType = eType
        self.formatString = formatString
    }

    /*
     While interpreting the format string we don't support:
     Passing an explicit terminator for variable length field.
     'X' for unused data ... this should really be filtered
     out by DDFFieldDefinition.applyFormats(), but isn't.
     'B' bitstrings that aren't a multiple of eight.
     */
    mutating func setFormat(format: [UInt8]) -> Bool {
        formatString = format
//        #if DEBUG
//        print("DDFSubfieldDefinition.setFormat(\(String(bytes: format, encoding: .utf8) ?? ""))")
//        #endif
        /* -------------------------------------------------------------------- */
        /* These values will likely be used. */
        /* -------------------------------------------------------------------- */
        if formatString.count > 1 && formatString[1] == openingParenthesis {

            // Need to loop through characters to grab digits, and
            // then get integer version. If we look a the atoi code,
            // it checks for non-digit characters and then stops.

            var j = 0
            for i in 3..<format.count {
                if Character(UnicodeScalar(format[i])).isNumber {}
                j = i
            }

            let array = Array(format[2..<j])
            let str = String(bytes: array, encoding: .utf8)
            formatWidth = Int(str!)!
            isVariable = (formatWidth == 0)
        } else {
            isVariable = true
        }

        /* -------------------------------------------------------------------- */
        /* Interpret the format string. */
        /* -------------------------------------------------------------------- */
        switch formatString[0] {

        case upperA, upperC: // It isn't clear to me how C is different than A
            eType = DDFDataType.DDFString

        case upperR:
            eType = DDFDataType.DDFFloat

        case upperI, upperS:
            eType = DDFDataType.DDFInt

        case upperB, lowerB:
            // Is the width expressed in bits? (is it a bitstring)
            isVariable = false
            if formatString[1] == openingParenthesis {
                var numEndIndex = 2

                while numEndIndex < formatString.count && Character(UnicodeScalar(formatString[numEndIndex])).isNumber {
                    numEndIndex += 1
                }

                formatWidth = Int(String(bytes: Array(formatString[2...numEndIndex]), encoding: .utf8)!)!


                if (formatWidth % 8 != 0) {
                    //                        Debug.error("DDFSubfieldDefinition.setFormat() problem with "
                    //                                        + pszFormatString.charAt(0)
                    //                                        + " not being modded with 8 evenly");
                    return false
                }

                formatWidth = formatWidth / 8

                eBinaryFormat = DDFBinaryFormat.SInt // good default, works for SDTS.

                if formatWidth < 5 {
                    eType = DDFDataType.DDFInt
                } else {
                    eType = DDFDataType.DDFBinaryString
                }

            } else { // or do we have a binary type indicator? (is it binary)

                eBinaryFormat = DDFBinaryFormat(rawValue: Int(formatString[1] - zero))!

                var numEndIndex = 2
                while numEndIndex < formatString.count && Character(UnicodeScalar(formatString[numEndIndex])).isNumber {
                    numEndIndex += 1
                }

                formatWidth = Int(String(bytes: Array(formatString[2...numEndIndex]), encoding: .utf8)!)!

                if eBinaryFormat == DDFBinaryFormat.SInt || eBinaryFormat == DDFBinaryFormat.UInt {
                    eType = DDFDataType.DDFInt
                } else {
                    eType = DDFDataType.DDFFloat
                }
            }


        case upperX:
            // 'X' is extra space, and shouldn't be directly assigned
            // to a
            // subfield ... I haven't encountered it in use yet
            // though.
            print("DDFSubfieldDefinition: Format type of \(formatString[0]) not supported.")
            return false

        default:
            print("DDFSubfieldDefinition: Format type of \(formatString[0]) not recognised.")
            return false
        }

        return true
    }

    /**
     * Scan for the end of variable length data. Given a pointer to the data for
     * this subfield (from within a DDFRecord) this method will return the
     * number of bytes which are data for this subfield. The number of bytes
     * consumed as part of this field can also be fetched. This number may be
     * one longer than the length if there is a terminator character used.
     * <p>
     *
     * This method is mainly for internal use, or for applications which want
     * the raw binary data to interpret themselves. Otherwise use one of
     * ExtractStringData(), ExtractIntData() or ExtractFloatData().
     *
     * @param pachSourceData
     *            The pointer to the raw data for this field. This may have come
     *            from DDFRecord::GetData(), taking into account skip factors
     *            over previous subfields data.
     * @param nMaxBytes
     *            The maximum number of bytes that are accessible after
     *            pachSourceData.
     * @param pnConsumedBytes
     *            the number of bytes used.
     *
     * @return The number of bytes at pachSourceData which are actual data for
     *         this record (not including unit, or field terminator).
     */
    func getDataLength(pachSourceData: [UInt8], nMaxBytes: Int, pnConsumedBytes: inout Int?) -> Int {
        if isVariable == false {
            if formatWidth > nMaxBytes {
                print("DDFSubfieldDefinition: Only \(nMaxBytes) bytes available for subfield \(name) with format string \(formatString)... returning shortened data.")

                if pnConsumedBytes != nil {
                    pnConsumedBytes = nMaxBytes
                }
                return nMaxBytes
            } else {

                if pnConsumedBytes != nil {
                    pnConsumedBytes = formatWidth
                }
                return formatWidth
            }
        } else {

            var nLength = 0
            var bCheckFieldTerminator = true

            /*
             * We only check for the field terminator because of some buggy
             * datasets with missing format terminators. However, we have found
             * the field terminator is a legal character within the fields of
             * some extended datasets (such as JP34NC94.000). So we don't check
             * for the field terminator if the field appears to be multi-byte
             * which we established by the first character being out of the
             * ASCII printable range (32-127).
             */

            if pachSourceData[0] < 32 || pachSourceData[0] >= 127 {
                bCheckFieldTerminator = false
            }

            while nLength < nMaxBytes && pachSourceData[nLength] != formatDelimeter {

                if bCheckFieldTerminator && pachSourceData[nLength] == fieldTerminator {
                    break
                }
                nLength += 1
            }

            if pnConsumedBytes != nil {
                if nMaxBytes == 0 {
                    pnConsumedBytes = nLength
                } else {
                    pnConsumedBytes = nLength + 1
                }
            }
            return nLength
        }
    }

    /**
     * Extract a zero terminated string containing the data for this subfield.
     * Given a pointer to the data for this subfield (from within a DDFRecord)
     * this method will return the data for this subfield. The number of bytes
     * consumed as part of this field can also be fetched. This number may be
     * one longer than the string length if there is a terminator character
     * used.
     * <p>
     *
     * This function will return the raw binary data of a subfield for types
     * other than DDFString, including data past zero chars. This is the
     * standard way of extracting DDFBinaryString subfields for instance.
     * <p>
     *
     * @param pachSourceData
     *            The pointer to the raw data for this field. This may have come
     *            from DDFRecord::GetData(), taking into account skip factors
     *            over previous subfields data.
     * @param nMaxBytes
     *            The maximum number of bytes that are accessible after
     *            pachSourceData.
     * @param pnConsumedBytes
     *            Pointer to an integer into which the number of bytes consumed
     *            by this field should be written. May be null to ignore. This
     *            is used as a skip factor to increment pachSourceData to point
     *            to the next subfields data.
     *
     * @return A pointer to a buffer containing the data for this field. The
     *         returned pointer is to an internal buffer which is invalidated on
     *         the next ExtractStringData() call on this DDFSubfieldDefn(). It
     *         should not be freed by the application.
     */
    func extractStringData(pachSourceData: [UInt8], nMaxBytes: Int, pnConsumedBytes: inout Int?) -> [UInt8] {
        var oldConsumed = 0
        if pnConsumedBytes != nil {
            oldConsumed = pnConsumedBytes!
        }

        let nLength = getDataLength(pachSourceData: pachSourceData, nMaxBytes: nMaxBytes, pnConsumedBytes: &pnConsumedBytes)
        let bytes = Array(pachSourceData[0...(nLength == 0 ? 0 : nLength - 1)])
        #if DEBUG
        if  pnConsumedBytes != nil {
            print("        extracting string data from \(nLength) bytes of \(pachSourceData.count): \"\(String(bytes: bytes, encoding: .utf8) ?? "missing")\": consumed \(String(describing: pnConsumedBytes)) vs. \(oldConsumed) , max = \(nMaxBytes)")
        }
        #endif
        return bytes
    }

    /**
     * Extract a subfield value as a float. Given a pointer to the data for this
     * subfield (from within a DDFRecord) this method will return the floating
     * point data for this subfield. The number of bytes consumed as part of
     * this field can also be fetched. This method may be called for any type of
     * subfield, and will return zero if the subfield is not numeric.
     *
     * @param pachSourceData
     *            The pointer to the raw data for this field. This may have come
     *            from DDFRecord::GetData(), taking into account skip factors
     *            over previous subfields data.
     * @param nMaxBytes
     *            The maximum number of bytes that are accessible after
     *            pachSourceData.
     * @param pnConsumedBytes
     *            Pointer to an integer into which the number of bytes consumed
     *            by this field should be written. May be null to ignore. This
     *            is used as a skip factor to increment pachSourceData to point
     *            to the next subfields data.
     *
     * @return The subfield's numeric value (or zero if it isn't numeric).
     */
    func extractFloatData(pachSourceData: [UInt8], nMaxBytes: Int, pnConsumedBytes: inout Int?) -> Double {

        switch formatString[0] {
        case upperA, upperI, upperR, upperS, upperC:
            let dataString = extractStringData(pachSourceData: pachSourceData,
                                               nMaxBytes: nMaxBytes,
                                               pnConsumedBytes: &pnConsumedBytes)
            if dataString == [unitTerminator] {
                return 0
            }

            if dataString.count == 0 {
                return 0
            }
            if let str = String(bytes: dataString, encoding : .utf8) {
                return Double(str)!
            } else {
                return 0
            }

        //                try {
        //                    return Double.parseDouble(dataString);
        //                } catch (NumberFormatException nfe) {
        //                    if (Debug.debugging("iso8211")) {
        //                        Debug
        //                                .output("DDFSubfieldDefinition.extractFloatData: number format problem: "
        //                                        + dataString);
        //                    }
        //                    return 0;
        //                }

        case upperB, lowerB:

            var abyData = [UInt8](repeating: 0, count: 8)

            if pnConsumedBytes != nil {
                pnConsumedBytes = formatWidth
            }

            if formatWidth > nMaxBytes {
                print("DDFSubfieldDefinition: format width is greater than max bytes for float")
                return 0.0
            }

            // Byte swap the data if it isn't in machine native
            // format. In any event we copy it into our buffer to
            // ensure it is word aligned.
            //
            // DFD - don't think this applies to Java, since it's
            // always big endian

            // if (pszFormatString.charAt(0) == 'B') ||
            // (pszFormatString.charAt(0) == 'b') {
            // for (int i = 0; i < nFormatWidth; i++) {
            // abyData[nFormatWidth-i-1] = pachSourceData[i];
            // }
            // } else {
            // System.arraycopy(pachSourceData, 0, abyData, 8-nFormatWidth,
            // nFormatWidth);
            //System.arraycopy(pachSourceData, 0, abyData, 0, nFormatWidth);
            abyData = Array(pachSourceData[0...formatWidth])
            // }

            // Interpret the bytes of data.
            switch (eBinaryFormat) {
            case DDFBinaryFormat.UInt, DDFBinaryFormat.SInt, DDFBinaryFormat.FloatReal:
                //                    return (int) pszFormatString.charAt(0) == 'B' ? MoreMath
                //                            .BuildIntegerBE(abyData) : MoreMath
                //                            .BuildIntegerLE(abyData);
                return Double(String(bytes: abyData, encoding: .utf8)!)!

            // if (nFormatWidth == 1)
            // return(abyData[0]);
            // else if (nFormatWidth == 2)
            // return(*((GUInt16 *) abyData));
            // else if (nFormatWidth == 4)
            // return(*((GUInt32 *) abyData));
            // else {
            // return 0.0;
            // }

            // case DDFBinaryFormat.SInt:
            // if (nFormatWidth == 1)
            // return(*((signed char *) abyData));
            // else if (nFormatWidth == 2)
            // return(*((GInt16 *) abyData));
            // else if (nFormatWidth == 4)
            // return(*((GInt32 *) abyData));
            // else {
            // return 0.0;
            // }

            // case DDFBinaryFormat.FloatReal:
            // if (nFormatWidth == 4)
            // return(*((float *) abyData));
            // else if (nFormatWidth == 8)
            // return(*((double *) abyData));
            // else {
            // return 0.0;
            // }

            case DDFBinaryFormat.NotBinary, DDFBinaryFormat.FPReal, DDFBinaryFormat.FloatComplex:
                return 0.0
            }

        // end of 'b'/'B' case.

        default:
            // Do nothing?
            return 0.0

        }
    }

    /**
     * Extract a subfield value as an integer. Given a pointer to the data for
     * this subfield (from within a DDFRecord) this method will return the int
     * data for this subfield. The number of bytes consumed as part of this
     * field can also be fetched. This method may be called for any type of
     * subfield, and will return zero if the subfield is not numeric.
     *
     * @param pachSourceData
     *            The pointer to the raw data for this field. This may have come
     *            from DDFRecord::GetData(), taking into account skip factors
     *            over previous subfields data.
     * @param nMaxBytes
     *            The maximum number of bytes that are accessible after
     *            pachSourceData.
     * @param pnConsumedBytes
     *            Pointer to an integer into which the number of bytes consumed
     *            by this field should be written. May be null to ignore. This
     *            is used as a skip factor to increment pachSourceData to point
     *            to the next subfields data.
     *
     * @return The subfield's numeric value (or zero if it isn't numeric).
     */
    func extractIntData(pachSourceData: [UInt8], nMaxBytes: Int, pnConsumedBytes: inout Int?) -> Int {

        switch formatString[0] {
        case upperA, upperI, upperR, upperS, upperC:
            let dataString = extractStringData(pachSourceData: pachSourceData, nMaxBytes: nMaxBytes, pnConsumedBytes: &pnConsumedBytes)
            if dataString.count == 0 {
                return 0
            }

            if let str = String(bytes: dataString, encoding : .utf8) {
                return Int(str)!
            } else {
                return 0
            }
//            try {
//            return Double.valueOf(dataString).intValue();
//            } catch (NumberFormatException nfe) {
//            if (Debug.debugging("iso8211")) {
//            Debug
//            .output("DDFSubfieldDefinition.extractIntData: number format problem: "
//            + dataString);
//            }
//            return 0;
//            }

        case upperB, lowerB:
            var abyData = [UInt8](repeating: 0, count: 4)
            if formatWidth > nMaxBytes {
                print("DDFSubfieldDefinition: format width is greater than max bytes for int")
                return 0
            }

            if pnConsumedBytes != nil {
                pnConsumedBytes = formatWidth
            }

            // System.arraycopy(pachSourceData, 0, abyData, 4-nFormatWidth,
            // nFormatWidth);
            abyData = Array(pachSourceData[0...formatWidth])

            // Interpret the bytes of data.
            switch eBinaryFormat {
            case DDFBinaryFormat.UInt, DDFBinaryFormat.SInt, DDFBinaryFormat.FloatReal:
//                return (int) pszFormatString.charAt(0) == 'B' ? MoreMath
//                    .BuildIntegerBE(abyData) : MoreMath
//                    .BuildIntegerLE(abyData);
                return Int(String(bytes: abyData, encoding: .utf8)!)!

            // case DDFBinaryFormat.UInt:
            // if (nFormatWidth == 4)
            // return((int) *((GUInt32 *) abyData));
            // else if (nFormatWidth == 1)
            // return(abyData[0]);
            // else if (nFormatWidth == 2)
            // return(*((GUInt16 *) abyData));
            // else {
            // CPLAssert(false);
            // return 0;
            // }

            // case DDFBinaryFormat.SInt:
            // if (nFormatWidth == 4)
            // return(*((GInt32 *) abyData));
            // else if (nFormatWidth == 1)
            // return(*((signed char *) abyData));
            // else if (nFormatWidth == 2)
            // return(*((GInt16 *) abyData));
            // else {
            // CPLAssert(false);
            // return 0;
            // }

            // case DDFBinaryFormat.FloatReal:
            // if (nFormatWidth == 4)
            // return((int) *((float *) abyData));
            // else if (nFormatWidth == 8)
            // return((int) *((double *) abyData));
            // else {
            // CPLAssert(false);
            // return 0;
            // }

            case DDFBinaryFormat.NotBinary, DDFBinaryFormat.FPReal, DDFBinaryFormat.FloatComplex:
                return 0
            }

        // end of 'b'/'B' case.

        default:
            return 0
        }
    }
}

extension DDFSubfieldDefinition: Equatable {

    public static func == (lhs: DDFSubfieldDefinition, rhs: DDFSubfieldDefinition) -> Bool {
        return lhs.name == rhs.name && lhs.eType == rhs.eType && lhs.eBinaryFormat == rhs.eBinaryFormat
    }
}

extension DDFSubfieldDefinition: CustomStringConvertible {
    public var description: String {
        var value = ""
        value.append(" DDFSubfieldDefinition\n")
        value.append("     Name: \(name)\n")
        //var pszFormatString: [UInt8]
        value.append("     Type: \(eType)\n")
        value.append("     eBinary format: \(eBinaryFormat)\n")

        /**
         * isVariable determines whether we using the chFormatDelimeter (true), or
         * the fixed width (false).
         */
        //var bIsVariable: Bool?
        //var chFormatDelimeter: UInt8
        //var nFormatWidth: Int
        return value
    }
}

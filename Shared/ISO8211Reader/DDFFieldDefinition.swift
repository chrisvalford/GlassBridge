//
//  DDFFieldDefinition.swift
//  GlassBridge (iOS)
//
//  Created by Christopher Alford on 25/4/22.
//

import Foundation

public struct DDFFieldDefinition {
    
    var ddfModule: DDFModule?
    var arrayDescr: String?
    var formatControls: [UInt8]?
    var subfieldDefinitions: [DDFSubfieldDefinition] = []
    private(set) var subfieldCount: Int = 0
    private(set) var fixedWidth: Int = 0   // zero if variable.
     var hasRepeatingSubfields: Bool = false // private(set)
    private(set) var name: String?
    var _data_struct_code: DDF_data_struct_code?
    var _data_type_code: DDF_data_type_code?
    
    /// Based on the list contained in the string, build a set of subfield definitions.
    mutating func buildSubfields(sublist: String) -> Bool {
        var _sublist = sublist
        if _sublist.hasPrefix("*") {
            hasRepeatingSubfields = true
            _sublist = String(_sublist[sublist.index(_sublist.startIndex, offsetBy: 1)...])
        }
        let subfieldNames = _sublist.components(separatedBy: "!")
        subfieldDefinitions = [DDFSubfieldDefinition]()
        for subFieldName in subfieldNames {
            let subField = DDFSubfieldDefinition(name: subFieldName)
            subfieldDefinitions.append(subField)
        }
        return true
    }
    
    /// Find a subfield definition by it's mnemonic tag.
    /// param pszMnemonic The name of the field.
    ///
    /// returns The subfield pointer, or null if there isn't any such subfield.
    ///
    func findSubfieldDefn(named: String) -> DDFSubfieldDefinition? {
        if subfieldDefinitions.isEmpty {
            return nil
        }
        for subfieldDefinition in subfieldDefinitions {
            if subfieldDefinition.name == named {
                return subfieldDefinition
            }
        }
        return nil
    }
    
    func getSubfield(i: Int) throws -> DDFSubfieldDefinition {

        if subfieldDefinitions.isEmpty || i < 0 || i >= subfieldDefinitions.count {
            throw DDFException.invalidSubfield
        }
        return subfieldDefinitions[i]
    }
    
    /**
     * Extract a substring terminated by a comma (or end of string).
     * Commas in brackets are ignored as terminated with bracket
     * nesting understood gracefully. If the returned string would
     * being and end with a bracket then strip off the brackets.
     * <P>
     * Given a string like "(A,3(B,C),D),X,Y)" return "A,3(B,C),D".
     * Give a string like "3A,2C" return "3A".
     */
    func extractSubstring(pszSrc: [UInt8]) -> [UInt8] {
        var nBracket = 0
        var pszReturn: [UInt8] = []
        var i = 0
        while (i < pszSrc.count) && (nBracket > 0 || pszSrc[i] != comma) {
            if pszSrc[i] == openingParenthesis {
                nBracket += 1
            } else if pszSrc[i] == closingParenthesis {
                nBracket -= 1
            }
            i += 1
        }
        if pszSrc[0] == openingParenthesis {
            pszReturn = Array(pszSrc[1...(i - 2)])
        } else {
            if i < pszSrc.count {
                pszReturn = Array(pszSrc[0...i])
            } else {
                pszReturn = pszSrc
            }
        }
        if pszReturn.last == comma {
            return pszReturn.dropLast()
        }
        return pszReturn
    }
    
    
     /// This method parses the format string partially, and then
     /// applies a subfield format string to each subfield object. It in
     /// turn does final parsing of the subfield formats.
    mutating func applyFormats(formatControls: [UInt8]) -> Bool {

        var pszFormatList: [UInt8]
        var papszFormatItems = [[UInt8]]()

        // Do we have enough data?
        let n = formatControls.count - 1
        if n <= 2 {
            print("Format controls is too short")
            return false
        }

        // Is the data enclosed in parenthesis?
        if formatControls[0] != openingParenthesis || formatControls[n] != closingParenthesis {
            print("Format controls are missing parenthesis")
            return false
        }

        pszFormatList = expandFormat(pszSrc: formatControls)

        /* -------------------------------------------------------------------- */
        /* Tokenize based on commas. */
        /* -------------------------------------------------------------------- */
        papszFormatItems = pszFormatList.components(seperatedBy: comma)

        /* -------------------------------------------------------------------- */
        /* Apply the format items to subfields. */
        /* -------------------------------------------------------------------- */

        var iFormatItem = 0
        for item in papszFormatItems {

            var pszPastPrefix = item
            var pppIndex = 0
            // Skip over digits...
            while pszPastPrefix[pppIndex].isNumber {
                pppIndex += 1
            }
            pszPastPrefix = Array(pszPastPrefix[pppIndex...])

            // Did we get too many formats for the subfields created
            // by names? This may be legal by the 8211 specification,
            // but isn't encountered in any formats we care about so we
            // just blow.

            if (iFormatItem > subfieldDefinitions.count) {
                print("DDFFieldDefinition: Got more formats than subfields for field " + name!)
                break
            }

            if !subfieldDefinitions[iFormatItem].setFormat(format: pszPastPrefix) {
                print("DDFFieldDefinition had problem setting format for \(pszPastPrefix)")
                return false
            }

            iFormatItem += 1
        }

        /* -------------------------------------------------------------------- */
        /* Verify that we got enough formats, cleanup and return. */
        /* -------------------------------------------------------------------- */
        if iFormatItem < subfieldDefinitions.count {
            print("DDFFieldDefinition: Got fewer formats than subfields for field \(String(describing: name)) got (\(iFormatItem), should have \(subfieldDefinitions.count))")
            return false
        }

        /* -------------------------------------------------------------------- */
        /* If all the fields are fixed width, then we are fixed width */
        /* too. This is important for repeating fields. */
        /* -------------------------------------------------------------------- */
        fixedWidth = 0
        for i in 0..<subfieldDefinitions.count {
            let ddfsd = subfieldDefinitions[i]
            if ddfsd.formatWidth == 0 {
                fixedWidth = 0
                break
            } else {
                fixedWidth += ddfsd.formatWidth
            }
        }
        return true
    }
    
    /**
     * Given a string that contains a coded size symbol, expand it
     * out.
     *  For: (A(2),I(10),3A,A(3),4R,2A)
     *  Expect: A(2),I(10),A,A,A,A(3),R,R,R,R,A,A
     */
    func expandFormat(pszSrc: [UInt8]) -> [UInt8] {
        var szDest: [UInt8] = []
        var iSrc = 0
        var nRepeat = 0
        
        print(pszSrc.string)
        
        while iSrc < pszSrc.count {
            /*
             * This is presumably an extra level of brackets around
             * some binary stuff related to rescanning which we don't
             * care to do (see 6.4.3.3 of the standard. We just strip
             * off the extra layer of brackets
             */
            if ((iSrc == 0 || pszSrc[iSrc - 1] == comma) && pszSrc[iSrc] == openingParenthesis) {
                let pszContents = extractSubstring(pszSrc: Array(pszSrc[iSrc...]))
                // print("pszContents: \(pszContents.string)")
                let pszExpandedContents = expandFormat(pszSrc: pszContents);
                szDest.append(contentsOf: pszExpandedContents)
                iSrc = iSrc + pszContents.count + 2
                
            } else if (iSrc == 0 || pszSrc[iSrc - 1] == comma) && pszSrc[iSrc].isNumber { // isDigit
                // this is a repeated subclause
                let orig_iSrc = iSrc
                // skip over repeat count.
                while pszSrc[iSrc].isNumber {
                    iSrc += 1
                }
                let nRepeatString = Array(pszSrc[orig_iSrc..<iSrc]).string // 3A
                nRepeat = Int(nRepeatString) ?? 0
                let pszContents = extractSubstring(pszSrc: Array(pszSrc[iSrc...]))
                let pszExpandedContents = expandFormat(pszSrc: pszContents);
                for i in 0..<nRepeat {
                    szDest.append(contentsOf: pszExpandedContents)
                    if (i < nRepeat - 1) {
                        szDest.append(comma)
                    }
                }
                if iSrc == openingParenthesis { // Open parentheis "("
                    iSrc += pszContents.count + 2
                } else {
                    iSrc += pszContents.count
                }
            } else {
                // print("pszSrc: \(pszSrc.string)")
                // print("Appending psZSrc[\(iSrc)] to szDest")
                // print("szDest: \(szDest.string)")
                // print("------------------------------------")
                szDest.append(pszSrc[iSrc])
                iSrc += 1
            }
        }
        // print(szDest.string)
        return szDest
    }
    
    
    /// DDFFetchVariable() */
    /// Fetch a variable length string from a record
    ///  TODO: Check to see if this should return any trailing delimiter characters
    func fetchVariable(pszRecord: [UInt8],
                       nMaxChars: Int,
                       nDelimChar1: UInt8,
                       nDelimChar2: UInt8,
                       pnConsumedChars: inout Int) -> [UInt8] {
        var i = 0
        while i < nMaxChars - 1 && pszRecord[i] != nDelimChar1 && pszRecord[i] != nDelimChar2 {
            i += 1
        }
        pnConsumedChars = i
        if i < nMaxChars && (pszRecord[i] == nDelimChar1 || pszRecord[i] == nDelimChar2) {
            pnConsumedChars += 1
        }
        return Array(pszRecord[0..<i])  // Skip the delimiter
        
        //return String(bytes: pszRecord[0...i], encoding: .utf8)!
    }
    
    mutating func initialize(ddfModule: DDFModule, tagIn: [UInt8], size: Int, byteBuffer: [UInt8]) -> Bool {
        self.ddfModule = ddfModule
        self.name = String(bytes: tagIn, encoding: .utf8)
        var iFDOffset: Int = ddfModule.fieldControlLength
        var nCharsConsumed = 0
        var size = size

        /* -------------------------------------------------------------------- */
        /*      Set the data struct and type codes.                             */
        /* -------------------------------------------------------------------- */
        switch byteBuffer[0] {

        case 0x20, 0x30: /* for ADRG, DIGEST USRP, DIGEST ASRP files */
            _data_struct_code = .dsc_elementary

        case 0x31:
            _data_struct_code = .dsc_vector

        case 0x32:
            _data_struct_code = .dsc_array

        case 0x33:
            _data_struct_code = .dsc_concatenated

        default:
            print("Unrecognised data_struct_code value \(byteBuffer[0]). Field \(String(describing: name)) initialization incorrect.")
            _data_struct_code = .dsc_elementary
        }

        switch byteBuffer[1] {

        case 0x20, 0x30: /* for ADRG, DIGEST USRP, DIGEST ASRP files */
            _data_type_code = .dtc_char_string

        case 0x31:
            _data_type_code = .dtc_implicit_point

        case 0x32:
            _data_type_code = .dtc_explicit_point

        case 0x33:
            _data_type_code = .dtc_explicit_point_scaled

        case 0x34:
            _data_type_code = .dtc_char_bit_string

        case 0x35:
            _data_type_code = .dtc_bit_string

        case 0x36:
            _data_type_code = .dtc_mixed_data_type

        default:
            print("Unrecognised data_type_code value \(byteBuffer[1]). Field \(String(describing: name)) initialization incorrect.")
            _data_type_code = .dtc_char_string
        }

        // Capture the field name, description (sub field names), and format statements.
        let start = iFDOffset
        let end = start + byteBuffer.count-iFDOffset - 1
        var tempData = Array(byteBuffer[start...end])
        tempData.fetchString(maximumLength: size - iFDOffset,
                                    firstDelimiter: unitTerminator,
                                     secondDelimiter: fieldTerminator,
                                     completion: { count, value in
            iFDOffset += count
            name = value
        })
        // FIXME:
//        if size < iFDOffset {
//            return false
//        }
//        tempData = Array(byteBuffer[iFDOffset..<(size)])
        tempData = Array(byteBuffer[iFDOffset...size-1])
        //FIXME: HACK
        if size > byteBuffer.count {
            size = byteBuffer.count
        }

        tempData = Array(byteBuffer[iFDOffset..<(size)])
        tempData.fetchString(maximumLength: size - iFDOffset,
                                    firstDelimiter: unitTerminator,
                                     secondDelimiter: fieldTerminator,
                                     completion: { count, value in
            iFDOffset += count
            arrayDescr = value
        })

        // FIXME:
        if size < iFDOffset {
            return false
        }
        let tempdata = Array(byteBuffer[iFDOffset..<(size)])

//        formatControls = fetchVariable(pszRecord: tempdata,
//                                        nMaxChars: size - iFDOffset,
//                                        nDelimChar1: unitTerminator,
//                                        nDelimChar2: fieldTerminator,
//                                        pnConsumedChars: &nCharsConsumed)
        tempdata.fetchString(maximumLength: size - iFDOffset,
                             firstDelimiter: unitTerminator,
                             secondDelimiter: fieldTerminator) { count, value in
            formatControls = value.byteArray
        }

        // _formatControls = pachRecord.rangeToString(start: iFDOffset, length: size - iFDOffset, delimiterA: DDF_UNIT_TERMINATOR, delimiterB: DDF_FIELD_TERMINATOR, consumed: &nCharsConsumed!)

        /* -------------------------------------------------------------------- */
        /*      Parse the subfield info.                                        */
        /* -------------------------------------------------------------------- */
        if _data_struct_code != .dsc_elementary {

            if !buildSubfields(sublist: arrayDescr!)  {
                return false
            }

            if !applyFormats(formatControls: formatControls!) {
                return false
            }
        }
        return true
    }
}

extension DDFFieldDefinition: CustomStringConvertible {
    public var description: String {
        var value = "class DDFFieldDefinition\n"
        value.append("Tag: \(name ?? "nil")\n")

        value.append("Field name: \(name ?? "nil")\n")
        value.append("Array description: \(arrayDescr ?? "nil")\n")
        //var _formatControls: [UInt8]?

        value.append("Has repeating sub-fields: \(hasRepeatingSubfields == true ? "true" : "false")\n")
        value.append("Is fixed width: \(fixedWidth)\n")    // zero if variable.
        value.append("Data struct code: \(_data_struct_code?.description ?? "nil")\n")
        value.append("Data type code: \(_data_type_code?.description ?? "nil")\n")
        value.append("Subfield count: \(subfieldCount)\n")

        for subfieldDefinition in subfieldDefinitions {
            value.append(subfieldDefinition.description)
        }
        return value
    }
}

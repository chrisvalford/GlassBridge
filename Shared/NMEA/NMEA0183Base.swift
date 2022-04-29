//
//  NMEA0183Base.swift
//  GlassBridge
//
//  Created by Christopher Alford on 23.05.20.
//

import Foundation
import Combine

class NMEA0813Base: ObservableObject {

    let rawData: String

    var sentenceId:String = ""
    var senderId:String = ""
    var attributes = [[UInt8]]()
    var validChecksum:Bool = false
    fileprivate var asciiString: [UInt8]?

    init(rawData:String) throws {
        self.rawData = rawData
        self.validChecksum = compareChecksum()
        self.readAttributes()
    }

    func compareChecksum() -> Bool {
        let calculatedChecksum = self.calculateChecksum(from: nil)
        let givenChecksum = self.getChecksum()
        print("calc: \(calculatedChecksum) given: \(givenChecksum)")
        if (calculatedChecksum == givenChecksum) {
            print("Matched")
        }
        else {
            print("Unmatched")
        }

        return false
    }

    // XOR of all the bytes between the $ and the * (not including the delimiters themselves), and written in hexadecimal.
    func calculateChecksum(from: String?) -> UInt32 {

        var source: String
        if from != nil {
            source = from!
        } else {
            source = rawData
        }
        let bytes = source.utf8
        asciiString = [UInt8](bytes)

        var index = 0
        var lastAsterisk = 0

        for character in source {
            if character == "*" { // "*"
                lastAsterisk = index
            }
            index += 1
        }

        // Split the string at the lastAsterisk
        let leading = source[...(lastAsterisk-1)]
        let trailing = source[(lastAsterisk + 1)...]
        print(String(leading))
        print("Calculating checksum (\(String(trailing).trimmingCharacters(in: .whitespacesAndNewlines)))")

        var checksum:UInt32 = 0

        for character in leading {

            // Skip the leading $
            if (character == "$") {
                continue
            }
            if character == "\n" {
                continue
            }

            let s = String(character).unicodeScalars
            // Bitwise XOR
            checksum ^= s[s.startIndex].value
        }
        return checksum;
    }

    func getChecksum() -> UInt64 {
        //TODO: Change this to match the func above
        // Find the last occurance of *, and use the remaining string for the calc
        if let lastIndex = rawData.lastIndex(of: "*") {
            let newIndex = rawData.index(lastIndex, offsetBy: 1)
            let lastPart = "0x" + String(rawData[newIndex...]).trimmingCharacters(in: .whitespacesAndNewlines)
            var result: UInt64 = 0
            let scanner: Scanner = Scanner(string: lastPart)
            scanner.scanHexInt64(&result);
            return UInt64(result);
        }
        return 0
    }

    func pad(string: String) -> String {
        let components = string.components(separatedBy: ".")
        var sv = components[0]
        repeat {
            sv = "0\(sv)"
        } while sv.count < 5
        return "\(sv).\(components[1])"
    }

    func readAttributes() {
        var attributeIndex = 0

        var temp = [UInt8]()
        var completed = false

        for byte in asciiString! {

            // Attributes are seperated by commas
            if byte == 44 { // comma
                attributes.append(temp)
                temp.removeAll()
                completed = true
                attributeIndex += 1
            } else {
                temp.append(byte)
                completed = false
            }
        }
        // Catch the last attribute
        if completed == false {
            attributes.append(temp)
            temp.removeAll()
        }
    }
}




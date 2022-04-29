//
//  String+.swift
//  ExpandFormat
//
//  Created by Christopher Alford on 25/4/22.
//

import Foundation

// Convert String to [UInt8]
public extension String {
    var byteArray: [UInt8] {
        let bytes = self.utf8
        return [UInt8](bytes)
    }
}

extension StringProtocol {

    subscript(offset: Int) -> Element {
        return self[index(startIndex, offsetBy: offset)]
    }

    subscript(_ range: CountableRange<Int>) -> SubSequence {
        return prefix(range.lowerBound + range.count)
            .suffix(range.count)
    }
    subscript(range: CountableClosedRange<Int>) -> SubSequence {
        return prefix(range.lowerBound + range.count)
            .suffix(range.count)
    }

    subscript(range: PartialRangeThrough<Int>) -> SubSequence {
        return prefix(range.upperBound.advanced(by: 1))
    }
    subscript(range: PartialRangeUpTo<Int>) -> SubSequence {
        return prefix(range.upperBound)
    }
    subscript(range: PartialRangeFrom<Int>) -> SubSequence {
        return suffix(Swift.max(0, count - range.lowerBound))
    }
}

extension Substring {
    var string: String { return String(self) }
}

// extend String to enable sub-script with Int to get Character or sub-string
extension String
{
    subscript (i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }

    // for convenience we should include String return
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }

    subscript (r: Range<Int>) -> String {
        let start = self.index(self.startIndex, offsetBy: r.lowerBound)
        let end = self.index(self.startIndex, offsetBy: r.upperBound)

        return String(self[start...end])
    }
}

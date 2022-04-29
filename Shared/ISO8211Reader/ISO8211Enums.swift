//
//  Enums.swift
//  CatScan
//
//  Created by Christopher Alford on 18.04.20.
//  Copyright © 2020 Marine+Digital. All rights reserved.
//

import Foundation

public enum DDFException: Error {
    case recordLength // Add more for other DDFRecord errors
    case invalidOffset // Generic error when position in file/buffer is incorrect
    case undefinedField
    case invalidIntegerValue
    case invalidRecord
    case invalidSubfield
}

public enum DDFBinaryFormat: Int{
    case NotBinary = 0
    case UInt = 1
    case SInt = 2
    case FPReal = 3
    case FloatReal = 4
    case FloatComplex = 5
}

public enum DDF_data_struct_code {
    case dsc_elementary,
    dsc_vector,
    dsc_array,
    dsc_concatenated
}

extension DDF_data_struct_code: CustomStringConvertible {
    public var description: String {
        switch self {
        case .dsc_elementary:
            return "Elementary"
        case .dsc_vector:
            return "Vector"
        case .dsc_array:
            return "Array"
        case .dsc_concatenated:
            return "Concatenated"
        }
    }
}

public enum DDF_data_type_code {
    case dtc_char_string,
    dtc_implicit_point,
    dtc_explicit_point,
    dtc_explicit_point_scaled,
    dtc_char_bit_string,
    dtc_bit_string,
    dtc_mixed_data_type
}

extension DDF_data_type_code: CustomStringConvertible {
    public var description: String {
        switch self {
        case .dtc_char_string:
            return "Character String"
        case .dtc_implicit_point:
            return "Implicit Point"
        case .dtc_explicit_point:
            return "Explicit Point"
        case .dtc_explicit_point_scaled:
            return "Explicit Point Scaled"
        case .dtc_char_bit_string:
            return "Character Bit String"
        case .dtc_bit_string:
            return "Bit String"
        case .dtc_mixed_data_type:
            return "Mixed Data Type"
        }
    }
}

public enum DDFDataType {
    case DDFInt, DDFFloat, DDFString, DDFBinaryString
}

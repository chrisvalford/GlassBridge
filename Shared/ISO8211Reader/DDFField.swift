//
//  DDFField.swift
//  CatScan
//
//  Created by Christopher Alford on 27.09.20.
//  Copyright © 2020 Marine+Digital. All rights reserved.
//

import Foundation

public class DDFField {

    private(set) var fieldDefinition: DDFFieldDefinition
    private(set) var data: [UInt8] = []
    var subfields: [DDFSubfield] = []//Dictionary<String, Any> = [:]
    private(set) var dataPosition: Int?
    private(set) var dataLength: Int?
    var headerOffset = 0

    //init() {}

    init(ddfFieldDefinition: DDFFieldDefinition, dataPositionIn: Int, dataLengthIn: Int) {
        fieldDefinition = ddfFieldDefinition
        dataPosition = dataPositionIn
        dataLength = dataLengthIn
    }

    convenience init(ddfFieldDefinition: DDFFieldDefinition, data: [UInt8]) {
        self.init(ddfFieldDefinition: ddfFieldDefinition, data: data, doSubfields: true)
    }

    init(ddfFieldDefinition: DDFFieldDefinition, data: [UInt8], doSubfields: Bool) {
        self.data = data
        fieldDefinition = ddfFieldDefinition
        if doSubfields == true {
            buildSubfields()
        }
    }

    /**
     * Return the number of bytes in the data block returned by
     * GetData().
     */
    func getDataSize() -> Int {
        if !data.isEmpty {
            return data.count
        } else {
            return 0
        }
    }

    /**
     * Will return an ordered list of DDFSubfield objects. If the
     * subfield wasn't repeated, it will provide a list containing one
     * object. Will return null if the subfield doesn't exist.
     */
    func getSubfields(subfieldName: [UInt8]) -> [DDFSubfield]? {
        let name = String(bytes: subfieldName, encoding: .utf8)
        return subfields.filter { $0.defn?.name == name! }
//        if obj != nil {
//            return obj
//        } else if obj != nil {
//            LinkedList ll = new LinkedList();
//            ll.add(obj);
//            return ll;
//        }
//
//        return nil
    }

    /**
     * Will return a DDFSubfield object with the given tag, or the
     * first one off the list for a repeating subfield. Will return
     * null if the subfield doesn't exist.
     */
    func getSubfield(subfieldName: [UInt8]) -> DDFSubfield? {
        //var obj: Any
        let name = String(bytes: subfieldName, encoding: .utf8)
        let items = subfields.filter { $0.defn?.name == name! }
//        if items!.count > 1 && items![0] is [DDFSubfield] {
//            let list = obj as! [DDFSubfield]
//            if list.count > 0 {
//                return list[0]
//            }
//        }

        // May be null if subfield list above is empty. Not sure if
        // that's possible.
//        return obj as? DDFSubfield
        return items.first
    }

    /**
     * Fetch raw data pointer for a particular subfield of this field.
     *
     * The passed DDFSubfieldDefn (poSFDefn) should be acquired from
     * the DDFFieldDefn corresponding with this field. This is
     * normally done once before reading any records. This method
     * involves a series of calls to DDFSubfield::GetDataLength() in
     * order to track through the DDFField data to that belonging to
     * the requested subfield. This can be relatively expensive.
     * <p>
     *
     * @param poSFDefn The definition of the subfield for which the
     *        raw data pointer is desired.
     * @param pnMaxBytes The maximum number of bytes that can be
     *        accessed from the returned data pointer is placed in
     *        this int, unless it is null.
     * @param iSubfieldIndex The instance of this subfield to fetch.
     *        Use zero (the default) for the first instance.
     *
     * @return A pointer into the DDFField's data that belongs to the
     *         subfield. This returned pointer is invalidated by the
     *         next record read (DDFRecord::ReadRecord()) and the
     *         returned pointer should not be freed by the
     *         application.
     */
    func getSubfieldData(ddfSubfieldDefinition: DDFSubfieldDefinition?,
                         maxBytes: inout Int?, subfieldIndex: Int) -> [UInt8] {

        var index = subfieldIndex
        var offset = 0

        if ddfSubfieldDefinition == nil {
            return []
        }

        if (index > 0 && fieldDefinition.fixedWidth > 0) {
            offset = fieldDefinition.fixedWidth * index;
            index = 0;
        }

        var nBytesConsumed: Int? = 0
        while index >= 0 {
            for iSF in 0..<fieldDefinition.subfieldCount {
                do {
                    let foundDDFSubfieldDefinition = try fieldDefinition.getSubfield(i: iSF)
                    //var subData = [UInt8](repeating: 0, count: (data!.count - offset))
                    let subData = Array(data[offset...(offset+(data.count - offset))])

                    if foundDDFSubfieldDefinition == ddfSubfieldDefinition && index == 0 {
                        if maxBytes != nil {
                            maxBytes = data.count - offset
                        }
                        return subData
                    }
                    _ = foundDDFSubfieldDefinition.getDataLength(pachSourceData: subData,
                                               nMaxBytes: subData.count,
                                               pnConsumedBytes: &nBytesConsumed)
                    offset += nBytesConsumed!
                } catch {
                    print(error)
                    return []
                }
            }
            index -= 1
        }

        // We didn't find our target subfield or instance!
        return []
    }

    func buildSubfields() {
        var pachFieldData: [UInt8] = data
        var nBytesRemaining = data.count

        let repeatCount = getRepeatCount()
        for _ in 0..<repeatCount {

            /* -------------------------------------------------------- */
            /* Loop over all the subfields of this field, advancing */
            /* the data pointer as we consume data. */
            /* -------------------------------------------------------- */
            let subfieldCount = fieldDefinition.subfieldCount // DDFFieldDefinition.subfieldCount
            for iSF in 0..<subfieldCount {
                do {
                    let ddfs = DDFSubfield(poSFDefn: try fieldDefinition.getSubfield(i: iSF), pachFieldData: pachFieldData, nBytesRemaining: nBytesRemaining)

                        addSubfield(ddfs: ddfs!)

                        // Reset data for next subfield;
                        let nBytesConsumed = ddfs!.byteSize
                        nBytesRemaining -= nBytesConsumed
                        var tempData = [UInt8](repeating: 0, count: pachFieldData.count - nBytesConsumed)
                        tempData = Array(pachFieldData[nBytesConsumed...(nBytesConsumed+tempData.count)])
                        //System.arraycopy(pachFieldData,nBytesConsumed,tempData,0,tempData.length);
                        pachFieldData = tempData;
                    } catch {
                        print(error)
                    }
            }
        }

    }

    func addSubfield(ddfs: DDFSubfield) {
//        if (Debug.debugging("iso8211")) {
//            Debug.output("DDFField(" + getFieldDefn().getName()
//                            + ").addSubfield(" + ddfs + ")");
//        }
        print("DDFField \(ddfs)")

        //var name = ddfs.getDefn().tag//.trim().intern();
        //let sf = subfields?.filter { $0.defn?.tag == name }

        // Only add if not in array?
        //if sf == nil {
            subfields.append(ddfs)
//        } else {
//            if (sf instanceof List) {
//                ((List) sf).add(ddfs);
//            } else {
//                Vector subList = new Vector();
//                subList.add(sf);
//                subList.add(ddfs);
//                subfields.put(sfName, subList);
//            }
//        }
    }

    /**
     * How many times do the subfields of this record repeat? This
     * will always be one for non-repeating fields.
     *
     * @return The number of times that the subfields of this record
     *         occur in this record. This will be one for
     *         non-repeating fields.
     */
    func getRepeatCount() -> Int {
        if (!fieldDefinition.hasRepeatingSubfields) {
            return 1;
        }

        /* -------------------------------------------------------------------- */
        /* The occurrence count depends on how many copies of this */
        /* field's list of subfields can fit into the data space. */
        /* -------------------------------------------------------------------- */
        if (fieldDefinition.fixedWidth != 0) {
            return data.count / fieldDefinition.fixedWidth
        }

        /* -------------------------------------------------------------------- */
        /* Note that it may be legal to have repeating variable width */
        /* subfields, but I don't have any samples, so I ignore it for */
        /* now. */
        /*                                                                      */
        /*
         * The file data/cape_royal_AZ_DEM/1183XREF.DDF has a
         * repeating
         */
        /* variable length field, but the count is one, so it isn't */
        /* much value for testing. */
        /* -------------------------------------------------------------------- */
        var iOffset = 0;
        var iRepeatCount = 1
        var nBytesConsumed: Int?

        while (true) {
            for iSF in 0..<fieldDefinition.subfieldCount {
                do {
                    let poThisSFDefn = try fieldDefinition.getSubfield(i: iSF)

                    if (poThisSFDefn.formatWidth > data.count - iOffset) {
                        nBytesConsumed = poThisSFDefn.formatWidth
                    } else {
                        var tempData = [UInt8](repeating: 0, count: (data.count - iOffset))
                        tempData = Array(data[iOffset...(iOffset+tempData.count)])
                        // void arraycopy(Object src, int srcPos, Object dest, int destPos, int length)
                        //System.arraycopy(data,iOffset,tempData,0,tempData.count);
                        _ = poThisSFDefn.getDataLength(pachSourceData: tempData,
                                                       nMaxBytes: tempData.count,
                                                       pnConsumedBytes: &nBytesConsumed)
                    }

                    iOffset += nBytesConsumed!
                    if (iOffset > data.count) {
                        return iRepeatCount - 1
                    }
                } catch {
                    print(error)
                }
            }

            if (iOffset > data.count - 2) {
                return iRepeatCount
            }

            iRepeatCount += 1
        }
    }
}


extension DDFField: CustomStringConvertible {
    public var description: String {
        var value = ""
        value.append("DDFField:\n" )
        value.append("    Tag = \(fieldDefinition.name ?? "")\n")

        if data.isEmpty {
            value.append("\tHeader offset = \(headerOffset)\n")
            value.append("\tData position = \(dataPosition ?? 0)\n")
            value.append("\tData length = \(dataLength ?? 0)\n")
        }

        if !subfields.isEmpty {
            for subfield in subfields {
                value.append("        \(subfield.description)")
            }
        }
        return value
    }
}

/**
 * Creates a string with variety of information about this field,
 * and all it's subfields is written to the given debugging file
 * handle. Note that field definition information (ala
 * DDFFieldDefn) isn't written.
 *
 * @return String containing info.
 */
public func toString() -> String {
//        StringBuffer buf = new StringBuffer("  DDFField:\n");
//        buf.append("\t = ").append().append("\n");
//        buf.append("\tDescription = ").append(poDefn.getDescription()).append("\n");
//        int size = getDataSize();
//        buf.append("\tDataSize = ").append(size).append("\n");
//

//
//        buf.append("\tData = ");
//        for (int i = 0; i < Math.min(size, 40); i++) {
//            if (data[i] < 32 || data[i] > 126) {
//                buf.append(" | ").append((char) data[i]);
//            } else {
//                buf.append(data[i]);
//            }
//        }
//
//        if (size > 40)
//        buf.append("...");
//        buf.append("\n");
//
//        /* -------------------------------------------------------------------- */
//        /* dump the data of the subfields. */
//        /* -------------------------------------------------------------------- */
//        if (Debug.debugging("iso8211.raw")) {
//            int iOffset = 0;
//            MutableInt nBytesConsumed = new MutableInt(0);
//
//            for (int nLoopCount = 0; nLoopCount < getRepeatCount(); nLoopCount++) {
//                if (nLoopCount > 8) {
//                    buf.append("      ...\n");
//                    break;
//                }
//
//                for i in 0..<poDefn.subfieldCount {
//                    byte[] subPachData = new byte[data.length - iOffset];
//                    System.arraycopy(data,
//                                     iOffset,
//                                     subPachData,
//                                     0,
//                                     subPachData.length);
//
//                    buf.append(poDefn.getSubfieldDefn(i).dumpData(subPachData,
//                                                                  subPachData.length));
//
//                    poDefn.getSubfieldDefn(i).getDataLength(subPachData,
//                                                            subPachData.length,
//                                                            nBytesConsumed);
//                    iOffset += nBytesConsumed.value;
//                }
//            }
//        } else {
//            buf.append("      Subfields:\n");
//
//            for (Enumeration enumeration = subfields.keys(); enumeration.hasMoreElements();) {
//                Object obj = subfields.get(enumeration.nextElement());
//
//                if (obj instanceof List) {
//                    for (Iterator it = ((List) obj).iterator(); it.hasNext();) {
//                        DDFSubfield ddfs = (DDFSubfield) it.next();
//                        buf.append("        ").append(ddfs.toString()).append("\n");
//                    }
//                } else {
//                    buf.append("        ").append(obj.toString()).append("\n");
//                }
//            }
//        }
//
//        return buf.toString();
    return ""
}

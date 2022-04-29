//
//  TerminalViewModel.swift
//  GlassBridge
//
//  Created by Christopher Alford on 28/2/22.
//

import SwiftUI
import IOKit
import IOKit.serial

protocol CommState {
    func didChangeRTS(to: Bool)
    func didChangeDTR(to: Bool)
}

class CommStateModel: ObservableObject {
    
    var delegate: CommState?
    
    @Published var ctsState: Bool = true {
        didSet {
            print("cts: \(ctsState)")
        }
    }
    @Published var dsrState: Bool = true {
        didSet {
            print("dsr: \(dsrState)")
        }
    }
    @Published var dtrState: Bool = false {
        didSet {
            delegate?.didChangeDTR(to: dtrState)
        }
    }
    @Published var rtsState: Bool = false {
        didSet {
            delegate?.didChangeRTS(to: rtsState)
        }
    }
}

class TerminalViewModel: ObservableObject, CommState {
    
    var terminalCommStateA: CommStateModel
    var terminalCommStateB: CommStateModel
    func didChangeRTS(to: Bool) {
        rtsState = to
    }
    
    func didChangeDTR(to: Bool) {
        dtrState = to
    }

    @Published var ports: [String] = []
    @Published var crlfState: Bool = true {
        didSet {
            print("crlfState: \(crlfState)")
        }
    }

    @Published var rawState: Bool = false {
        didSet {
            print("rawState: \(rawState)")
        }
    }
    
    @Published var selectedBaudRate: BaudRate = .bu4800 {
        didSet {
            print("selectedBaudRate: \(selectedBaudRate)")
        }
    }
    @Published var selectedBits: Bits = .bi8 {
        didSet {
            print("selectedBits: \(selectedBits)")
        }
    }
    @Published var selectedParity: Parity = .none {
        didSet {
            print("selectedparity: \(selectedParity)")
        }
    }
    @Published var selectedPortA: String = "" {
        didSet {
            print("selectedPortA: \(selectedPortA)")
        }
    }
    @Published var selectedPortB: String = "" {
        didSet {
            print("selectedPortB: \(selectedPortB)")
        }
    }
    @Published var selectedStopBits: StopBits = .sb0 {
        didSet {
            print("selectedStopBits: \(selectedStopBits)")
        }
    }
    
    var rtsState: Bool = false
    var dtrState: Bool = false

    init() {
        terminalCommStateA = CommStateModel()
        terminalCommStateB = CommStateModel()
        
        terminalCommStateA.delegate = self
        rtsState = terminalCommStateA.rtsState
        dtrState = terminalCommStateA.dtrState
        
        terminalCommStateB.delegate = self
        rtsState = terminalCommStateB.rtsState
        dtrState = terminalCommStateB.dtrState
        ports = findSerialPorts() ?? []
    }

    func findSerialPorts() -> [String]?
    {
        var portIterator: io_iterator_t = 0
        // Do we have any serial pports?
        let kernResult = serialDevicesExist(deviceType: kIOSerialBSDAllTypes, serialPortIterator: &portIterator)
        if kernResult == KERN_SUCCESS {
            // List available ports
            if let paths = findSerialPaths(portIterator: portIterator) {
                print(paths)
                return paths
            }
        }
        return nil
    }

    func serialDevicesExist(deviceType: String, serialPortIterator: inout io_iterator_t ) -> kern_return_t {
        var result: kern_return_t = KERN_FAILURE
        let classesToMatch = IOServiceMatching(kIOSerialBSDServiceValue) //.takeUnretainedValue()
        var classesToMatchDict = (classesToMatch! as NSDictionary)
            as! Dictionary<String, AnyObject>
        classesToMatchDict[kIOSerialBSDTypeKey] = deviceType as AnyObject
        let classesToMatchCFDictRef = (classesToMatchDict as NSDictionary) as CFDictionary
        result = IOServiceGetMatchingServices(kIOMainPortDefault, classesToMatchCFDictRef, &serialPortIterator);
        return result
    }

    func findSerialPaths(portIterator: io_iterator_t) -> [String]? {
        var paths = [String]()
        var serialService: io_object_t
        repeat {
            serialService = IOIteratorNext(portIterator)
            if (serialService != 0) {
                let key: CFString! = "IOCalloutDevice" as CFString
                let bsdPathAsCFtring: AnyObject? =
                    IORegistryEntryCreateCFProperty(serialService, key, kCFAllocatorDefault, 0).takeUnretainedValue()
                let bsdPath = bsdPathAsCFtring as! String?
                if let path = bsdPath {
                    paths.append(path)
                }
            }
        } while serialService != 0;
        return paths
    }
    
    func connect() {
        print("Connecting...")
        print("Using")
        print("RTS: \(rtsState)")
        print("DTR: \(dtrState)")
        
    }
}

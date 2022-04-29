//
//  StreamConnection.swift
//  XBridge
//
//  Created by Christopher Alford on 01.05.20.
//  Copyright © 2020 Digital+Marine. All rights reserved.
//

import AppKit
import CoreData

class StreamConnection: NSObject {

    fileprivate let settings: WiFiConnection

    weak var delegate: TCPConnection?

    fileprivate let connectionTimeout = 30.0

    fileprivate var connectedIn = false
    fileprivate var connectedOut = false

    fileprivate var inputStream: InputStream?
    fileprivate var outputStream: OutputStream?

    var logging: Bool = true
    fileprivate var previousSentence = ""
    fileprivate var startSentence: String?
    fileprivate var endSentence: String?

    init(connectionSettings: WiFiConnection) {
        self.settings = connectionSettings
    }

    /// Stream methods
    func connect() {
        var connectionTimer: Timer!
        var readStream:  Unmanaged<CFReadStream>?
        var writeStream: Unmanaged<CFWriteStream>?

        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault,
                                           settings.ip4Address as CFString,
                                           UInt32(settings.port)!,
                                           &readStream,
                                           &writeStream)

        self.inputStream = readStream!.takeUnretainedValue()
        self.outputStream = writeStream!.takeUnretainedValue()

        self.inputStream!.delegate = self
        self.outputStream!.delegate = self

        self.inputStream!.schedule(in: RunLoop.current, forMode: RunLoop.Mode.default)
        self.outputStream!.schedule(in: RunLoop.current, forMode: RunLoop.Mode.default)

        self.inputStream!.open()
        self.outputStream!.open()

        connectionTimer = Timer(timeInterval: connectionTimeout, target: self, selector:#selector(StreamConnection.checkTimers), userInfo: nil, repeats: true)
        RunLoop.current.add(connectionTimer, forMode: RunLoop.Mode.default)
    }

    // Write to Roving Networks device
    func send(_ buf: String) { //UnsafePointer<UInt8>

        // You have to convert the string to UTF-8 data first
        let data = buf.data(using: String.Encoding.utf8, allowLossyConversion: false)!

        // and then write it to the output stream
        //OLD Swift - let bytesWritten = self.outputStream?.write(UnsafePointer((data as NSData).bytes), maxLength: data.count)
        //Do we need to know the number of bytes written?let bytesWritten = data.withUnsafeBytes { outputStream?.write($0, maxLength: data.count) }
        let bytesWritten = data.withUnsafeBytes { outputStream?.write($0, maxLength: data.count) }

        // The UnsafePointer() cast is necessary because data.bytes has the type UnsafePointer<Void>,
        // and not UnsafePointer<UInt8> as expected by the write() method.

        //print("Written \(String(describing: bytesWritten)) : \(buf)")
    }

    func disconnect() {
        self.inputStream?.close()
        self.outputStream?.close()
    }

    @objc fileprivate func checkTimers() {
        if (!connectedIn) {
            delegate?.status("Input Connection is not connected")
        }
        if (!connectedOut) {
            delegate?.status("Output Connection is not connected")
        }
    }
}

extension StreamConnection: StreamDelegate {
    
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {

        switch(eventCode) {

        case Stream.Event.openCompleted:
            delegate?.status("NSStreamEvent.OpenCompleted")
            if(aStream == self.inputStream) {
                delegate?.status("Input stream open completed OK")
                connectedIn = true
            }
            if(aStream == self.outputStream) {
                delegate?.status("Output stream open completed OK")
                connectedOut = true
            }

        case Stream.Event.hasBytesAvailable:
            delegate?.status("NSStreamEvent.HasBytesAvailable")

            // Local buffer for stream read, len is actual ASCII bytes read
            var buffer = [UInt8](repeating: 0, count: 1024) //uint8_t buffer[1024];
            var len = 0              //NSInteger len =0;

            len = inputStream!.read(&buffer, maxLength: buffer.count) //len = [(NSInputStream *)stream read:buffer maxLength:sizeof(buffer)];

            var sentences: Array<String>

            if (len > 0){
                // Create temporary string for read data
                let aSentence = NSString(bytes: &buffer, length: len, encoding: String.Encoding.ascii.rawValue) //initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
                print("Raw sentence : \(String(describing: aSentence))")

                // Split this up using CR & NL character pair
                sentences = aSentence!.components(separatedBy: "\r\n")

                // Iterate through array combining objects to make complete sentences
                for sentence in sentences {
                    print("Processing sentence : \(sentence)")
                    // If the sentence contains a $ character split at this position
                    // appending start onto previous sentence.
                    // Process previous sentence
                    // Replace previous sentence with end and loop

                    var splitHere = -1
                    //var startSentence: NSString?
                    //var endSentence: NSString?
                    var i = 0

                    for char: Character in sentence {
                        if char == "$" {
                            splitHere = i
                            break
                        }
                        i = i + 1
                    }

                    // If the split is at the beginning of the sentence then process the previous sentence
                    if splitHere == 0 {
                        //NSLog(@"Process this >>> %@", previousSentence);
                        if (self.logging) {
                            //TODO: Fix bug here - If no connection before logging starts
                            // There isn't a previousSentance!
                            //TODO: NMEA0813Base.insert(sentence: self.previousSentence)
                            delegate?.received(sentence)
                        }
                        // You can now start a new previousSentence using this endSentence
                        // as you don't know if it is split

                        self.endSentence = sentence.substring(from: sentence.index(sentence.startIndex, offsetBy: splitHere))
                        //NSLog(@"New End   : %@", endSentence);
                        self.previousSentence = self.endSentence!
                        //NSLog(@"New Previous : %@", previousSentence);
                    } else if splitHere == -1 {
                        // Deal with sentences without a start
                        self.endSentence = sentence
                        self.previousSentence = self.previousSentence + self.endSentence!
                        //NSLog(@"New end appended Previous : %@", previousSentence);
                    } else {
                        // As the sentence started mid way, append the start to previous and process
                        self.startSentence = sentence.substring(to: sentence.index(sentence.startIndex, offsetBy: splitHere))
                        //NSLog(@"New Start : %@", startSentence);
                        self.previousSentence = self.previousSentence + self.startSentence!
                        //NSLog(@"Process this >>> %@", previousSentence);
                        if (self.logging) {
                            //TODO: NMEA0813Base.insert(sentence: self.previousSentence)
                            delegate?.received(sentence)
                        }
                        // then save the end part for the next loop
                        endSentence = sentence.substring(from: sentence.index(sentence.startIndex, offsetBy: splitHere))
                        self.previousSentence = self.endSentence!
                        //NSLog(@"New end appended to previous : %@", previousSentence);
                    } // End If..Else
                }
            }

        case Stream.Event.errorOccurred:
            if(aStream == self.inputStream) {
                delegate?.status("An error occured on the input stream")
            }
            if(aStream == self.outputStream) {
                delegate?.status("An error occured on the output stream")
            }

        case Stream.Event.endEncountered:
            print("EVENT: End encountered.");
            self.inputStream?.close()
            self.outputStream?.close()
            self.inputStream!.remove(from: RunLoop.current, forMode:RunLoop.Mode.default)
            self.outputStream!.remove(from: RunLoop.current, forMode:RunLoop.Mode.default)
            self.inputStream = nil;
            self.outputStream = nil;
            connectedIn = false
            connectedOut = false

        case Stream.Event.hasSpaceAvailable:
            delegate?.status("EVENT: Has space available.")

        case Stream.Event():
            delegate?.status("NSStreamEvent.None produced")

        default:
            delegate?.status("Unknown NSStreamEvent!")
        }
    }
}

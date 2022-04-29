//
//  WiFiConnectionViewModel.swift
//  GlassBridge
//
//  Created by Christopher Alford on 3/3/22.
//

import CoreData
import Foundation

class WiFiConnectionViewModel: ObservableObject {
    
    @Published var currentConnection: WiFiConnection
    @Published var connections: [WiFiConnection] = []
    
    init() {
        currentConnection = WiFiConnection(ip4Address: "0.0.0.0", port: "2000")
        if fetch() {
            if connections.count > 0 {
                currentConnection = connections[0]
            }
        }
    }
    
    func addConnection() {
        print("Adding connection")
        currentConnection = WiFiConnection(ip4Address: "0.0.0.0", port: "2000")
    }

    func updateConnection() {
        print("Updating connection")
        currentConnection.save(completion: { success in
            if !success {
                print("Couldn't save connection")
            } else {
                _ = fetch()
            }
        })
    }

    func removeConnection() {
        print("Removing connection")
        currentConnection.remove()
    }

    lazy var viewContext: NSManagedObjectContext? = {
        return PersistenceController.shared.container.viewContext
    }()
}

extension WiFiConnectionViewModel {
    /// CoreData methods

    func fetch() -> Bool {
        connections.removeAll()
        // If we have a NMEASettings entity read it
        let request: NSFetchRequest<NMEASettings> = NMEASettings.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "modifiedOn", ascending: false)]

        // Execute the fetch request on the context
        var settings: [NMEASettings]?
        do {
            settings = try viewContext?.fetch(request)
        }
        catch {
            print(error)
            return false
        }

        /* Make sure we get the array */
        if settings?.count ?? 0 > 0 {
            print("Found \(settings?.count ?? 0) NMEASettings")
            var foundConnections = [WiFiConnection]()
            for setting in settings! {
                //if let _ip = setting.ip4Address, let _port = setting.portNumber {
                var connection = WiFiConnection(ip4Address: setting.ip4Address ?? "", port: setting.port ?? "")
                connection.id = setting.id ?? UUID()
                connection.name = setting.deviceDescription ?? "none"
                foundConnections.append(connection)
                // Add the optional connection description, e.g. "usb-c hub port A"
                //                    if let _description = setting.portDescription {
                //                        connection.portDescription = _description
                //                    }

                // Update the connection type if its known
                //                    if setting.via > 0 {
                //                        connection.via = Connection.ConnectionType(rawValue: Int(setting.via))!
                //                    }

                // Add the optional device description, e.g. "NMEA Tools - NMEA0183 WI-FI GATEWAY"
                //                    if let _description = setting.deviceDescription {
                //                        connection.deviceDescription = _description
                //                    }

                //}
            }
            self.connections.append(contentsOf: foundConnections)
            return true
        }
        return false
    }
}

//
//  WiFiConnection.swift
//  GlassBridge
//
//  Created by Christopher Alford on 6/3/22.
//

import CoreData
import Foundation

struct WiFiConnection: Identifiable, Hashable {
    var id: UUID
    var name: String
    var ip4Address: String
    var port: String
    var direction: ConnectionDirection = .inbound

    var backgroundContext: NSManagedObjectContext

    init(ip4Address: String, port: String) {
        backgroundContext = PersistenceController.shared.container.newBackgroundContext()
        id = UUID()
        name = ""
        self.ip4Address = ip4Address
        self.port = port
    }
}

extension WiFiConnection {

    func save(completion: (Bool) -> Void) {
        var savedSetting: NMEASettings
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NMEASettings")
        request.predicate = NSPredicate(format: "id == %@", self.id as CVarArg)
        var results: [NMEASettings] = []
        do {
            results = try backgroundContext.fetch(request) as! [NMEASettings]
        } catch {
            print("Failed to fetch NMEASettings: \(error)")
            completion(false)
        }
        if results.count > 0 {
            savedSetting = results.first!
            savedSetting.id = self.id
            savedSetting.ip4Address = self.ip4Address
            savedSetting.port = self.port
            //savedSetting.via = Int16(connection.via.rawValue)
            //savedSetting.portDescription = connection.portDescription
            savedSetting.deviceDescription = self.name
            if self.direction.rawValue.isEmpty  {
                savedSetting.direction = ConnectionDirection.inbound.rawValue
            } else {
                savedSetting.direction = self.direction.rawValue
            }
            savedSetting.modifiedOn = Date()
        } else {
            savedSetting = NSEntityDescription.insertNewObject(forEntityName: "NMEASettings", into: backgroundContext) as! NMEASettings
            savedSetting.id = self.id
            savedSetting.ip4Address = self.ip4Address
            savedSetting.port = self.port
            //savedSetting.via = Int16(connection.via.rawValue)
            //savedSetting.portDescription = connection.portDescription
            savedSetting.deviceDescription = self.name
            if self.direction.rawValue.isEmpty  {
                savedSetting.direction = ConnectionDirection.inbound.rawValue
            } else {
                savedSetting.direction = self.direction.rawValue
            }
            savedSetting.modifiedOn = Date()
        }

        do {
            try backgroundContext.save()
            completion(true)
        } catch {
            print("Failed to save NMEASettings. Error = \(error)")
            completion(false)
        }
    }

    func remove() {
        // find by connectionID
        let connectionsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "NMEASettings")
        connectionsFetch.predicate = NSPredicate(format: "id == %@", self.id as CVarArg)
        do {
            let results = try backgroundContext.fetch(connectionsFetch) as! [NMEASettings]
            let setting = results.first!
            backgroundContext.delete(setting)
            try backgroundContext.save()
        } catch {
            fatalError("Failed to delete NMEASettings: \(error)")
        }
    }

    func removeAll() {
        // If we have any sentences read them all
        let request: NSFetchRequest<NMEASettings> = NMEASettings.fetchRequest()

        // Execute the fetch request on the context
        guard let settings = ((try? backgroundContext.fetch(request)) as [NMEASettings]??)
        else {
            print("Could not find any NMEASettings entities in the context")
            return
        }

        /* Make sure we get the array */
        if (settings?.count)! > 0 {

            for setting in settings!{
                backgroundContext.delete(setting)
            }

        }

        do {
            try backgroundContext.save()
        } catch let error as NSError {
            print("Failed to save NMEASettings. Error = \(error.localizedDescription)")
        }
    }

}


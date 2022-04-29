//
//  GlassBridgeApp.swift
//  Shared
//
//  Created by Christopher Alford on 28/4/22.
//

import SwiftUI

@main
struct GlassBridgeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

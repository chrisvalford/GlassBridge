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
#if os(macOS)
    @State private var isShowingTerminal = false
#endif
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
#if os(macOS)
                .sheet(isPresented: $isShowingTerminal, content: {
                    TerminalContainerView()
                        .padding(8)
                        .frame(minWidth: 500, maxWidth: .infinity, minHeight: 600, maxHeight: .infinity)
                })
#endif
        }
        
#if os(macOS)
        .commands {
            CommandMenu("Serial") {
                Button("Terminal") { isShowingTerminal.toggle() }
                    .keyboardShortcut(KeyEquivalent("t"), modifiers: .option)
            }
        }
#endif
    }
}

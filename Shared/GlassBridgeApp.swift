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
    @NSApplicationDelegateAdaptor private var appDelegate: AppDelegate_macOS
#endif
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        
#if os(macOS)
        .commands {
            CommandMenu("Serial") {
                Button("Terminal") {
                    //                    isShowingTerminal.toggle()
                    NSApp.sendAction(#selector(AppDelegate_macOS.openTerminalWindow), to: nil, from:nil)
                }
                .keyboardShortcut(KeyEquivalent("t"), modifiers: .option)
            }
            CommandMenu("Instruments") {
                Button("Wind") {
                    NSApp.sendAction(#selector(AppDelegate_macOS.openInstrumentsWindow), to: nil, from:nil)
                }
                .keyboardShortcut(KeyEquivalent("w"), modifiers: .option)
            }
        }
#endif
    }
}

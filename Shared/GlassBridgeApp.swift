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
    @NSApplicationDelegateAdaptor private var appDelegate: AppDelegate
    //@State private var isShowingTerminal = false
    @State private var isShowingWind = false
#endif
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
#if os(macOS)
//                .sheet(isPresented: $isShowingTerminal, content: {
//                    TerminalContainerView()
//                        .padding(8)
//                        .frame(minWidth: 500, maxWidth: .infinity, minHeight: 600, maxHeight: .infinity)
//                })
                .sheet(isPresented: $isShowingWind, content: {
                    WindAngleInstrumentView()
                        .padding(8)
                        .frame(minWidth: 600, maxWidth: .infinity, minHeight: 600, maxHeight: .infinity)
                })
#endif
        }
        
#if os(macOS)
        .commands {
            CommandMenu("Serial") {
                Button("Terminal") {
                    //                    isShowingTerminal.toggle()
                    NSApp.sendAction(#selector(AppDelegate.openTerminalWindow), to: nil, from:nil)
                }
                .keyboardShortcut(KeyEquivalent("t"), modifiers: .option)
            }
            CommandMenu("Instruments") {
                Button("Wind") { isShowingWind.toggle() }
                    .keyboardShortcut(KeyEquivalent("w"), modifiers: .option)
            }
        }
#endif
    }
}

//
//  AppDelegate.swift
//  MacOSUI
//
//  Created by Christopher Alford on 12/10/23.
//

import AppKit
import SwiftUI

class AppDelegate_macOS: NSObject, NSApplicationDelegate, ObservableObject {
    var terminalWindow: NSWindow!
    var instrumentsWindow: NSWindow!

    func application(
        _ application: NSApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        print("Your code here")
        // Record the device token.
    }

    @MainActor
    @objc
    func openTerminalWindow() {
        if nil == terminalWindow {
            let terminalView = TerminalContainerView()
            terminalWindow = NSWindow(
                contentRect: NSRect(x: 20, y: 20, width: 480, height: 300),
                styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                backing: .buffered,
                defer: false)
            terminalWindow.center()
            terminalWindow.setFrameAutosaveName("Preferences")
            terminalWindow.isReleasedWhenClosed = false
            terminalWindow.contentView = NSHostingView(rootView: terminalView)
        }
        terminalWindow.makeKeyAndOrderFront(nil)
    }

    @MainActor
    @objc
    func openInstrumentsWindow() {
        if nil == instrumentsWindow {
            let instrumentsView = InstrumentsContainerView()
            instrumentsWindow = NSWindow(
                contentRect: NSRect(x: 20, y: 20, width: 480, height: 300),
                styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                backing: .buffered,
                defer: false)
            instrumentsWindow.center()
            instrumentsWindow.setFrameAutosaveName("Preferences")
            instrumentsWindow.isReleasedWhenClosed = false
            instrumentsWindow.contentView = NSHostingView(rootView: instrumentsView)
        }
        instrumentsWindow.makeKeyAndOrderFront(nil)
    }

}

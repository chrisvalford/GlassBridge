//
//  AppDelegate.swift
//  MacOSUI
//
//  Created by Christopher Alford on 12/10/23.
//

import AppKit
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    var terminalWindow: NSWindow!

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
            if nil == terminalWindow {      // create once !!
                let terminalView = TerminalContainerView()
                // Create the preferences window and set content
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

}

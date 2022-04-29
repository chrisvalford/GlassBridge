//
//  TerminalView.swift
//  GlassBridge
//
//  Created by Christopher Alford on 28/2/22.
//

import SwiftUI

struct TerminalContainerView: View {
    var body: some View {
        VStack {
            TabView {
                TerminalView()
                .tabItem {
                    Label("Terminal", systemImage: "terminal")
                    
                }
                ProtocolAnalyzerView()
                .tabItem {
                    Text("Protocol Analyzer")
                }
                MonitorView()
                .tabItem {
                    Text("Monitor")
                }
                NMEAView()
                .tabItem {
                    Text("NMEA")
                }
            }
        }
    }
}

struct TerminalContainerView_Previews: PreviewProvider {
    static var previews: some View {
        TerminalView()
    }
}

//
//  TerminalView.swift
//  GlassBridge
//
//  Created by Christopher Alford on 28/2/22.
//

import SwiftUI

struct TerminalContainerView: View {
//    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            TabView {
                TerminalView()
                .tabItem {
                    Text("Terminal")
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
//            Button("Close") {
//                dismiss()
//            }
        }
        .frame(minWidth: 520, minHeight: 300)
    }
}

struct TerminalContainerView_Previews: PreviewProvider {
    static var previews: some View {
        TerminalView()
    }
}

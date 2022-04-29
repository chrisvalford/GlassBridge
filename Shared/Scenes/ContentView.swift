//
//  ContentView.swift
//  Shared
//
//  Created by Christopher Alford on 28/2/22.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        
        NavigationView {
            GPSView()
                .padding()
                .navigationTitle("GlassBridge")
                .toolbar {
#if os(iOS)
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {}) {
                            Label("Charts", systemImage: "map")
                        }
                    }
#elseif os(macOS)
                    ToolbarItem {
                        Button(action: {}) {
                            Label("Charts", systemImage: "map")
                        }
                    }
#endif
                }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

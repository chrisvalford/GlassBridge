//
//  ContentView.swift
//  Shared
//
//  Created by Christopher Alford on 28/2/22.
//

import SwiftUI
#if os(iOS)
import UIKit
#endif
import CoreData

struct ContentView: View {
    
    @StateObject private var observed = Observed()
    @State private var isActive = false
    
    let maps: [String] = ["RYA_TC4_B", "NNWE", "RYA_TC4_E"]
    
    var body: some View {
        
        NavigationView {
            VStack {
                ScrollView {
                    GPSView()
                        .background(Color.gray)
                }
                List(maps, id: \.self) { path in
                    NavigationLink(destination: DetailView(path: path), isActive: $isActive) {
                        Text(path)
                    }
                }
            }
        }
        .onAppear {
            self.isActive = true
        }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension Image {
    func data(url: URL) -> Self? {
        do {
            let data = try Data(contentsOf: url)
#if os(iOS)
        guard let uiImage = UIImage(data: data) else {
            print("Invalid UIImage")
            return nil
        }
        return Image(uiImage: uiImage)
            .resizable()
#elseif os(macOS)
        guard let nsImage = NSImage(data: data) else {
            print("Invalid NSImage")
            return nil
        }
        return Image(nsImage: nsImage)
                .resizable()
#endif
        } catch {
            print(error)
            return nil
        }
    }
}


struct DetailView: View {
    
    var path: String
    @State var image = Image(systemName: "map")

    var body: some View {
        Text("Detail view")
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onAppear {
                guard let path = Bundle.main.path(forResource: path, ofType: "jpg") else { return
                }
                print(path)
                guard let url = URL(string: "file://" + path)  else {
                    return
                }
                guard let img = Image(systemName: "map").data(url: url) else {
                    return
                }
                self.image = img
            }
    }
}

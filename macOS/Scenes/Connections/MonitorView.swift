//
//  MonitorView.swift
//  GlassBridge
//
//  Created by Christopher Alford on 2/3/22.
//

import SwiftUI

struct MonitorView: View {

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(0..<100, id: \.self) { n in
                    Text("Line \(n)")
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

struct MonitorView_Previews: PreviewProvider {
    static var previews: some View {
        MonitorView()
    }
}

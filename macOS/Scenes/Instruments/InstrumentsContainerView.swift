//
//  InstrumentsContainerView.swift
//  GlassBridge (macOS)
//
//  Created by Christopher Alford on 12/10/23.
//  Copyright © 2023 marine.digital. All rights reserved.
//

import SwiftUI

struct InstrumentsContainerView: View {
    var body: some View {
        //TODO: Add/remove instrument and layout code
        WindAngleInstrumentView()
        .padding(8)
        .frame(minWidth: 600, maxWidth: .infinity, minHeight: 600, maxHeight: .infinity)
    }
}

#Preview {
    InstrumentsContainerView()
}

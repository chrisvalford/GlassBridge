//
//  CommStateView.swift
//  GlassBridge
//
//  Created by Christopher Alford on 2/3/22.
//

import SwiftUI

struct CommStateView: View {
    @ObservedObject var viewModel: CommStateModel
    
    var body: some View {
        GroupBox {
            HStack(spacing: 16) {
                Toggle(isOn: $viewModel.rtsState) {
                    Text("RTS")
                }
                .toggleStyle(CheckboxToggleStyle())
                Toggle(isOn: $viewModel.dtrState) {
                    Text("DTR")
                }
                .toggleStyle(CheckboxToggleStyle())
                
                // These two need to be LED style indicators
                Toggle(isOn: $viewModel.ctsState) {
                    Text("CTS")
                }
                .toggleStyle(CheckboxToggleStyle())
                Toggle(isOn: $viewModel.dsrState) {
                    Text("DSR")
                }
                .toggleStyle(CheckboxToggleStyle())
            }
        }.padding(.horizontal, 32)
    }
}

struct CommStateView_Previews: PreviewProvider {
    static let model = CommStateModel()
    static var previews: some View {
        CommStateView(viewModel: model)
    }
}

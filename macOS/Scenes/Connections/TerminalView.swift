//
//  TerminalView.swift
//  GlassBridge
//
//  Created by Christopher Alford on 28/2/22.
//

import SwiftUI

@MainActor struct TerminalView: View {

    @ObservedObject var viewModel = TerminalViewModel()

    // View State
    @State var designator = ""

    var body: some View {
        Form {
            VStack {
                VStack {
                    HStack {
                        Picker("Serial Port", selection: $viewModel.selectedPortA) {
                            ForEach(viewModel.ports, id: \.self) {
                                Text($0)
                            }
                        }
                        Picker(selection: $viewModel.selectedBaudRate,
                                               label: Text("Baud Rate")) {
                            ForEach(Array(BaudRate.allCases)) {
                                Text($0.string)
                                    .tag($0)
                            }
                        }
                        VStack {
                            Toggle(isOn: $viewModel.crlfState) {
                                Text("cr/lf")
                            }
                            .toggleStyle(CheckboxToggleStyle())
                            Toggle(isOn: $viewModel.rawState) {
                                Text("raw")
                            }
                            .toggleStyle(CheckboxToggleStyle())
                        }
                    }
                    HStack {
                        Picker(selection: $viewModel.selectedBits,
                                               label: Text("Bits")) {
                            ForEach(Array(Bits.allCases)) {
                                Text($0.string)
                                    .tag($0)
                            }
                        }
                        Picker("Parity", selection: $viewModel.selectedParity) {
                            ForEach(Parity.allCases, id: \.self) {
                                Text($0.rawValue).tag($0)
                            }
                        }
                        
                        Picker(selection: $viewModel.selectedStopBits,
                                               label: Text("Stop Bits")) {
                            ForEach(Array(StopBits.allCases)) {
                                Text($0.string)
                                    .tag($0)
                            }
                        }
                        Text(" ")
                    }
                    HStack {
                        CommStateView(viewModel: viewModel.terminalCommStateA)
                        Spacer()
                        ProgressView()
                            .progressViewStyle(.circular)
                            .scaleEffect(0.6)
                        Spacer()
                        Button("Connect") {
                            viewModel.connect()
                        }
                    }
                }
            }
            .padding()
            ScrollView {

            }
            .padding()
        }
    }
}

struct TerminalView_Previews: PreviewProvider {
    static var previews: some View {
        TerminalView()
    }
}

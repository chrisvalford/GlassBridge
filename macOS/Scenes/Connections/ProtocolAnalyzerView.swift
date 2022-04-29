//
//  ProtocolAnalyserView.swift
//  GlassBridge
//
//  Created by Christopher Alford on 2/3/22.
//

import SwiftUI

struct ProtocolAnalyzerView: View {
    @ObservedObject var viewModel = TerminalViewModel()

    // View State
    @State var designator = ""

    var body: some View {
        Form {
            VStack {
                VStack {
                    HStack {
                        VStack {
                            GroupBox {
                                Picker("Serial Port A", selection: $viewModel.selectedPortA) {
                                    ForEach(viewModel.ports, id: \.self) {
                                        Text($0)
                                    }
                                }
                                CommStateView(viewModel: viewModel.terminalCommStateA)
                            }
                        }
                        
                        GroupBox {
                            VStack {
                                Picker("Serial Port B", selection: $viewModel.selectedPortB) {
                                    ForEach(viewModel.ports, id: \.self) {
                                        Text($0)
                                    }
                                }
                                CommStateView(viewModel: viewModel.terminalCommStateB)
                            }
                        }
                        VStack(alignment: .leading) {
                            
                            Toggle(isOn: $viewModel.rawState) {
                                Text("Raw")
                            }
                            .toggleStyle(CheckboxToggleStyle())
                            Toggle(isOn: $viewModel.crlfState) {
                                Text("Auto RTS")
                            }
                            .toggleStyle(CheckboxToggleStyle())
                        }
                    }
                    HStack {
                        Picker(selection: $viewModel.selectedBaudRate,
                               label: Text("Baud Rate")) {
                            ForEach(Array(BaudRate.allCases)) {
                                Text($0.string)
                                    .tag($0)
                            }
                        }
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

struct ProtocolAnalyzerView_Previews: PreviewProvider {
    static var previews: some View {
        ProtocolAnalyzerView()
    }
}

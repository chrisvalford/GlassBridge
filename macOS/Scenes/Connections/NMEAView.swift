//
//  NMEAView.swift
//  GlassBridge
//
//  Created by Christopher Alford on 2/3/22.
//

import SwiftUI

struct NMEAView: View {
    
    @ObservedObject var viewModel = TerminalViewModel()
    
    var body: some View {
        Form {
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
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(0.6)
                    Spacer()
                    Button("Connect") {
                        viewModel.connect()
                    }
                }
                HStack {
                    Group {
                        HStack {
                            Text("dd/mm/yy")
                            Text("hh:mm:ss UTC")
                        }
                    }
                    .fixedSize(horizontal: true, vertical: false)
                    .frame(minWidth: 200)
                    .padding(8)
                    .border(.black)
                    Text("NOT CONNECTED")
                        .fixedSize(horizontal: true, vertical: false)
                        .frame(minWidth: 200)
                        .padding(8)
                }
                HStack {
                    Group {
                        HStack {
                            Text("nnº nn.nnn' N")
                            Text("nnº nn.nnn' W")
                        }
                    }
                    .fixedSize(horizontal: true, vertical: false)
                    .frame(minWidth: 200)
                    .padding(8)
                    .border(.black)
                    Group {
                        HStack {
                            Text("Altitude")
                            Text("nnn")
                        }
                    }
                    .fixedSize(horizontal: true, vertical: false)
                    .frame(minWidth: 200)
                    .padding(8)
                    .border(.black)
                    
                }
                
                HStack {
                    Text("No fix.")
                        .padding(8)
                    Text("Satellites")
                        .padding(8)
                    Text("Satellites")
                        .padding(8)
                    Text("Precision")
                        .padding(8)
                }
            }
        }
    }
}

struct NMEAView_Previews: PreviewProvider {
    static var previews: some View {
        NMEAView()
    }
}

//
//  WiFiConnection.swift
//  GlassBridge
//
//  Created by Christopher Alford on 3/3/22.
//

import SwiftUI

struct WiFiConnectionView: View {
    
    @ObservedObject var viewModel = WiFiConnectionViewModel()
    @State private var isEditing = false
    
    var body: some View {
        
        HStack(alignment: .top) {

            List(viewModel.connections, id: \.self) { item in
                Text(item.name)
                    .gesture(TapGesture()
                                .onEnded({ _ in
                        viewModel.currentConnection = item
                    }))
            }
            .listStyle(.inset(alternatesRowBackgrounds: true))

            VStack {
                Form {
                    TextField("Name", text: $viewModel.currentConnection.name)
                        .textFieldStyle(.roundedBorder)
                        .padding(8)
                    TextField("IP4 Address", text: $viewModel.currentConnection.ip4Address)
                        .textFieldStyle(.roundedBorder)
                        .padding(8)
                    TextField("Port", text: $viewModel.currentConnection.port)
                        .textFieldStyle(.roundedBorder)
                        .padding(8)
                    Picker("Direction", selection: $viewModel.currentConnection.direction) {
                        ForEach(ConnectionDirection.allCases, id: \.self) {
                            Text($0.rawValue).tag($0)
                        }
                    }
                    .padding(8)
                }
                Spacer()
                HStack {
                    Spacer()
                    if isEditing == true {
                        Button {
                            viewModel.updateConnection()
                        } label: {
                            Text("Save")
                        }
                        .buttonStyle(.bordered)
                    }
                    Button {
                        viewModel.addConnection()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(.bordered)
                    .padding()
                    Button {
                        viewModel.removeConnection()
                    } label: {
                        Image(systemName: "minus")
                    }
                    .buttonStyle(.bordered)
                    .padding()
                }
            }
        }
    }
}


struct WiFiConnection_Previews: PreviewProvider {
    static let viewModel = WiFiConnectionViewModel()
    static var previews: some View {
        WiFiConnectionView(viewModel: viewModel)
    }
}

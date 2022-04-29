//
//  GPSView.swift
//  GlassBridge
//
//  Created by Christopher Alford on 02.06.20.
//

import SwiftUI
import Combine

struct GPSView: View {

    @StateObject private var observed = Observed()

    var body: some View {
        HStack {
        VStack {
            Group() {
                HStack {
                    VStack{
                        Text("GPS:")
                        Text("Time:")
                        Text("Local:").foregroundColor(.blue)
                        Text("Time:").foregroundColor(.blue)
                    }
                    VStack{
                        Text("07:01:02 UTC")
                        Text("01/06/2020")
                        Text("11:25:24 PM").foregroundColor(.blue)
                        Text("31/05/220").foregroundColor(.blue)
                    }
                }
            }
            Divider()
            Group() {
                HStack {
                    VStack{
                        Text("Lat:")
                        Text("Lon:")
                    }
                    VStack{
                        Text(observed.rmcLatitude.dmsString(padded: false) + " " + observed.rmcLatitudeDirection)
                        Text(observed.rmcLongitude.dmsString(padded: false) + " " + observed.rmcLongitudeDirection)
                        //Text(gll.latitude.dmsString(padded: false) + " " + gll.latitudeDirection)
                        //Text(gll.longitude.dmsString(padded: false) + " " + gll.longitudeDirection)
                    }
                }
            }
            Group() {
                Divider()
                HStack {
                    VStack{
                        Text("HDG:")
                        Text("COG:")
                        Text("SOG:")
                        Text("STW:")
                    }
                    VStack{
                        Text("136º T")
                        Text("159º T")
                        Text(observed.rmcSogKn.description + " kt")
                        Text("6.1 kt")
                    }
                }
            }
            Group() {
                Divider()
                HStack {
                    VStack{
                        Text("AWS:")
                        Text("AWA:")
                        Text("TWS:")
                        Text("TWA:")
                        Text("TWD:")
                    }
                    VStack{
                        Text("17.5 kt")
                        Text("161º Port")
                        Text("21.6 kt")
                        Text("160º Port")
                        Text("337º T")
                    }
                }
            }
            Group() {
                Divider()
                HStack {
                    VStack{
                        Text("Depth:")
                    }
                    VStack{

                        Text("12.6 m")
                    }
                }
            }
            Group() {
                Divider()
                HStack {
                    VStack{
                        Text("GPS Source:")
                        Text("GPS Status:")
                        Text("AIS Status:").foregroundColor(.blue)
                        Text("LOG Status:").foregroundColor(.blue)
                    }
                    VStack{
                        Text("Primary")
                        Text("OK")
                        Text("3 Targets").foregroundColor(.blue)
                        Text("OK").foregroundColor(.blue)
                    }
                }
            }
        }
        .padding(.all)
        .border(/*@START_MENU_TOKEN@*/Color.gray/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
        }
    }
}

struct GPSView_Previews: PreviewProvider {
    static var previews: some View {
        GPSView()
    }
}

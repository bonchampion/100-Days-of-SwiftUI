//
//  ContentView.swift
//  Bucket List
//
//  Created by Bon Champion on 2/27/25.
//

import MapKit
import SwiftUI

struct ContentView: View {
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 40.7, longitude: -74),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    
    @State private var viewModel = ViewModel()
    @AppStorage("mapStyle") private var mapStyle = "standard"
   
    var body: some View {
        if viewModel.isUnlocked {
            VStack {
                MapReader { proxy in
                    Map(initialPosition: startPosition) {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onLongPressGesture(minimumDuration: 0.1) {
                                        viewModel.selectedPlace = location
                                    }
                            }
                        }
                    }
                    .mapStyle(mapStyle == "standard" ? .standard : .hybrid)
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                    .sheet(item: $viewModel.selectedPlace) { place in
                        EditView(location: place) {
                            viewModel.updateLocation(location: $0)
                        }
                    }
                }
                Picker("Map Style", selection: $mapStyle) {
                    Text("Hybrid").tag("hybrid")
                    Text("Standard").tag("standard")
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
            }
        } else {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
                .alert(viewModel.authFailText, isPresented: $viewModel.isShowingAuthFailAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text(viewModel.authFailSubtext)
                }
        }
            
    }
}

#Preview {
    ContentView()
}

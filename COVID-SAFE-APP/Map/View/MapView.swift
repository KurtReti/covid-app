//
//  MapView.swift
//  COVID-SAFE-APP
//
//  Created by Taylah Galea on 25/5/21.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @ObservedObject var viewModel: MapViewModel
    var markers: [Marker]
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region, annotationItems: markers) { marker in
            MapMarker(coordinate: marker.coordinate)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = MapViewModel(lat: 0, long: 0, latD: 0, longD: 0)
        let markers = [
            Marker(title: "", coordinate: .init(latitude: 0, longitude: 0))
        ]
        MapView(viewModel: viewModel, markers: markers)
    }
}

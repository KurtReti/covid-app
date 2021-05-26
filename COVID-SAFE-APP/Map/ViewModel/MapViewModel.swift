//
//  MapModelView.swift
//  COVID-SAFE-APP
//
//  Created by Taylah Galea on 25/5/21.
//

import Foundation
import MapKit

class MapViewModel: ObservableObject {
    @Published var region: MKCoordinateRegion
    
    init() {
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), span: MKCoordinateSpan(latitudeDelta: 0.30, longitudeDelta: 0.30))
    }
    
    init(lat: Double, long: Double, latD: Double, longD: Double) {
        self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: long), span: MKCoordinateSpan(latitudeDelta: latD, longitudeDelta: longD))
    }
    
    
}

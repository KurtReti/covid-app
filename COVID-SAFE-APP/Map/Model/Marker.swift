//
//  Marker.swift
//  COVID-SAFE-APP
//
//  Created by Taylah Galea on 25/5/21.
//

import Foundation
import CoreLocation

struct Marker: Identifiable {
    var id = UUID()
    var title: String
    var coordinate: CLLocationCoordinate2D
}


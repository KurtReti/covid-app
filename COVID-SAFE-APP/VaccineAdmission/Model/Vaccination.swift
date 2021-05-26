//
//  Vaccination.swift
//  COVID-APP
//
//  Created by Connor Jones on 20/5/21.
//

import SwiftUI
import Firebase
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Vaccination: Identifiable, Codable {
    let id: String
    let bookingID: String
    let individualID: String
    let healthCentreID: String
    let vaccineID: String
    let doseDate: String
    
    
}

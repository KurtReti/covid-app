//
//  VaccineBatch.swift
//  COVID-APP
//
//  Created by Connor Jones on 20/5/21.
//

import SwiftUI
import Firebase
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct VaccineBatch: Identifiable, Codable {
    let id: String
    let totalVaccines: Int
    let vaccineID: String
    let healthCentreID: String
    
}

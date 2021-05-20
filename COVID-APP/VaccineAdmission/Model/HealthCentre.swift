//
//  HealthCentre.swift
//  COVID-APP
//
//  Created by Connor Jones on 20/5/21.
//


import SwiftUI
import Firebase
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct HealthCentre: Identifiable, Codable {
    
    @DocumentID var id: String?
    let accessLevel: String
    let address: String
    let email: String
    let phoneNum: String
    var uid: String?
    // let doseDate: String
    
}

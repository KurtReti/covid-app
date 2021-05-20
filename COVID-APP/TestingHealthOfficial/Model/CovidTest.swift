//
//  CovidTest.swift
//  COVID-APP
//
//  Created by Connor Jones on 18/5/21.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift


struct CovidTest: Identifiable, Codable {
    let id: String
    let individualID: String
    let healthOfficialID: String
    let date: String
    let result: Bool
    let notes: String
    let bookingID: String
    let status: String
    
    
    
    
}

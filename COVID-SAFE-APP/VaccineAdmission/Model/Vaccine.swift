//
//  Vaccine.swift
//  COVID-APP
//
//  Created by Connor Jones on 20/5/21.
//
import SwiftUI
import Firebase
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Vaccine: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let dosageAmount: Int
    let manufacture: String
    
}

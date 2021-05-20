//
//  VisitDescription.swift
//  COVID-APP
//
//  Created by Connor Jones on 20/5/21.
//

import Foundation

import SwiftUI
import Firebase
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct VisitDescription: Identifiable, Codable {
    @DocumentID var id: String?
    let businessSignID: String
    let businessName: String
    let address: String
    let individualID: String
    var checkIn: String
    var checkOut: String?
    var active: Bool
    
    
}

//
//  Visit.swift
//  COVID-APP
//
//  Created by Connor Jones on 16/5/21.
//

import SwiftUI
import Firebase
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Visit: Identifiable, Codable {
    @DocumentID var id: String?
    let businessSignID: String
    let individualID: String
    var checkIn: String
    var checkOut: String?
    var active: Bool
    
    
}

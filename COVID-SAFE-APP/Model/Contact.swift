//
//  Contact.swift
//  COVID-APP
//
//  Created by Connor Jones on 24/5/21.
//

import SwiftUI
import Firebase
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Contact: Identifiable, Codable {
    var id: String?
    let businessSignID: String
    let dependants: [String]
    let individualID: String
    let signInDate: String
    let signOutDate: String
    let signInTime: String
    let signoutTime: String
    let signedOut: Bool
    
    
}

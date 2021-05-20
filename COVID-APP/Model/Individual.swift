//
//  Individual.swift
//  COVID-APP
//
//  Created by Connor Jones on 17/5/21.
//

import SwiftUI
import Firebase
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Individual: Identifiable, Codable {
    @DocumentID var id: String?
    let firstName: String
    let lastName: String
    let address: String
    let email: String
    let phoneNum: String
    let dob: String
    var uid: String?
    
    
}

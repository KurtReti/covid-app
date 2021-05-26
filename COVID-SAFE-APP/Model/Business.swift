//
//  Business.swift
//  COVID-APP
//
//  Created by Connor Jones on 16/5/21.
//

import SwiftUI
import Firebase
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Business: Identifiable, Codable {
    @DocumentID var id: String?
    let abn: Int
    let name: String
    let address: String
    let email: String
    let phoneNum: String
    let type: String
    var uid: String?
    
}

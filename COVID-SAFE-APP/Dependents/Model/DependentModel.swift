//
//  DependentModel.swift
//  COVID-APP
//
//  Created by Taylah Galea on 30/4/21.
//

import SwiftUI
import Firebase
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Dependent: Identifiable, Codable {
    @DocumentID var id: String?
    var individualID: String
    var first_name: String
    var last_name: String
    var address: String
    var phoneNum: String
    var email: String
    var dob: String
}

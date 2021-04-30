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
    var individualID: DocumentReference
    var firstname: String
    var surname: String
    var address: [String]
    var phoneNo: Int
    var email: String
    @ServerTimestamp var dob: Timestamp?
}

//
//  CovidSign.swift
//  COVID-APP
//
//  Created by Taylah Galea on 13/5/21.
//

import SwiftUI
import Firebase
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct CovidSign: Identifiable, Codable {
    @DocumentID var id: String?
    var businessID: DocumentReference
    var name: String
    var location: GeoPoint
    var qrCode: String
}

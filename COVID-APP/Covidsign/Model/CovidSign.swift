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
    var id: String?
    var businessID: String
    var name: String
    var longitude: String
    var latitude: String
    var qrCode: String
}

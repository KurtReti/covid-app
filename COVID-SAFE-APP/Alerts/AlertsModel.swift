//
//  AlertsModel.swift
//  COVID-APP
//
//  Created by Juliet Gobran on 19/5/21.
//

import SwiftUI
import Firebase
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct AlertUser: Identifiable, Codable
{
    var id: String = UUID().uuidString
    var title: String
    var message: String
}



struct TestResult: Identifiable, Codable
{
    var id: String?
    var testIndividualID: String
    var healthCareID: String
    var date: String
    var time: String
    var result: Bool
    var notes: String
}

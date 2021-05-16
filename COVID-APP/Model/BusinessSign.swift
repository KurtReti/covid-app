//
//  BusinessSign.swift
//  COVID-APP
//
//  Created by Connor Jones on 16/5/21.
//

import SwiftUI
import Firebase
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct BusinessSign: Identifiable, Codable {
    @DocumentID var id: String?
    let businessID:String
    //let name: String
    let address: String
    let qr: String
    
    
}

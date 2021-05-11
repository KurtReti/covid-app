//
//  BusinessSignupViewModel.swift
//  COVID-APP
//
//  Created by user188450 on 5/3/21.
//


import SwiftUI
import Firebase
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
class BusinessSignupViewModel: ObservableObject
{
    var business: Business
    private let db = Firestore.firestore()
    private var individualId = ""
    @Published var password = ""

   init(indID: String) {
        self.individualId = indID
       let individualRef = db.collection("individual").document(individualId)
        business = Business( id: "", individualID: individualRef, name: "", ABN: "", address: "", phoneNum: "", email: "", bType: "")
    }
    init() {
    
       //let individualRef = db.collection("individual").document(individualId)
        business = Business( id: "", name: "", ABN: "", address: "", phoneNum: "", email: "", bType: "")
   }
    
    private func addBusiness(_ business: Business) {
        do {
            let _ = try db.collection("business").addDocument(from: business)
        }
        catch {
            print(error)
            
        }
    }
    
    func addBusiness() {
        addBusiness(business)
    }
    
}


struct Business: Identifiable, Codable {
    @DocumentID var id: String?
    var individualID: DocumentReference?
    var name: String
    var ABN: String
    var address: String
    var phoneNum: String
    var email: String
    var bType: String
    @ServerTimestamp var dob: Timestamp?
}

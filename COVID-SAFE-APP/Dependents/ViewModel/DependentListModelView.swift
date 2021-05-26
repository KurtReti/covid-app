//
//  DependentListModelView.swift
//  COVID-APP
//
//  Created by Taylah Galea on 30/4/21.
//

import SwiftUI
import Firebase
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class DependentListViewModel: ObservableObject {
    @Published var dependentsList = [Dependent]()
    
    private let db = Firestore.firestore()
    
    private let individualId = Singleton.shared.accountID
    
    func fetchData() {
        // Find dependents based on individual ID
        let dependentRef = db.collection("dependent")
        
        let query = dependentRef.whereField("individualID", isEqualTo: individualId ?? "").order(by: "first_name")
    
        // Read data and add to list
        query
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                self.dependentsList = documents.compactMap { (queryDocumentSnapshot) -> Dependent? in
                    
                    let data = queryDocumentSnapshot.data()
                    let dependentID = queryDocumentSnapshot.documentID
                    let individualID = data["individualID"] as? String ?? ""
                    let first_name = data["first_name"] as? String ?? ""
                    let last_name = data["last_name"] as? String ?? ""
                    let address = data["address"] as? String ?? ""
                    let phoneNum = data["phoneNum"] as? String ?? ""
                    let email = data["email"] as? String ?? ""
                    let dob = data["dob"] as? String ?? ""
                    return Dependent(id: dependentID, individualID: individualID, first_name: first_name, last_name: last_name, address: address, phoneNum: phoneNum, email: email, dob: dob)
                }
            }
    }
}

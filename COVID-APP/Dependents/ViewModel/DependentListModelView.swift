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
    
    private let individualId = "JJI0UhxQrQOsDEg3r9Rk"
    
    func fetchData() {
        // Find dependents based on individual ID
        let dependentRef = db.collection("dependent")
        
        let individualRef = db.collection("individual").document(individualId)
        
        let query = dependentRef.whereField("individualID", isEqualTo: individualRef).order(by: "firstname")
    
        // Read data and add to list
        query
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                self.dependentsList = documents.compactMap { (queryDocumentSnapshot) -> Dependent? in
                    //return try? queryDocumentSnapshot.data(as: Dependent.self)
                    
                    let data = queryDocumentSnapshot.data()
                    let dependentID = queryDocumentSnapshot.documentID
                    let individualID = data["individualID"] as? DocumentReference ?? nil
                    let firstname = data["firstname"] as? String ?? ""
                    let surname = data["surname"] as? String ?? ""
                    let address = data["address"] as? [String] ?? [""]
                    let phoneNo = data["phoneNo"] as? Int ?? 0
                    let email = data["email"] as? String ?? ""
                    let dob = data["dob"] as? Timestamp ?? Timestamp()
                    return Dependent(id: dependentID, individualID: individualID!, firstname: firstname, surname: surname, address: address, phoneNo: phoneNo, email: email, dob: dob)
                }
            }
    }
}

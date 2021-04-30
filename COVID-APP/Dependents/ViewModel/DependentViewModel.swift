//
//  DependentViewModel.swift
//  COVID-APP
//
//  Created by Taylah Galea on 30/4/21.
//

import SwiftUI
import Firebase
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class DependentViewModel: ObservableObject {
    var dependent: Dependent
    private let db = Firestore.firestore()
    private let individualId = "JJI0UhxQrQOsDEg3r9Rk"

    
    init() {
        let individualRef = db.collection("individual").document(individualId)
        dependent = Dependent(id: "", individualID: individualRef, firstname: "", surname: "", address: [""], phoneNo: 0, email: "", dob: Timestamp())
    }
    
    private func addDependent(_ dependent: Dependent) {
        do {
            let _ = try db.collection("dependent").addDocument(from: dependent)
        }
        catch {
            print(error)
        }
    }
    
    func addDependent() {
        addDependent(dependent)
    }
}

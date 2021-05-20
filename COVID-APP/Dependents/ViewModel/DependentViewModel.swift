//
//  DependentViewModel.swift
//  COVID-APP
//
//  Created by Taylah Galea on 30/4/21.
//

import SwiftUI
import Firebase
import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class DependentViewModel: ObservableObject {
    @Published var dependent: Dependent
    @Published var modified = false
    
    private var cancellables = Set<AnyCancellable>()
    var dob: Date = Date()
    private let db = Firestore.firestore()
    private let individualId = "JJI0UhxQrQOsDEg3r9Rk"
    

    init() {
        let individualRef = db.collection("individual").document(individualId)
        dependent = Dependent(id: "", individualID: individualRef, firstname: "", surname: "", address: "", phoneNo: "", email: "", dob: Timestamp())
    }
    
    init(dependent: Dependent) {
        self.dependent = dependent
        self.$dependent
            .dropFirst()
            .sink { [weak self] dependent in
                self?.modified = true
            }
            .store(in: &self.cancellables)
    }
    
    
    func addDependent() {
        self.dependent.dob = Timestamp(date: dob)
        do {
            let _ = try db.collection("dependent").addDocument(from: dependent)
        }
        catch {
            print(error)
        }
    }
    
    func updateDependent() {
        if let documentId = dependent.id {
            do {
                try db.collection("dependent").document(documentId).setData(from: dependent)
                
            }
            catch {
                print(error)
            }
        }
    }
    
    func deleteDependent() {
        if let documentId = dependent.id {
            db.collection("dependent").document(documentId).delete() { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

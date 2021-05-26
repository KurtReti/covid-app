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
    private let individualId = "cdb45e6a-0fe5-437f-a821-4e29874285ea"
    

    init() {
    
        dependent = Dependent(id: "", individualID: individualId, first_name: "", last_name: "", address: "", phoneNum: "", email: "", dob: "")
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
        print("\(getDateFormatted())")
        self.dependent.dob =  getDateFormatted()
        do {
            let _ = try db.collection("dependent").addDocument(from: dependent)
        }
        catch {
            print(error)
        }
    }
    
    func updateDependent() {
        self.dependent.dob = getDateFormatted()
        if let documentId = dependent.id {
            do {
                try db.collection("dependent").document(documentId).setData(from: dependent)
                
            }
            catch {
                print(error)
            }
        }
    }
    
    func getDateFormatted() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd/MM/yyyy"
        return dateformatter.string(from: dob)
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

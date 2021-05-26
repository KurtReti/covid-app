//
//  ReportModel.swift
//  COVID-APP
//
//  Created by Megan Moss on 24/5/21.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class ReportViewModel: ObservableObject {
    @Published var infectedUsersID = [String]()
    @Published var countOfInfectedUsers: Int = 0
    
    private var db = Firestore.firestore()
    
    func fetchInfectedUsersID()
    {
        db.collection("testResult").whereField("result", isEqualTo: true).addSnapshotListener{(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            for _ in documents {
                self.countOfInfectedUsers += 1
                print(self.countOfInfectedUsers)
            }
            
            self.infectedUsersID = documents.map{ (QueryDocumentSnapshot) -> String in
                let data = QueryDocumentSnapshot.data()
                let temp = data["individualID"] as? String ?? ""
                return temp
            }
            
        }
    }
}



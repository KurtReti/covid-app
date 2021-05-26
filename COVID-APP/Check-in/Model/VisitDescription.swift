//
//  VisitDescription.swift
//  COVID-APP
//
//  Created by Connor Jones on 20/5/21.
//




//
//  LocationViewModel.swift
//  COVID-APP
//
//  Created by Megan Moss on 19/5/21.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class LocationsViewModel: ObservableObject {
    @Published var locations = [Contact]()
    private var db = Firestore.firestore()

    func fetchData() {
        db.collection("contacts").whereField("individualID", isEqualTo: Singleton.shared.accountID ?? "").whereField("signedOut", isEqualTo: true).addSnapshotListener{(QuerySnapshot, error) in
            guard let documents = QuerySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.locations = documents.map{ (QueryDocumentSnapshot) -> Contact in
                let data = QueryDocumentSnapshot.data()
                
                let id = data["contactID"] as? String ?? ""
                let businessSignID = data["businessSignID"] as? String ?? ""
                let individualID = data["individualID"] as? String ?? ""
                let signInDate = data["signInDate"] as? String ?? ""
                let signOutDate = data["signOutDate"] as? String ?? ""
                let signInTime = data["signInTime"] as? String ?? ""
                let signOutTime = data["signOutTime"] as? String ?? ""
                let signedOut = data["signedOut"] as? Bool ?? true
                let dependentIDs = data["dependants"] as? [String] ?? [String]()
                
                return Contact(id: id, businessSignID: businessSignID, dependants: dependentIDs, individualID: individualID, signInDate: signInDate, signOutDate: signOutDate, signInTime: signInTime, signoutTime: signOutTime, signedOut: signedOut)
            
            }
        }
    }
    
    
    
}


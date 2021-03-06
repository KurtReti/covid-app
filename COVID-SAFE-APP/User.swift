//
//  SessionStore.swift
//  COVID-APP
//
//  Created by Connor Jones on 7/4/21.
//


import SwiftUI
import Firebase
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


//all fields needed for a session need to be added
class User : ObservableObject  {
    var uid: String
    var email: String?
    var displayName: String?
    var individualID: String?
    var businessID: String?
    var healthID: String?

    init() {
        self.uid = ""
    }
    init(uid: String, displayName: String?) {
        self.uid = uid
        self.displayName = displayName
    }
    init(uid: String, displayName: String?, email: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }
    
    func getUID() -> String {
        
        return self.uid
    }

}

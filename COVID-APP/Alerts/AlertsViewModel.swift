//
//  AlertsViewModel.swift
//  COVID-APP
//
//  Created by Juliet Gobran on 19/5/21.
//
/*
 DONE infected users ID
 Done ALL infected contacts
 DONE checking if this user is infected
 DONE geting this users contacts
 Done adding some infected contacts
 
 */

import SwiftUI
import Firebase
import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class AlertsViewModel: ObservableObject
{
    @Published var thisUsersContacts = [Contact]() // all of the current users contacts
    @Published var infectedUsersID = [String]() // ID of all positive cases
    @Published var infectedContacts = [Contact]() // all positive cases contacts
    @Published var alerts = [AlertUser]()
    
    @Published var empty = AlertUser(title: "No Alerts", message:"")
    
    var thisUser = "3dcff086-1cd6-4130-b540-d4fb3afd2c2f"
    
    private var db = Firestore.firestore()
    
    // creates array of all positive inidividual's ID
    func fetchInfectedUsersID()
    {
        db.collection("testResult").whereField("result", isEqualTo: true).addSnapshotListener{(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            self.infectedUsersID = documents.map{ (QueryDocumentSnapshot) -> String in
                let data = QueryDocumentSnapshot.data()
                let temp = data["individualID"] as? String ?? ""
                return temp
            }
            print ("DONE infected users ID")
            for id in self.infectedUsersID{
                print(id)
            }
            self.fetchThisUserData()
            self.checkIfPositive(thisUser: self.thisUser)
        }
    }
    
    // creates array of all THIS users contacts
    func fetchThisUserData()
    {
        db.collection("contact").whereField("individualID", isEqualTo: thisUser).addSnapshotListener {(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            self.thisUsersContacts = documents.map{ (QueryDocumentSnapshot) -> Contact in
                let data = QueryDocumentSnapshot.data()
                let id = data["contactID"] as? String ?? ""
                let businessSignID = data["businessSignID"] as? String ?? ""
                let individualID = data["individualID"] as? String ?? ""
                let dependents = data["dependents"] as? [String] ?? [""]
                let signInTime = data["signInTime"] as? String ?? ""
                let signOutTime = data["signOutTime"] as? String ?? ""
                let signInDate = data["signInDate"] as? String ?? ""
                let signOutDate = data["signOutDate"] as? String ?? ""
                let signedOut = data["signedOut"] as? Bool ?? false
                
                return Contact(id: id, businessSignID: businessSignID, dependants: dependents, individualID: individualID, signInDate: signInDate, signOutDate: signOutDate, signInTime: signInTime, signoutTime: signOutTime, signedOut: signedOut)
                
                
            }
            print ("DONE geting this users contacts")
            self.createInfectedContacts()
        }
    }
    
    // when called while iterating over infectedUserID, generates an array of all infected Contacts
    func fetchInfectedContacts(infectedID: String)
    {
        db.collection("contact").whereField("individualID", isEqualTo: infectedID).addSnapshotListener {(QuerySnapshot, error) in
            guard let documents = QuerySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            self.infectedContacts = documents.map{ (QueryDocumentSnapshot) -> Contact in
                let data = QueryDocumentSnapshot.data()
                let id = data["contactID"] as? String ?? ""
                let businessSignID = data["businessSignID"] as? String ?? ""
                let individualID = data["individualID"] as? String ?? ""
                let dependents = data["dependents"] as? [String] ?? [""]
                let signInTime = data["signInTime"] as? String ?? ""
                let signOutTime = data["signOutTime"] as? String ?? ""
                let signInDate = data["signInDate"] as? String ?? ""
                let signOutDate = data["signOutDate"] as? String ?? ""
                let signedOut = data["signedOut"] as? Bool ?? false
                
                return Contact(id: id, businessSignID: businessSignID, dependants: dependents, individualID: individualID, signInDate: signInDate, signOutDate: signOutDate, signInTime: signInTime, signoutTime: signOutTime, signedOut: signedOut)
            }
            print ("Done adding some infected contacts")
        }
    }
    
    // uses the fetchInfectedContacts whilst iterating over infectedUsersID to populate the infectedContacts array
    func createInfectedContacts()
    {
        for id in infectedUsersID {
            fetchInfectedContacts(infectedID: id)
        }
        print ("Done ALL infected contacts")
        self.checkIfInfected()
    }
    
    // iterates over thisUsersContacts and InfectedContacts to find any matches - adds alert if matched
    func checkIfInfected()
    {
        for thisContacts in thisUsersContacts {
            for infected in infectedContacts {
                if (thisContacts.businessSignID == infected.businessSignID) &&
                    ((thisContacts.signInDate == infected.signInDate) || (thisContacts.signOutDate == infected.signOutDate))
                {
                    let tempAlert = AlertUser(title: "Get tested / Self-isolate",
                                              message: "You've been exposed to a positive case, please get tested and self-isolate until the result returns negative.")
                    self.alerts.append(tempAlert)
                }
            }
        }
        print ("DONE checking if this user is infected")
    }
    
    // iterates over infectedUsersID to check thisUser isn't infected
    func checkIfPositive(thisUser: String)
    {
        for id in infectedUsersID {
            if id == thisUser {
                let tempAlert = AlertUser(title: "Positive - Self-isolate for 14 days",
                                          message: "You've been tested positive for COVID-19, please begin self-isolation immediately.")
                self.alerts.append(tempAlert)
                print ("I am positive")
            }
        }
    }
}

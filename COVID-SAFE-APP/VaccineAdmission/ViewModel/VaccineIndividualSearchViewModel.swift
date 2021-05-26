//
//  VaccineIndividualSearchViewModel.swift
//  COVID-APP
//
//  Created by Connor Jones on 20/5/21.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift


class VaccineIndividualSearchViewModel: ObservableObject{
    
    private let db = Firestore.firestore()
    
    @Published var currentIndividual: Individual
    @Published var currentHealthOfficial: HealthOfficial
    @Published var currentHealthCentre: HealthCentre
    @Published var currentVaccine: Vaccine
    
    @Published var isActive = false
    @Published var vaccinationList = [Vaccination]()
    
    @Published var showProfile = false
    @Published var medicareNum = ""
    
    init() {
        currentIndividual = Individual(id: "", firstName: "", lastName: "", address: "", email: "", phoneNum: "", dob: "")
        
        currentHealthOfficial = HealthOfficial(id: "", firstName: "", lastName: "", address: "", email: "", phoneNum: "", occupation: "", dob: "", accessLevel: "", uid: "")
        
        currentVaccine = Vaccine(id: "", name: "", dosageAmount: 0, manufacture: "")
        
        currentHealthCentre = HealthCentre(id: "", accessLevel: "", address: "", email: "", phoneNum: "", uid: "")
        
        
        
    }
    
    
    func vaccineHistorySearch(medicare: String){
        
        
        db.collection("individuals").whereField("accountID", isEqualTo: medicare).limit(to: 1).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
                
            } else {
                for document in querySnapshot!.documents {
                    
                    let data = document.data()
                    //  let id = document.documentID
                    let fsAccountID = data["accountID"] as? String ?? ""
                    let fsAddress = data["address"] as? String ?? ""
                    let fsDOB = data["dob"] as? String ?? ""
                    let fsEmail = data["email"] as? String ?? ""
                    let fsFirstName = data["first_name"] as? String ?? ""
                    let fsLastName = data["last_name"] as? String ?? ""
                    let fsPhoneNum = data["phoneNum"] as? String ?? ""
                    
                    
                    self.currentIndividual = Individual(id: fsAccountID, firstName: fsFirstName, lastName: fsLastName, address: fsAddress, email: fsEmail, phoneNum: fsPhoneNum, dob: fsDOB)
                    
                    print("bid")
                    print(fsFirstName)
                    //self.getVaccinationHistory()
                    
                    // self.getBusiness()
                    self.isActive = true
                    //do some error stuff
                }
                
                //
                
                
                
            }
            
        }
        
        
        
        
        
        
    }
    
    
    
    
    
    
}

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
    
    
    func IndividualSearch(medicare: String){
        
        var check = false
        db.collection("individual").whereField("accountID", isEqualTo: medicare).limit(to: 1).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
                
            } else {
                for document in querySnapshot!.documents {

                    check = true
  
                }
                //will transfer current view to VaccineAdministrationView
                if(check){
                self.isActive = true
                }
                
            }
            
        }
        
        
        
        
        
        
    }
    
    
    
    
    
    
}

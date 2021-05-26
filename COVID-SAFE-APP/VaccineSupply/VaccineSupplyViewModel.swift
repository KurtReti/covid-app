//
//  VaccineSupplyViewModel.swift
//  COVID-APP
//
//  Created by Connor Jones on 26/5/21.
//
import SwiftUI
import Firebase
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class VaccineSupplyViewModel: ObservableObject{
    
    private let db = Firestore.firestore()
    @Published var vaccineBatchList = [VaccineBatch]()
    @Published var vaccineDictionary = [String: Vaccine]()
    
    
    //gets all vaccine batches of current health centre puts the into a collection
    func fillVacineBatchList(){
        
        let query = db.collection("vaccineBatch").whereField("healthCentreID", isEqualTo: Singleton.shared.accountID ?? "")
        query
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                self.vaccineBatchList = documents.compactMap { (queryDocumentSnapshot) -> VaccineBatch? in
                    //return try? queryDocumentSnapshot.data(as: Dependent.self)
                    //anyVaccinationHistory = true
                    let data = queryDocumentSnapshot.data()
                    let fsVaccineBatchID = data["vaccineBatchID"] as? String ?? ""
                    let fsHealthCentreID = data["healthCentreID"] as? String ?? ""
                    let fsVaccineID = data["vaccineID"] as? String ?? ""
                    let fsTotalVaccines = data["totalVaccines"] as? Int ?? 0
                    
                    return VaccineBatch(id: fsVaccineBatchID, totalVaccines: fsTotalVaccines, vaccineID: fsVaccineID, healthCentreID: fsHealthCentreID)
                }
                
                //self.intitialLoad = false
            }
    }
    
    //creates dictionary of currnently approved vaccines
    func fillVacineDictionary(){
        
        db.collection("vaccine").whereField("active", isEqualTo: true).limit(to: 10).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
                
            } else {
                
                
                for document in querySnapshot!.documents {
                    //return try? queryDocumentSnapshot.data(as: Dependent.self)
                    //anyVaccinationHistory = true
                    let data = document.data()
                    
                    let fsVaccineID = data["vaccineID"] as? String ?? ""
                    let fsName = data["name"] as? String ?? ""
                    let fsDosageAmount = data["dosageAmount"] as? Int ?? 0
                    let fsManufacture = data["manufacture"] as? String ?? ""
                    let vac = Vaccine(id: fsVaccineID, name: fsName, dosageAmount: fsDosageAmount, manufacture: fsManufacture)
                    self.vaccineDictionary[fsVaccineID] = vac
                    
                    
                    
                }
                
                
            }
        }
    }
}

class AddVaccinBatchViewModel: ObservableObject{
    
    private let db = Firestore.firestore()
    @Published var vaccineBatch: VaccineBatch
    @Published var vaccineDictionary = [String: Vaccine]()
    @Published var vaccineList = [Vaccine]()
    @Published var vaccine: Vaccine
    @Published var vaccineAmount = ""
    
    
    init() {
        vaccineBatch = VaccineBatch(id: "", totalVaccines: 0, vaccineID: "", healthCentreID: "")
        
        vaccine = Vaccine(id: "", name: "", dosageAmount: 0, manufacture: "")
    }
    //vaccineBatch added to firestore
    func addVaccineBatch(){
        
        let myInt1 = Int(vaccineAmount)
        
        
        let ref = db.collection("vaccineBatch").document()
        let idref = ref.documentID
        
        
        ref.setData(["vaccineBatchID": idref, "healthCentreID": Singleton.shared.accountID ?? "", "vaccineID": vaccine.id,"totalVaccines": myInt1 ?? 0, "active": true]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                
                
            }
        }
        
    }
    //fills vaccine list so picker can give user options of  available vaccines to choose
    func fillVaccineList(){
        
        let query = db.collection("vaccine").whereField("active", isEqualTo: true).limit(to: 8)
        query
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                self.vaccineList = documents.compactMap { (queryDocumentSnapshot) -> Vaccine? in
                    
                    let data = queryDocumentSnapshot.data()
                    
                    let fsVaccineID = data["vaccineID"] as? String ?? ""
                    let fsName = data["name"] as? String ?? ""
                    let fsDosageAmount = data["dosageAmount"] as? Int ?? 0
                    let fsManufacture = data["manufacture"] as? String ?? ""
                    
                    
                    //vaccineID = fsVaccineID
                    return Vaccine(id: fsVaccineID, name: fsName, dosageAmount: fsDosageAmount, manufacture: fsManufacture)
                }
                
                
            }
    }
    //fills vaccine Dictionary so picker can give user options of  available vaccines to choose
    func fillVacineDictionary(){
        
        db.collection("vaccine").whereField("active", isEqualTo: true).limit(to: 8).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
                
            } else {
                
                
                for document in querySnapshot!.documents {
                    //return try? queryDocumentSnapshot.data(as: Dependent.self)
                    //anyVaccinationHistory = true
                    let data = document.data()
                    
                    let fsVaccineID = data["vaccineID"] as? String ?? ""
                    let fsName = data["name"] as? String ?? ""
                    let fsDosageAmount = data["dosageAmount"] as? Int ?? 0
                    let fsManufacture = data["manufacture"] as? String ?? ""
                    let vac = Vaccine(id: fsVaccineID, name: fsName, dosageAmount: fsDosageAmount, manufacture: fsManufacture)
                    self.vaccineDictionary[fsVaccineID] = vac
                    print(fsName)
                    //vaccineItem
                    
                }
                
                //self.intitialLoad = false
            }
        }
    }
}

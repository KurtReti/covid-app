//
//  VaccineAdministrationViewModel.swift
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




/*
 struct SwiftUIView_Previews1: PreviewProvider
 {
 @State var index = ""
 static var previews: some View {
 VaccineAdmissionView()
 }
 }
 */

class VaccineAdministrationViewModel: ObservableObject{
    
    private let db = Firestore.firestore()
    var healthCentreID = "2de45fd4-6c05-4756-ace7-33f0f1bdd9f3"
    
    //tied to picker selection for vaccine
    @Published var selectedVaccineType = ""
    
    
    
    @Published var currentIndividual: Individual
    @Published var currentHealthOfficial: HealthOfficial
    @Published var currentHealthCentre: HealthCentre
    //
    @Published var currentVaccine: Vaccine
    
    @Published var isActive = false
    @Published var vaccinationList = [Vaccination]()
    
    @Published var vaccineBatchList = [VaccineBatch]()
    
    @Published var vaccineList = [Vaccine]()
    
    @Published var intitialLoad = true
    @Published var showProfile = false
    @Published var medicareNum = ""
    
    
    init() {
        currentIndividual = Individual(id: "", firstName: "", lastName: "", address: "", email: "", phoneNum: "", dob: "")
        
        currentHealthOfficial = HealthOfficial(id: "", firstName: "", lastName: "", address: "", email: "", phoneNum: "", occupation: "", dob: "", accessLevel: "", uid: "")
        
        currentVaccine = Vaccine(id: "", name: "", dosageAmount: 0, manufacture: "")
        
        currentHealthCentre = HealthCentre(id: "", accessLevel: "", address: "", email: "", phoneNum: "", uid: "")
        
        populateVaccineList()
        
        
    }
    
    
    func populateVaccineList(){
        
        let query = db.collection("vaccine")
        query
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents1 = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                self.vaccineList = documents1.compactMap { (queryDocumentSnapshot) -> Vaccine? in
                    //return try? queryDocumentSnapshot.data(as: Dependent.self)
                    //anyVaccinationHistory = true
                    let data = queryDocumentSnapshot.data()
                    let fsVaccineID = data["vaccineID"] as? String ?? ""
                    
                    let fsDosageAmount = data["dosageAmount"] as? Int ?? 0
                    let fsName = data["name"] as? String ?? ""
                    let fsManufcature = data["manufacture"] as? String ?? ""
                    
                    return Vaccine(id: fsVaccineID, name: fsName, dosageAmount: fsDosageAmount, manufacture: fsManufcature)
                }
                
            }
        
    }
    
    
    func getVaccineSupply(){
        
        print("here")
        var anyVaccinationHistory = false
        
        
        let query = db.collection("vaccineBatch").whereField("healthCentreID", isEqualTo: healthCentreID)
        query
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                self.vaccineBatchList = documents.compactMap { (queryDocumentSnapshot) -> VaccineBatch? in
                    //return try? queryDocumentSnapshot.data(as: Dependent.self)
                    anyVaccinationHistory = true
                    let data = queryDocumentSnapshot.data()
                    let fsVaccineBatchID = data["vaccineBatchID"] as? String ?? ""
                    let fsHealthCentreID = data["healthCentreID"] as? String ?? ""
                    let fsVaccineID = data["vaccineID"] as? String ?? ""
                    let fsTotalVaccines = data["totalVaccines"] as? Int ?? 0
                    
                    return VaccineBatch(id: fsVaccineBatchID, totalVaccines: fsTotalVaccines, vaccineID: fsVaccineID, healthCentreID: fsHealthCentreID)
                }
                
                self.intitialLoad = false
            }
        
        
        if (anyVaccinationHistory == true){
            print("vaccine history present2")
            
            
        }else{
            print("no vaccine history2")
        }
        
        
    }
    
    
    
    
    func generateVaccineAdmission(){
        
        
        //var i = 0
        
        var batchID = ""
        var vaccineAvailable = false
        
        for vaccineBatch in vaccineBatchList {
            if vaccineBatch.totalVaccines > 0 && vaccineBatch.vaccineID == selectedVaccineType{
                vaccineAvailable = true
                print("vaccine available")
                batchID = vaccineBatch.id
                
            }
            
        }
        
        subtractFromBatch(batchID: batchID)
        
        submitVaccinationToFirestore()
        
        //check if matches past vaccine
        
    }
    
    func submitVaccinationToFirestore() {
        
        let currentTimeDate = getFormattedDateAndTime()
        
        let ref = db.collection("vaccination").document()
        
        let idref = ref.documentID
        
        ref.setData(["vaccinationID": idref, "bookingID": "placeholder", "healthCentreID": healthCentreID,"individualID": self.currentIndividual.id as Any, "vaccineID": selectedVaccineType as Any, "doseDate": currentTimeDate]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                
                
                
                self.vaccinationList.append(Vaccination(id: idref, bookingID: "placeholder", individualID: self.currentIndividual.id ?? " " , healthCentreID: "", vaccineID: self.currentVaccine.id , doseDate: currentTimeDate))
                
                
            }
        }
        
    }
    
    
    func subtractFromBatch(batchID: String) {
        
        db.collection("vaccineBatch").whereField("vaccineBatchID", isEqualTo: batchID).limit(to: 1).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
                
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    
                    var fsTotalVaccines = data["totalVaccines"] as? Int ?? 0
                    
                    fsTotalVaccines = fsTotalVaccines - 1
                    
                    document.reference.updateData(["totalVaccines": fsTotalVaccines])
                    
                }
                
            }
            
            
            
            
        }
    }
    
    func vaccineHistorySearch(medicare:String){
        
        medicareNum = medicare
        
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
                    self.getVaccinationHistory()
                    
                    // self.getBusiness()
                    
                    //do some error stuff
                }
                
                //
                
                
                
            }
            
        }
        
        
        
        
        
        
    }
    
    func getVaccinationHistory(){
        
        print("here")
        var anyVaccinationHistory = false
        var vaccineID = ""
        
        
        var query = db.collection("vaccination").whereField("individualID", isEqualTo: medicareNum)
        query
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                self.vaccinationList = documents.compactMap { (queryDocumentSnapshot) -> Vaccination? in
                    //return try? queryDocumentSnapshot.data(as: Dependent.self)
                    anyVaccinationHistory = true
                    let data = queryDocumentSnapshot.data()
                    let fsVaccinationID = data["vaccinationID"] as? String ?? ""
                    let fsIndividualID = data["individualID"] as? String ?? ""
                    let fsHealthOfficialID = data["healthCentreID"] as? String ?? ""
                    let fsVaccineID = data["vaccineID"] as? String ?? ""
                    let fsBookingID = data["bookingID"] as? String ?? ""
                    let fsDoseDate = data["doseDate"] as? String ?? ""
                    
                    
                    vaccineID = fsVaccineID
                    return Vaccination(id: fsVaccinationID, bookingID: fsBookingID, individualID: fsIndividualID, healthCentreID: fsHealthOfficialID, vaccineID: fsVaccineID, doseDate: fsDoseDate)
                }
                
                
                if (anyVaccinationHistory == true){
                    print("vaccine history present1")
                    //self.getVaccine()
                    self.getVaccineSupply()
                    
                }else{
                    print("no vaccine history")
                    //self.getVaccine()
                    self.getVaccineSupply()
                }
                
            }
        
        if (anyVaccinationHistory == true){
            print("vaccine history present2")
            
            
        }else{
            print("no vaccine history2")
        }
        
        
    }
    func getFormattedDateAndTime()->String{
        
        
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: Date()) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "dd-MMM-yyyy HH:mm:ss"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        
        print(myStringafd)
        
        return myStringafd
    }
    
    
    
    
    func getVaccine(){
        
        
        
        db.collection("vaccine").whereField("vaccineID", isEqualTo: vaccinationList[0].vaccineID).limit(to: 1).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
                
            } else {
                for document in querySnapshot!.documents {
                    
                    let data = document.data()
                    //  let id = document.documentID
                    let fsVaccineID = data["vaccineID"] as? String ?? ""
                    let fsName = data["name"] as? String ?? ""
                    let fsDosageAmount = data["dosageAmount"] as? Int ?? 0
                    let fsManufacture = data["manufacture"] as? String ?? ""
                    
                    
                    
                    self.currentVaccine = Vaccine(id: fsVaccineID, name: fsName, dosageAmount: fsDosageAmount, manufacture: fsManufacture)
                    
                    print("bid1")
                    // print(fsFirstName)
                    // self.getVaccinationHistory()
                    
                    // self.getBusiness()
                    
                    //do some error stuff
                }
                self.getVaccineSupply()
                //
                print("bid2")
                //self.intitialLoad = false
                // self.showProfile = true
                
            }
            
        }
        
        
        
    }
    
    
}

//
//  CheckInViewModel.swift
//  COVID-APP
//
//  Created by Connor Jones on 16/5/21.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class CheckInVeiwModel: ObservableObject
{
    private let db = Firestore.firestore()
    var indID = ""
    var qrCode = ""
    @Published var url = ""
    @Published var currentBusiness: Business
    @Published var busSignLocation: CovidSign
    @Published var currentVisit: Visit
    @Published var showCheckinPreview = false
    @Published var checkinConfirmed = false
    @Published var isLoading = false
    @Published var initialLoadComplete = false
    
    @Published var locations = [Visit]()
    
    init() {
        // initialise objects to store relevent check in info
        
        busSignLocation = CovidSign(id: "", businessID: "", name: "", latitude: 0, longitude: 0, location: "", qrCode: "")
        
        currentVisit = Visit(id: "", businessSignID: "", individualID: "", checkIn: "", active: false)
        currentBusiness = Business(id: "", abn: 0, name: "", address: "", email: "", phoneNum: "", type: "")
    }
    
    func fetchData() {
        db.collection("visit").whereField("individualID", isEqualTo: indID).addSnapshotListener{(QuerySnapshot, error) in
            guard let documents = QuerySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.locations = documents.map{ (QueryDocumentSnapshot) -> Visit in
                let data = QueryDocumentSnapshot.data()
                
                let id = data["visitID"] as? String ?? ""
                let businessSignID = data["businessSignID"] as? String ?? ""
                let individualID = data["individualID"] as? String ?? ""
                let checkIn = data["checkedIn"] as? String ?? ""
                let checkOut = data["checkout"] as? String ?? ""
                let active = true // Temporary
                return Visit(id: id, businessSignID: businessSignID, individualID: individualID, checkIn: checkIn, checkOut: checkOut, active: active)
            }
        }
    }

    
    // this one will load all the data using the url entered instead of scan
    func urlBusinessSign(){
        
        isLoading=true
        // print(qr)
        //qrCode = qr
        print(qrCode)
        
        var businessSignObjectCreated = false
        
        db.collection("businessSign").whereField("qrCode", isEqualTo: url).limit(to: 1).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
                
            } else {
                for document in querySnapshot!.documents {
                    
                    let data = document.data()
                    //  let id = document.documentID
                    let fsBusinessID = data["businessID"] as? String ?? ""
                    let fsQrCode = data["qrCode"] as? String ?? ""
                    let fsBusinessSignID = data["businessSignID"] as? String ?? ""
                    let fsLatitude = data["latitude"] as? Double ?? 0
                    let fsLongitude = data["longitude"] as? Double ?? 0
                    let fsLocation = data["location"] as? String ?? ""
                    let fsName = data["name"] as? String ?? ""
                    print("bid")
                    
                    self.busSignLocation = CovidSign(id: fsBusinessSignID, businessID: fsBusinessID, name: fsName, latitude: fsLatitude, longitude: fsLongitude, location: fsLocation, qrCode: fsQrCode)
                    businessSignObjectCreated = true
                    // self.setBusiness(businessID: businessID)
                }
                
                if(businessSignObjectCreated == true){
                    print("sign object created")
                    self.getBusiness()
                }else{
                    //do some error stuff
                }
                
                
                
                
            }
            
        }
    }
    
    func qrCodeScan(qr: String){
        
        isLoading=true
        print(qr)
        
        qrCode = qr
        print(qrCode)
        
        var businessSignObjectCreated = false
        
        db.collection("businessSign").whereField("businessSignID", isEqualTo: qrCode).limit(to: 1).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
                
            } else {
                print(querySnapshot!.documents.count)
                for document in querySnapshot!.documents {
                    
                    let data = document.data()
                    //  let id = document.documentID
                    let fsBusinessID = data["businessID"] as? String ?? ""
                    let fsQrCode = data["qrCode"] as? String ?? ""
                    let fsBusinessSignID = data["businessSignID"] as? String ?? ""
                    let fsLatitude = data["latitude"] as? Double ?? 0
                    let fsLongitude = data["longitude"] as? Double ?? 0
                    let fsLocation = data["location"] as? String ?? ""
                    let fsName = data["name"] as? String ?? ""
                    print("bid")
                    
                    self.busSignLocation = CovidSign(id: fsBusinessSignID, businessID: fsBusinessID, name: fsName,  latitude: fsLatitude, longitude: fsLongitude, location: fsLocation, qrCode: fsQrCode)
                    businessSignObjectCreated = true
                    // self.setBusiness(businessID: businessID)
                }
                
                if(businessSignObjectCreated == true){
                    print("sign object created")
                    self.getBusiness()
                }else{
                    //do some error stuff
                }
                
                
                
                
            }
            
        }
    }
    
    
    func getBusiness(){
        
        var businessObjectCreated = false
        
        db.collection("business").whereField("accountID", isEqualTo: busSignLocation.businessID).limit(to: 1).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
                
            } else {
                for document in querySnapshot!.documents {
                    
                    let data = document.data()
                    //  let id = document.documentID
                    let fsABN = data["abn"] as? Int ?? 0
                    let fsAccountID = data["accountID"] as? String ?? ""
                    let fsAddress = data["address"] as? String ?? ""
                    let fsEmail = data["email"] as? String ?? ""
                    let fsName = data["name"] as? String ?? ""
                    let fsPhoneNum = data["phoneNum"] as? String ?? ""
                    let fsType = data["type"] as? String ?? ""
                    
                    print("bid")
                    print(fsAddress)
                    self.currentBusiness = Business(id: fsAccountID, abn: fsABN, name: fsName, address: fsAddress, email: fsEmail, phoneNum: fsPhoneNum, type: fsType)
                    businessObjectCreated = true
                    // self.setBusiness(businessID: businessID)
                }
                
                if(businessObjectCreated == true){
                    print("business object created")
                    if(self.initialLoadComplete){
                        self.showCheckinPreview = true
                        
                        self.isLoading=false
                        
                    }else{
                        self.checkinConfirmed = true
                        self.initialLoadComplete = true
                        self.isLoading = false
                    }
                    
                    // self.getBusiness()
                }else{
                    //do some error stuff
                }
                
                
                
                
            }
            
        }
        
    }
    
    func checkIn(){
        isLoading = true
        
        let currentTimeDate = getFormattedDateAndTime()
        
        let ref = db.collection("visit").document()
        //let busSignref = db.collection("businessSign").document(busSign.id!)
        //let indref = db.collection("individuals").document(UID)
        let idref = ref.documentID
        
        ref.setData(["visitID": idref, "businessSignID": self.busSignLocation.id as Any, "individualID": self.indID,"checkedIn": currentTimeDate, "active": true]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                
                
                
                self.currentVisit = Visit(id: idref, businessSignID: self.busSignLocation.id!, individualID: self.indID,checkIn: currentTimeDate, active: true)
                
                self.isLoading = false
                self.checkinConfirmed = true
                self.showCheckinPreview = false
                
            }
        }
        
        
    }
    
    func checkout(){
        
        let currentTimeDate = getFormattedDateAndTime()
        
        
        
        
        db.collection("visit").whereField("individualID", isEqualTo: indID).whereField("active", isEqualTo: true).limit(to: 1).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
                
            } else {
                for document in querySnapshot!.documents {
                    
                    document.reference.updateData(["active": false, "checkout": currentTimeDate])
                    
                }
                self.checkinConfirmed = false
                self.showCheckinPreview = false
                
                
                //do some error stuff
            }
            
            
            
            
        }
        
    }
    
    
    func checkForCurrentCheckIn(){
        isLoading=true
        
        
        var currentTimeDate = getFormattedDateAndTime()
        
        var isActiveVisit = false
        
        db.collection("visit").whereField("individualID", isEqualTo: indID).whereField("active", isEqualTo: true).limit(to: 1).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
                
            } else {
                for document in querySnapshot!.documents {
                    
                    
                    
                    let data = document.data()
                    let fsBusinessSignID =  data["businessSignID"] as? String ?? ""
                    let fsCheckedIn =  data["checkedIn"] as? String ?? ""
                    let fsIndividualID =  data["individualID"] as? String ?? ""
                    //let fsBusinessSignID =  data["email"] as? String ?? ""
                    // let fsBusinessSignID =  data["email"] as? String ?? ""
                    
                    self.currentVisit = Visit(businessSignID: fsBusinessSignID, individualID: fsIndividualID, checkIn: fsCheckedIn, active: true)
                    isActiveVisit = true
                    self.qrCodeScan(qr: fsBusinessSignID)
                }
                print("here now")
                if(isActiveVisit){
                    print("in hereee")
                    
                }else{
                    self.initialLoadComplete = true
                    print("in here1")
                    self.isLoading = false
                }
                //do some error stuff
            }
            
            
            
            
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
}

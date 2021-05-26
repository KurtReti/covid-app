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
    @Published var currentVisit: Contact
    @Published var showCheckinPreview = false
    @Published var checkinConfirmed = false
    @Published var isLoading = false
    @Published var initialLoadComplete = false
    
    @Published var locations = [Contact]()
    
    init() {
 
        busSignLocation = CovidSign(id: "", businessID: "", name: "", longitude: "", latitude: "", qrCode: "")
        
        currentVisit = Contact(id: "", businessSignID: "", dependants: [String](), individualID: "", signInDate: "", signOutDate: "", signInTime: "", signoutTime: "", signedOut: false)
        currentBusiness = Business(id: "", abn: 0, name: "", address: "", email: "", phoneNum: "", type: "")
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
                    let fsSignID = data["businessSignID"] as? String ?? ""
                    let fsBusinessID = data["businessID"] as? String ?? ""
                    let fsQrCode = data["qrCode"] as? String ?? ""
                    let fsLongitude = data["longitude"] as? String ?? ""
                    let fsLatitude = data["latitude"] as? String ?? ""
                    let fsName = data["name"] as? String ?? ""
 
                    
                    self.busSignLocation = CovidSign(id: fsSignID, businessID: fsBusinessID, name: fsName, longitude: fsLongitude, latitude: fsLatitude, qrCode: fsQrCode)
                    
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
        let firstHalf = "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data="
        qrCode = firstHalf + qr
        print(qrCode)
        
        var businessSignObjectCreated = false
        
        db.collection("businessSign").whereField("qrCode", isEqualTo: qrCode).limit(to: 1).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
                
            } else {
                print(querySnapshot!.documents.count)
                for document in querySnapshot!.documents {
                    let data = document.data()
                    //  let id = document.documentID
                    let fsSignID = data["businessSignID"] as? String ?? ""
                    let fsBusinessID = data["businessID"] as? String ?? ""
                    let fsQrCode = data["qrCode"] as? String ?? ""
                    let fsLongitude = data["longitude"] as? String ?? ""
                    let fsLatitude = data["latitude"] as? String ?? ""
                    let fsName = data["name"] as? String ?? ""
 
                    
                    self.busSignLocation = CovidSign(id: fsSignID, businessID: fsBusinessID, name: fsName, longitude: fsLongitude, latitude: fsLatitude, qrCode: fsQrCode)
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
        
        let ref = db.collection("contacts").document()
        let idref = ref.documentID
        
        ref.setData(["contactID": idref, "businessSignID": self.busSignLocation.id ?? "", "individualID": Singleton.shared.accountID ?? "","signInDate": currentTimeDate,"signInTime":getFormattedTime(), "signedOut": false]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                
                
                
                self.currentVisit = Contact(id: idref, businessSignID: self.busSignLocation.id ?? "", dependants: [String](), individualID: Singleton.shared.accountID ?? "", signInDate: currentTimeDate, signOutDate: "", signInTime: self.getFormattedTime(), signoutTime: "", signedOut: false)
                
                //self.currentVisit = Contact(id: idref, businessSignID: self.busSignLocation.id!, individualID: self.indID,checkIn: currentTimeDate, active: true)
                
                self.isLoading = false
                self.checkinConfirmed = true
                self.showCheckinPreview = false
                
            }
        }
        
        
    }
    
    func checkout(){
        
        let currentTimeDate = getFormattedDateAndTime()
        let currentTime = getFormattedTime()
        
        
        
        
        db.collection("contacts").whereField("individualID", isEqualTo: Singleton.shared.accountID ?? "").whereField("signedOut", isEqualTo: false).limit(to: 1).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
                
            } else {
                for document in querySnapshot!.documents {
                    
                    
                    document.reference.updateData(["signedOut": true, "signOutDate": currentTimeDate, "signOutTime": currentTime])
                    
                }
                self.checkinConfirmed = false
                self.showCheckinPreview = false
                
                
                //do some error stuff
            }
            
            
            
            
        }
        
    }
    
    
    func checkForCurrentCheckIn(){
        isLoading=true
        
        
       // let currentTimeDate = getFormattedDateAndTime()
        
        var isActiveVisit = false
        
        db.collection("contacts").whereField("individualID", isEqualTo: Singleton.shared.accountID!).whereField("signedOut", isEqualTo: false).limit(to: 1).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
                
            } else {
                for document in querySnapshot!.documents {
                    
                    print("checking active")
                    
                    let data = document.data()
                    let fsBusinessSignID =  data["businessSignID"] as? String ?? ""
                   
                        print("made if")
                    let fsContactID =  data["contactID"] as? String ?? ""
                   
                    let fsIndividualID =  data["individualID"] as? String ?? ""
                    let fssignInDate =  data["signInDate"] as? String ?? ""
                    let fsSignInTime =  data["signInTime"] as? String ?? ""
                    //let fsBusinessSignID =  data["email"] as? String ?? ""
                    // let fsBusinessSignID =  data["email"] as? String ?? ""
                    
                    self.currentVisit = Contact(id: fsContactID, businessSignID: fsBusinessSignID, dependants: [String](), individualID: fsIndividualID, signInDate: fssignInDate, signOutDate: "", signInTime: fsSignInTime, signoutTime: "", signedOut: false)
                        
                        isActiveVisit = true
                        self.qrCodeScan(qr: fsBusinessSignID)
  
                }
             
                if(isActiveVisit){
                   
                    
                    
                }else{
                    self.initialLoadComplete = true
                   
                    self.isLoading = false
                }
                //do some error stuff
            }
            
            
            
            
        }
        
    }
    
    func getFormattedDateAndTime()->String{
        

        let inputFormatter = DateFormatter()
        
        
        inputFormatter.dateFormat = "dd/MM/yyyy"
        
        let myString = inputFormatter.string(from: Date())
        
        let yourDate = inputFormatter.date(from: myString)

        let myStringafd = inputFormatter.string(from: yourDate!)
        
      
        
        print(myStringafd)
        
        return myStringafd
    }
    
    func getFormattedTime()->String{
        
        let dateFormatterGet = DateFormatter()
        
        dateFormatterGet.dateFormat = "HH:mm"

        
        let myStringTime = dateFormatterGet.string(from: Date())
   
        let yourTime = dateFormatterGet.date(from: myStringTime)

        let myStringTimefd = dateFormatterGet.string(from: yourTime!)
        
        return myStringTimefd
        
    }
    
}

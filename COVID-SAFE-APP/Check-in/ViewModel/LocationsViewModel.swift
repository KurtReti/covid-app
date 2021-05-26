//
//  LocationsViewModel.swift
//  COVID-APP
//
//  Created by Connor Jones on 24/5/21.
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
    @Published var businessSignDictionary = [String:CovidSign]()
    @Published var businessDictionary = [String: Business]()
    @Published var checkInList = [CheckinDisplayInfo]()
    @Published var complete = false
    
   

    func fetchData() {
        
        db.collection("businessSign").addSnapshotListener{(QuerySnapshot, error) in
            guard let documents = QuerySnapshot?.documents else {
                print("No documents")
                return
            }
            var tempArray = [CovidSign]()
            tempArray = documents.map{ (QueryDocumentSnapshot) -> CovidSign in
                let data = QueryDocumentSnapshot.data()
                
                let id = data["businessSignID"] as? String ?? ""
                let businessID = data["businessID"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let latitude = data["latitude"] as? Double ?? 0
                let longitude = data["longitude"] as? Double ?? 0
                let location = data["location"] as? String ?? ""
                let qrCode = data["qrCode"] as? String ?? ""
                
                return CovidSign(id: id, businessID: businessID, name: name, latitude: latitude, longitude: longitude, location: location, qrCode: qrCode)
            
            }
            for covidSign in tempArray {
                self.businessSignDictionary[covidSign.id ?? ""] = covidSign
            }
            
        }
        
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
            
            self.getBusinessSign()
        }
        

        
    }
    
    func getBusinessSign(){
        
        
        db.collection("businessSign").whereField("active", isEqualTo: true).limit(to: 10).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
                
            } else {
                  
                
                for document in querySnapshot!.documents {
                    //return try? queryDocumentSnapshot.data(as: Dependent.self)
                    //anyVaccinationHistory = true
                    let data = document.data()
                    //  let id = document.documentID
                    let fsSignID = data["businessSignID"] as? String ?? ""
                    let fsBusinessID = data["businessID"] as? String ?? ""
                    let fsQrCode = data["qrCode"] as? String ?? ""
                    let fsLongitude = data["longitude"] as? Double ?? 0
                    let fsLatitude = data["latitude"] as? Double ?? 0
                    let fsLocation = data["location"] as? String ?? ""
                    let fsName = data["name"] as? String ?? ""

                    
                    let busSignLocation = CovidSign(id: fsSignID, businessID: fsBusinessID, name: fsName, latitude: fsLatitude, longitude: fsLongitude, location: fsLocation, qrCode: fsQrCode)
                    self.businessSignDictionary[fsSignID] = busSignLocation
                   
                }
                
                self.getBusiness()
            }
    }
        
      
        
    }
    
    func getBusiness(){
        db.collection("business").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
                
            } else {
                  
                
                for document in querySnapshot!.documents {
                    //return try? queryDocumentSnapshot.data(as: Dependent.self)
                    //anyVaccinationHistory = true
                    let data = document.data()
                    //  let id = document.documentID
                    let fsAbn = data["abn"] as? Int ?? 0
                    let fsBusinessID = data["accountID"] as? String ?? ""
                    let fsName = data["name"] as? String ?? ""
                    let fsAddress = data["address"] as? String ?? ""
                    let fsEmail = data["email"] as? String ?? ""
                    let fsPhoneNum = data["phoneNum"] as? String ?? ""
                    let fsType = data["type"] as? String ?? ""

                    
                    let business = Business(id: fsBusinessID, abn: fsAbn, name: fsName, address: fsAddress, email: fsEmail, phoneNum: fsPhoneNum, type: fsType)
                    
                    self.businessDictionary[fsBusinessID] = business
                   
                }
                
                //self.intitialLoad = false
                self.makeDisplayableCheckIn()
            }
    }
        
        
        
    }
    
    func makeDisplayableCheckIn(){
       // var num = 0
        for location in locations {
            print(location.id ?? "")
           // let tempSign = businessSignDictionary[location.businessSignID]
            if let tempSign = businessSignDictionary[location.businessSignID] {
                // now val is not nil and the Optional has been unwrapped, so use it
                
                if let tempBus = businessDictionary[tempSign.businessID] {
                    print("we in tempbus")
                        let checkin = CheckinDisplayInfo(id:location.signInTime, bName: tempBus.name, address: tempBus.address, signInTime: location.signInTime, signInDate: location.signInDate, signOutTime: location.signoutTime, signOutDate: location.signOutDate)
                        
                        self.checkInList.append(checkin)
                }
                
                
            }
            
           
        }
        for checkin in checkInList {
            print(checkin.bName)
            
        }
        
        self.complete = true
        
    }
    

    
}

struct CheckinDisplayInfo: Identifiable,Codable {
    var id: String?
    
    var bName: String
    var address: String
   // var address: String
    var signInTime: String
    var signInDate: String
    var signOutTime: String
    var signOutDate: String
}

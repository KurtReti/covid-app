//
//  CovidSignListViewModel.swift
//  COVID-APP
//
//  Created by Taylah Galea on 13/5/21.
//
/*
import SwiftUI
import Firebase
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class CovidSignListViewModel: ObservableObject {
    @Published var covidSignList = [CovidSign]()
    
    private let db = Firestore.firestore()
    
    private let businessId = "3NGsLaJPHvhhGXb9CCQv"
    
    func fetchData() {
        // Find dependents based on individual ID
        let covidSignRef = db.collection("businessSign")
        
        let businessRef = db.collection("business").document(businessId)
        
        let query = covidSignRef.whereField("businessID", isEqualTo: businessRef).order(by: "name")
        
        print(" Count : \(covidSignList.count)")
    
        // Read data and add to list
        query
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                self.covidSignList = documents.compactMap { (queryDocumentSnapshot) -> CovidSign? in
                    
                    let data = queryDocumentSnapshot.data()
                    let businessSignID = queryDocumentSnapshot.documentID
                    let businessID = data["businessID"] as? DocumentReference ?? nil
                    let name = data["name"] as? String ?? ""
                    let location = data["location"] as? GeoPoint ?? GeoPoint(latitude: 0, longitude: 0)
                    let qrCode = data["qrCode"] as? String ?? ""
                    print(qrCode)
                    return CovidSign(id: businessSignID, businessID: businessID!, name: name, location: location, qrCode: qrCode)
                }
            }
    }
}

 */

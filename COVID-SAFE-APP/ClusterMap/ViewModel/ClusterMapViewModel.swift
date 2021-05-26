//
//  ClusterMapViewModel.swift
//  COVID-SAFE-APP
//
//  Created by Taylah Galea on 25/5/21.
//

import SwiftUI
import Firebase
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import CoreLocation

class ClusterMapViewModel: ObservableObject {
    @Published var markers = [Marker]()
    @Published var individualsWithCovid = [String]()
    
    private let db = Firestore.firestore()
    
    func fetchData() {
        // Get all the individual id for positive test results
        let query = db.collection("testResult").whereField("result", isEqualTo: true)
        query
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                self.individualsWithCovid = documents.map { $0["individualID"]! as! String }
                
            // Get BusinessSignIds of the places covid postive individuals have been to
            var covidRelatedSigns = [String]()
            let myGroup = DispatchGroup()
                for individual in self.individualsWithCovid {
                myGroup.enter()
                
                self.db.collection("contacts").whereField("individualID", isEqualTo: individual).getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            let sign = document.data()["businessSignID"] as? String ?? ""
                            //print("\(individual) : \(sign)")
                        
                            covidRelatedSigns.append(sign)
                        }
                        myGroup.leave()
                    }
                }
            
            }
            
            myGroup.notify(queue: .main) {
                print("\(covidRelatedSigns)")
                for sign in covidRelatedSigns {
                    self.db.collection("businessSign").whereField("businessSignID", isEqualTo: sign).getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            for document in querySnapshot!.documents {
                                let name = document.data()["name"] as? String ?? ""
                                let lat = document.data()["latitude"] as? Double ?? 0
                                let long = document.data()["longitude"] as? Double ?? 0
                                let coord = CLLocationCoordinate2D(latitude: lat, longitude: long)
                                let marker = Marker(title: name, coordinate: coord)
                                print("\(sign) : \(marker)")
                                self.markers.append(marker)
                            }
                        }
                    }
                }
            }

        }

    }
    
}

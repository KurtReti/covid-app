//
//  CovidSignView.swift
//  COVID-APP
//
//  Created by Taylah Galea on 20/5/21.
//

import SwiftUI
import Firebase
import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import CoreLocation

class CovidSignViewModel: ObservableObject {
    @Published var covidSign: CovidSign
    @Published var modified = false
    
    private var cancellables = Set<AnyCancellable>()
    private let db = Firestore.firestore()
    private let businessId = "34df2449-9521-4186-b125-1649d1c66cab"
    
    init() {
        //let businessRef = db.collection("business").document(businessId)
        covidSign = CovidSign(id: "", businessID: businessId, name: "", latitude: 0, longitude: 0, location: "", qrCode: "")
    }
    
    init(covidSign: CovidSign) {
        self.covidSign = covidSign
        self.$covidSign
            .dropFirst()
            .sink { [weak self] covidSign in
                self?.modified = true
            }
            .store(in: &self.cancellables)
    }
    
    func addCovidSign() {
        
        getLocation(from: covidSign.location) { [self] location in
            self.covidSign.latitude = location!.latitude
            self.covidSign.longitude =  location!.longitude
            
            let qrCode = UUID().uuidString
            self.covidSign.qrCode = "https://api.qrserver.com/v1/create-qr-code/?data=\(qrCode)"
            
            do {
                let _ = try db.collection("businessSign").addDocument(from: self.covidSign)
            }
            catch {
                print(error)
            }
        }
    }
    
    func getLocation(from address: String, completion: @escaping (_ location: CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemarks = placemarks,
            let location = placemarks.first?.location?.coordinate else {
                    completion(nil)
                    return
            }
            completion(location)
        }
    }
    
    func updateCovidSign() {
        getLocation(from: covidSign.location) { [self] location in
            self.covidSign.latitude = location!.latitude
            self.covidSign.longitude =  location!.longitude
            if let documentId = covidSign.id {
                do {
                    try db.collection("businessSign").document(documentId).setData(from: covidSign)
                    
                }
                catch {
                    print(error)
                }
            }
        }
    }
    
    func deleteCovidSign() {
        if let documentId = covidSign.id {
            db.collection("businessSign").document(documentId).delete() { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

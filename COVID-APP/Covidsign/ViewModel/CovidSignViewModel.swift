//
//  CovidSignView.swift
//  COVID-APP
//
//  Created by Taylah Galea on 20/5/21.
//
/*
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
    
    var locationAddress = ""
    
    private var cancellables = Set<AnyCancellable>()
    private let db = Firestore.firestore()
    private let businessId = "3NGsLaJPHvhhGXb9CCQv"
    
    init() {
        let businessRef = db.collection("business").document(businessId)
        covidSign = CovidSign(id: "", businessID: businessRef, name: "", location: GeoPoint(latitude: 0, longitude: 0), qrCode: "")
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
        
        let geoLocation = CLGeocoder()
        geoLocation.geocodeAddressString(locationAddress) { (placemarks, error) in
            let placemark = placemarks?.first
            let lat = Double(placemark?.location?.coordinate.latitude ?? 0)
            let lon = Double(placemark?.location?.coordinate.longitude ?? 0)
            print("lat: \(lat), lon: \(lon)")
            self.covidSign.location = GeoPoint(latitude: lat, longitude: lon)
        }
        let qrCode = UUID().uuidString
        self.covidSign.qrCode = "http://api.qrserver.com/v1/create-qr-code/?data=\(qrCode)"
        
        print(self.covidSign.location)
        do {
            let _ = try db.collection("businessSign").addDocument(from: covidSign)
        }
        catch {
            print(error)
        }
    }
    
    func updateCovidSign() {
        if let documentId = covidSign.id {
            do {
                try db.collection("businessSign").document(documentId).setData(from: covidSign)
                
            }
            catch {
                print(error)
            }
        }
    }
    
    func deleteDependent() {
        if let documentId = covidSign.id {
            db.collection("businessSign").document(documentId).delete() { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

 */

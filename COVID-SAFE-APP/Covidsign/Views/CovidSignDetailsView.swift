//
//  CovidSignDetailsView.swift
//  COVID-APP
//
//  Created by Taylah Galea on 20/5/21.
//

import SwiftUI
import Firebase
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import CoreLocation

extension String {
    func load() -> UIImage {
        do {
            guard let url = URL(string: self) else {
                return UIImage()
            }
            let data: Data = try Data(contentsOf: url)
            return UIImage(data: data) ?? UIImage()
        } catch {
            
        }
        return UIImage()
    }
}

struct CovidSignDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditCovidSignSheet = false
    @State var presentSaveQRCodeSheet = false
    
    var covidSign: CovidSign
    

    private func editButton(action: @escaping () -> Void) -> some View {
        Button(action: {action()}) {
            Text("Edit")
        }
    }
    
    
    var body: some View {
        Form {
            Section(header: Text("Location")) {
                Text("Address: \(covidSign.location)")
                let markers = [
                    Marker(title: covidSign.name, coordinate: .init(latitude: Double(covidSign.latitude), longitude: Double(covidSign.longitude)))
                ]
                MapView(viewModel: MapViewModel(lat: Double(covidSign.latitude), long: Double(covidSign.longitude), latD: 0.05, longD: 0.05), markers: markers)
                    .aspectRatio(contentMode: .fit)
                    .edgesIgnoringSafeArea(.all)
            }
            Section(header: Text("QR Code")) {
                Image(uiImage: covidSign.qrCode.load())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture {
                        self.handleQRTapped()
                    }
        
            }
            .navigationTitle("\(covidSign.name)")
        }
        .actionSheet(isPresented: $presentSaveQRCodeSheet) {
            ActionSheet(title: Text("Save QR code to photos?"),
                    buttons: [
                        .default(Text("Save"), action: {self.handleSaveQR()}),
                        .cancel()
                    ])
        }
        .navigationBarItems(trailing: editButton{
            self.presentEditCovidSignSheet.toggle()
        })
        .sheet(isPresented: self.$presentEditCovidSignSheet) {
            EditSignView(viewModel: CovidSignViewModel(covidSign: covidSign)) { result in
            if case .success(let action) = result, action == .delete {
                    self.presentationMode.wrappedValue.dismiss()
               }
            if case .success(let action) = result, action == .done {
                    self.presentationMode.wrappedValue.dismiss()
                    
               }
           }
        }
    }
    
    func handleQRTapped() {
        self.presentSaveQRCodeSheet.toggle();
    }
    
    func handleSaveQR() {
        let qrSaver = QRSaver()
        qrSaver.saveQR(image: covidSign.qrCode.load())
        self.dismiss()
    }
    
    func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

class QRSaver: NSObject {
    func saveQR(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingWithError: Error?, contextInfo: UnsafeRawPointer) {
        print("Save Finished!")
    }
}



struct CovidSignDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let businessId = "3NGsLaJPHvhhGXb9CCQv"
        let covidSign = CovidSign(id: "", businessID: businessId, name: "", latitude: 0, longitude: 0, location: "", qrCode: "")
        CovidSignDetailsView(covidSign: covidSign)
    }
}

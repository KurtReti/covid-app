//
//  CovidSignDetailsView.swift
//  COVID-APP
//
//  Created by Taylah Galea on 20/5/21.
//
/*
import SwiftUI
import Firebase
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct CovidSignDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditCovidSignSheet = false
    
    var covidSign: CovidSign
    
    private func editButton(action: @escaping () -> Void) -> some View {
        Button(action: {action()}) {
            Text("Edit")
        }
    }
    
    
    var body: some View {
        Form {
            Section(header: Text("Location")) {
                
            }
            Section(header: Text("QR Code")) {
                
            }
            .navigationTitle("\(covidSign.name)")
        }
        /*
        .navigationBarItems(trailing: editButton{
            self.presentEditDependentSheet.toggle()
        })
        .sheet(isPresented: self.$presentEditDependentSheet) {
           EditDependentView(viewModel: DependentViewModel(dependent: dependent)) { result in
            if case .success(let action) = result, action == .delete {
                    self.presentationMode.wrappedValue.dismiss()
               }
           }
        }
        */
    }
}

struct CovidSignDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let db = Firestore.firestore()
        let businessId = "3NGsLaJPHvhhGXb9CCQv"
        let businessRef = db.collection("business").document(businessId)
        let covidSign = CovidSign(id: "", businessID: businessRef, name: "", location: GeoPoint(latitude: 0, longitude: 0), qrCode: "")
        CovidSignDetailsView(covidSign: covidSign)
    }
}
*/

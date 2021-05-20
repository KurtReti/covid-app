//
//  DependentDetailsView.swift
//  COVID-APP
//
//  Created by Taylah Galea on 7/5/21.
//

import SwiftUI
import Firebase
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DependentDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditDependentSheet = false
    
    var dependent: Dependent
    
    private func editButton(action: @escaping () -> Void) -> some View {
        Button(action: {action()}) {
            Text("Edit")
        }
    }
    
    var body: some View {
        Form {
            Section(header: Text("Personal Details")) {
                Text("Name: \(dependent.firstname) \(dependent.surname)")
                Text("Address: \(dependent.address)")
                Text("Date of Birth: \(getDateFormatted())")
            }
            Section(header: Text("Contact Details")) {
                Text("Phone: \(dependent.phoneNo)")
                Text("Email: \(dependent.email)")
            }
            .navigationTitle("\(dependent.firstname) \(dependent.surname)")
        }
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
    }
    
    func getDateFormatted() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd/MM/yyyy"
        return dateformatter.string(from: dependent.dob?.dateValue() ?? Date())
    }
}

struct DependentDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let db = Firestore.firestore()
        let individualId = "JJI0UhxQrQOsDEg3r9Rk"
        let individualRef = db.collection("individual").document(individualId)
        let dependent = Dependent(id: "", individualID: individualRef, firstname: "", surname: "", address: "", phoneNo: "", email: "", dob: Timestamp())
        DependentDetailsView(dependent: dependent)
    }
}

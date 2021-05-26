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
                Text("Name: \(dependent.first_name) \(dependent.last_name)")
                Text("Address: \(dependent.address)")
                Text("Date of Birth: \(dependent.dob)")
            }
            Section(header: Text("Contact Details")) {
                Text("Phone: \(dependent.phoneNum)")
                Text("Email: \(dependent.email)")
            }
            .navigationTitle("\(dependent.first_name) \(dependent.last_name)")
        }
        .navigationBarItems(trailing: editButton{
            self.presentEditDependentSheet.toggle()
        })
        .sheet(isPresented: self.$presentEditDependentSheet) {
           EditDependentView(viewModel: DependentViewModel(dependent: dependent)) { result in
            if case .success(let action) = result, action == .delete {
                    self.presentationMode.wrappedValue.dismiss()
               }
            if case .success(let action) = result, action == .done {
                    self.presentationMode.wrappedValue.dismiss()
                    
               }
           }
        }
    }
}

struct DependentDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let individualId = "JJI0UhxQrQOsDEg3r9Rk"
        let dependent = Dependent(id: "", individualID: individualId, first_name: "", last_name: "", address: "", phoneNum: "", email: "", dob: "")
        DependentDetailsView(dependent: dependent)
    }
}

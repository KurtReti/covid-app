//
//  addDependentPopUp.swift
//  COVID-APP
//
//  Created by Taylah Galea on 27/4/21.
//

import SwiftUI
import FirebaseFirestore

struct AddDependentView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    @ObservedObject var viewModel = DependentViewModel()
    
    
    var cancelButton: some View {

        Button(action: self.handleCancelTapped) {
            Text("Cancel")
        }

    }
    
    var saveButton: some View {
        Button(action: self.handleDoneTapped) {
            Text("Save")
        }
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Details")) {
                    TextField("Given Name", text: $viewModel.dependent.first_name)
                    TextField("Surname", text: $viewModel.dependent.last_name)
                    TextField("Address", text: $viewModel.dependent.address)
                    DatePicker("Date of Birth", selection: $viewModel.dob, displayedComponents: .date)
                }
                Section(header: Text("Contact Details")) {
                    TextField("Phone Number", text: $viewModel.dependent.phoneNum)
                    TextField("Email Address", text: $viewModel.dependent.email)
                }
            }
            .navigationTitle("New Dependent")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(leading: cancelButton, trailing: saveButton)
        }
    }
    
    func handleCancelTapped() {
        self.dismiss()
    }
    
    func handleDoneTapped() {
        self.viewModel.addDependent()
        self.dismiss()
    }
    
    func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }
}


struct AddDependentView_Previews: PreviewProvider {
    static var previews: some View {
        AddDependentView()
    }
}

//
//  EditDependentView.swift
//  COVID-APP
//
//  Created by Taylah Galea on 7/5/21.
//

import SwiftUI

enum Action {
    case delete
    case done
    case cancel
}

struct EditDependentView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false

    @ObservedObject var viewModel = DependentViewModel()
    
    var completionHandler: ((Result<Action, Error>) -> Void)?
    
    var cancelButton: some View {

        Button(action: self.handleCancelTapped) {
            Text("Cancel")
        }

    }
    
    var saveButton: some View {
        Button(action: self.handleDoneTapped) {
            Text("Save")
        }.disabled(!viewModel.modified)
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
                Section {
                    Button("Delete Dependent") { self.presentActionSheet.toggle() }
                        .foregroundColor(.red)
                }
            }
            .navigationBarTitle("Edit Dependent")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(leading: cancelButton, trailing: saveButton)
            .actionSheet(isPresented: $presentActionSheet) {
                ActionSheet(title: Text("Are you sure?"),
                        buttons: [
                            .destructive(Text("Delete Dependent"), action: {self.handleDeleteTapped()}),
                            .cancel()
                        ])
            }
        }
    }
    
    func handleCancelTapped() {
        self.dismiss()
    }
    
    func handleDoneTapped() {
        self.viewModel.updateDependent()
        self.dismiss()
        self.completionHandler?(.success(.done))
    }
    
    func handleDeleteTapped() {
        viewModel.deleteDependent()
        self.dismiss()
        self.completionHandler?(.success(.delete))
    }
    
    func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct EditDependentView_Previews: PreviewProvider {
    static var previews: some View {
        EditDependentView()
    }
}

//
//  EditSignView.swift
//  COVID-SAFE-APP
//
//  Created by Taylah Galea on 25/5/21.
//

import SwiftUI

struct EditSignView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false

    @ObservedObject var viewModel = CovidSignViewModel()
    
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
                Section(header: Text("Set Covid Business Sign Details")) {
                    TextField("Name", text: $viewModel.covidSign.name)
                    TextField("Location Address", text: $viewModel.covidSign.location)
                    
                }
                Section {
                    Button("Delete Sign") { self.presentActionSheet.toggle() }
                        .foregroundColor(.red)
                }
            }
            .navigationBarTitle("Edit Sign Location")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(leading: cancelButton, trailing: saveButton)
            .actionSheet(isPresented: $presentActionSheet) {
                ActionSheet(title: Text("Are you sure?"),
                        buttons: [
                            .destructive(Text("Delete Sign"), action: {self.handleDeleteTapped()}),
                            .cancel()
                        ])
            }
        }
    }
    
    func handleCancelTapped() {
        self.dismiss()
    }
    
    func handleDoneTapped() {
        self.viewModel.updateCovidSign()
        self.dismiss()
        self.completionHandler?(.success(.done))
    }
    
    func handleDeleteTapped() {
        viewModel.deleteCovidSign()
        self.dismiss()
        self.completionHandler?(.success(.delete))
    }
    
    func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct EditSignView_Previews: PreviewProvider {
    static var previews: some View {
        EditSignView()
    }
}

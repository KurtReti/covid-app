//
//  AddSignView.swift
//  COVID-APP
//
//  Created by Taylah Galea on 13/5/21.
//

import SwiftUI

struct AddSignView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    @ObservedObject var viewModel = CovidSignViewModel()
    
    
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
                Section(header: Text("Set Covid Business Sign Details")) {
                    TextField("Name", text: $viewModel.covidSign.name)
                    TextField("Location Address", text: $viewModel.locationAddress)
                    
                }
            }
            .navigationTitle("New COVID Sign Location")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(leading: cancelButton, trailing: saveButton)
        }
    }
    
    func handleCancelTapped() {
        self.dismiss()
    }
    
    func handleDoneTapped() {
        self.viewModel.addCovidSign()
        self.dismiss()
    }
    
    func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddSignView_Previews: PreviewProvider {
    static var previews: some View {
        AddSignView()
    }
}

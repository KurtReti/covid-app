//
//  addDependentPopUp.swift
//  COVID-APP
//
//  Created by Taylah Galea on 27/4/21.
//

import SwiftUI
import FirebaseFirestore

struct AddDependentView: View {
    @ObservedObject var viewModel = DependentViewModel()
    
    /*
    var cancelButton: some View {

        Button(action: ) {
            Text("Cancel")
        }

    }
    
    var saveButton: some View {
        Button(action: self.viewModel.addDependent()) {
            
        }
    }
     */
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Details")) {
                    TextField("Given Name", text: $viewModel.dependent.firstname)
                }
            }
            .navigationTitle("New Dependent")
            //.navigationBarItems(leading: View, trailing: View)
        }
    }
}


struct AddDependentView_Previews: PreviewProvider {
    static var previews: some View {
        AddDependentView()
    }
}

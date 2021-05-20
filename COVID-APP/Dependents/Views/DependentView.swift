//
//  DependentView.swift
//  COVID-APP
//
//  Created by Taylah Galea on 21/4/21.
//

import SwiftUI
import Firebase
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DependentView: View {
    
    @StateObject var viewModel = DependentListViewModel()
    @State var addDependent = false
    
    private var addButton: some View {
        Button(action: {self.addDependent.toggle() }) {
            Image(systemName: "plus")
        }
    }
    
    var body: some View {
        VStack {
            NavigationView{
                List(viewModel.dependentsList) { dependent in
                    NavigationLink (destination: DependentDetailsView(dependent: dependent)) {
                            Text(dependent.firstname + " " + dependent.surname)
                        }
                    }
                .navigationBarTitle("My Dependents")
                .navigationBarItems(trailing: addButton)
                .onAppear() {
                    self.viewModel.fetchData()
                }
                .sheet(isPresented: self.$addDependent) {
                    AddDependentView()
                }
            }
        }
    }
}

struct DependentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DependentView()
        }
    }
}

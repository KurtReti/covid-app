//
//  VaccineSupplyView.swift
//  COVID-APP
//
//  Created by Connor Jones on 21/5/21.
//

import SwiftUI
import Firebase
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct VaccineSupplyView: View {
    @StateObject var viewModel = VaccineSupplyViewModel()
    @State var addVaccineBatch = false
    
    private var addButton: some View {
        Button(action: {self.addVaccineBatch.toggle()
            
        }) {
            Image(systemName: "plus")
        }
    }
    
    private var addVaccineBatchCard: some View {
        List(viewModel.vaccineBatchList) { vaccineBatch in
            VStack{
                HStack { Text("batch code:"); Text(vaccineBatch.id)}
                    .padding()
                Text(viewModel.vaccineDictionary[vaccineBatch.vaccineID]?.name ?? "Couldnt get name")
                    .padding()
                HStack { Text("Inventory:")
                    .padding()
                    Text(String(vaccineBatch.totalVaccines))}
                    .padding()
            }
            .padding(.leading)
            
        }
    }
    
    
    var body: some View {
        
        VStack{
            
            Text("")
            addVaccineBatchCard
            
        }
        .navigationBarTitle("Vaccine Supply")
        .navigationBarItems(trailing: addButton)
        
        .onAppear(){
            viewModel.fillVacineBatchList()
            viewModel.fillVacineDictionary()
        }
        .sheet(isPresented: self.$addVaccineBatch) {
            AddVaccineBatchView()
        }
        
        
    }
}





struct AddVaccineBatchView: View{
    @Environment(\.presentationMode) private var presentationMode
    
    @ObservedObject var viewModel = AddVaccinBatchViewModel()
    //@State var vaccine: Vaccine
    
    
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
                
                Section(header: Text("Vaccine Details")) {
                    
                    Picker(selection: $viewModel.vaccine, label: Text("Vaccine")) {
                        
                        ForEach(viewModel.vaccineList) { vaccine1 in
                            Text(vaccine1.name).tag(vaccine1)
                        }
                    }
                    TextField("Vaccine Amount", text: $viewModel.vaccineAmount).keyboardType(.numberPad)
                    
                }
                
                
            }
            .navigationTitle("Vaccine Order")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(leading: cancelButton, trailing: saveButton)
            //.navigationBarItems(leading: cancelButton, trailing: saveButton)
        }.onAppear(){
            viewModel.fillVaccineList()
        }
    }
    
    func handleCancelTapped() {
        self.dismiss()
    }
    
    func handleDoneTapped() {
        self.viewModel.addVaccineBatch()
        self.dismiss()
    }
    
    func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }
}





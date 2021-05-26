//
//  VaccineAdministrationView.swift
//  COVID-APP
//
//  Created by Connor Jones on 20/5/21.
//
import SwiftUI
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct VaccineAdministrationView: View {
    
    @Binding var medicare: String
    @Binding var isActive: Bool
    @StateObject var VaccineAdminVM = VaccineAdministrationViewModel()
    
    @State var index = 1

    var body: some View {
        
        
        
        //initila load is ongoing
        if VaccineAdminVM.intitialLoad == true{
            
            ProgressView().onAppear(){
                //goes through process of readying user data and vaccine info
                VaccineAdminVM.startProcess(medicare: medicare)
            }
            //initial load complete
        }else{
            Picker(selection: $index, label: Text("")) {
                Text("Vaccine Admin").tag(1)
                Text("Vaccine History").tag(0)
                
            }.pickerStyle(SegmentedPickerStyle())
            Spacer()
            if(index==1){
                
                AdmissionFormScreen
                Spacer()
            }else{
                VaccineHistoryScreen
                Spacer()
            }
            
            
        }
    
        
        
    }
    
    
    //Ui for confirming vaccine
    var AdmissionFormScreen: some View {
        VStack{
            
            
                
                Text("Vaccine Administration")
                    .font(.title)
                VStack(alignment: .leading){
                    Text("Indiviul Details")
                        .font(.headline)
                    HStack{
                        Text("Medicare Number:")
                        Text(medicare)
                        
                    }
                    HStack{
                        Text("First name:")
                        Text(VaccineAdminVM.currentIndividual.firstName)
                        
                    }
                    
                    HStack{
                        Text("Last name:")
                        Text(VaccineAdminVM.currentIndividual.lastName)
                        
                    }
                    
                    HStack{
                        Text("Date Of Birth:")
                        Text(VaccineAdminVM.currentIndividual.dob)
                        
                    }
                    HStack{
                        Text("Address:")
                        Text(VaccineAdminVM.currentIndividual.address)
                        
                    }
                }.font(.system(size: 14))
                .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                VStack{
   
                    HStack{
                        Text("Vaccine")
                        Picker(selection: $VaccineAdminVM.currentVaccine, label: Text("Vaccine")) {
                            
                            ForEach(VaccineAdminVM.vaccineList) { vaccine1 in
                                
                                Text(vaccine1.name).tag(vaccine1)
                            }
                    }
                }
                   
                   
                    
                    
                    
                    
                    
                    
                    
                    Button(action: {
                        //vaccination record created and vaccineBatch count subracted
                        VaccineAdminVM.generateVaccineAdmission()
                        medicare = ""
                        //will throw back to previous view Individual search
                        isActive = false
                        
                        
                        
                    }){
                        Text("Confirm")
                            .font(.body)
                            .foregroundColor(Color.white)
                            .background(RoundedRectangle(cornerRadius: 0)
                                            .foregroundColor(Color(#colorLiteral(red: 0.8900507092, green: 0.1440600455, blue: 0.0343856439, alpha: 1)))
                                            .frame(width: 300.0, height: 40.0))
                    }.padding(.bottom, 15)
                }
            
            
            
            
            
            
            
        }
        
        
        
        
        
        
    }
    
    //UI of list of previous vaccine of user
    var VaccineHistoryScreen: some View {
        VStack{
            
            
            
            // if(VaccineAdminVM.an){
            HStack{
                Text("Vaccine History")
                    .font(.headline)
                    .padding(.trailing)
                // }}
            }
            VStack{
                
                List(VaccineAdminVM.vaccinationList) { vaccination in
                    VStack{
                        
                        NavigationLink(destination: PreviousVaccineView(vaccination: vaccination, vaccineList: VaccineAdminVM.vaccineList, individual: VaccineAdminVM.currentIndividual, vaccine: VaccineAdminVM.currentVaccine, doseNum: "")){
                            Text(vaccination.doseDate)
                            
                            
                            
                            
                            
                            
                            
                        }
                    }
                    
                    
                }
                
            }
            
            
        }
        
        .navigationBarTitle("Vaccination Admission", displayMode: .inline)
        
        
        
    }
    
    
    
}

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
    @StateObject var VaccineAdminVM = VaccineAdministrationViewModel()
    @State var isActive = false
    //@State var intitialLoad = true
    @State var index = 1
    //@State var selectedDate = Date()
    @State private var selectedDatacenter = "test"
    //@State var showProfile = false
    var body: some View {
        
        
        
        
        if VaccineAdminVM.intitialLoad == true{
            
            ProgressView().onAppear(){
                VaccineAdminVM.vaccineHistorySearch(medicare: medicare)
            }
            
        }else{
            Picker(selection: $index, label: Text("What is your favorite color?")) {
                Text("Vaccine Admin").tag(1)
                Text("Vaccine History").tag(0)
                
            }.pickerStyle(SegmentedPickerStyle())
            Spacer()
            if(index==1){
                AdmissionFormScreen
            }else{
                VaccineHistoryScreen
                Spacer()
            }
            
            
        }
        //IndividualMedRecordScreen
        
        
    }
    
    
    var IndividualMedRecordScreen: some View {
        VStack{
            VStack(alignment: .leading){
                
                Text("Cerificate of Vaccinataion")
                    .font(.title)
                HStack{
                    Text("Medicare Number: ")
                    Text(VaccineAdminVM.medicareNum)
                    
                }
                
                HStack{
                    Text("Name:")
                    Text(VaccineAdminVM.currentIndividual.firstName)
                    
                    Text(VaccineAdminVM.currentIndividual.lastName)
                    
                    
                }
                
                HStack{
                    Text("Vaccine:")
                    Text(VaccineAdminVM.currentVaccine.name)
                        .multilineTextAlignment(.leading)
                    
                    
                    
                }
                
                HStack{
                    Text("Dose:")
                    Text("1 /")
                    Text("2")
                    
                    
                    
                    
                }
                
            }
            .padding(.leading)
            Spacer()
        }
        
    }
    
    //Ui for confirming vaccine
    var AdmissionFormScreen: some View {
        VStack{
            
            
            ScrollView{
                
                
                
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
                    Text("Vaccine Administered")
                        .font(.title)
                    
                    HStack{
                        Text("Vaccine")
                        Picker(selection: $VaccineAdminVM.selectedVaccineType, label: Text("Datacenter")) {
                            ForEach(VaccineAdminVM.vaccineList) { vaccine in
                                Text(vaccine.name).tag(vaccine.id)
                            }
                        }
                    }
                    
                    
                    Text(VaccineAdminVM.selectedVaccineType)
                    
                    
                    
                    
                    
                    Button(action: {
                        
                        VaccineAdminVM.generateVaccineAdmission()
                        
                        
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

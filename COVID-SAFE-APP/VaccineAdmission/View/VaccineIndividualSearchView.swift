//
//  VaccineIndividualSearchView.swift
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

struct VaccineIndividualSearchView: View {
    
    @State var test = ""
    @State var medicare = ""
    @StateObject var IndividualSearchVM = VaccineIndividualSearchViewModel()
    @State var isActive = false
    //@State var showProfile = false
    var body: some View {
        
        
        SearchScreen
        
        //IndividualMedRecordScreen
        Spacer()
        
    }
    
    
    var SearchScreen: some View {
        VStack{
            
            GroupBox() {
                Image("searchIcon")
                    .resizable()
                    .frame(width: 30.0, height: 30.0)
                    .opacity(1)
                Text("Search")
                    .font(.title)
                Text("Search Individual for vaccine history before completing vaccine administration")
                    .multilineTextAlignment(.center)
                Text("")
                
                //Spacer()
                TextField("Medicare Number", text: $medicare).frame(width: 300.0, height: 30.0).background(Color.white)
                    .padding(.bottom, 15)
                
                NavigationLink(destination: VaccineAdministrationView(medicare: $medicare), isActive: $IndividualSearchVM.isActive) {
                    Button(action: {
                        
                        IndividualSearchVM.vaccineHistorySearch(medicare: medicare)
                        
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
            .frame(width: 350.0, height: 300.0)
            // if(VaccineAdminVM.an){
            
            
            
            
        }
        
        .navigationBarTitle("Vaccination Admission", displayMode: .inline)
        
        
        
    }
    
    
    
    
    
}

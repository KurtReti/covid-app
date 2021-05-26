//
//  ContentView.swift
//  COVID-APP
//
//  Created by Taylah Galea on 25/3/21.
//

import SwiftUI
import Firebase
import Combine

struct ContentView: View {
    

    @Binding var logout: Bool
    @Binding var uField: String
    @Binding var pField: String
    var body: some View {
        
        
        //navigates to homescreen of specidied userType
        VStack{
            
            if(Singleton.shared.userType == "Individual"){
                
                HomeView(logout: self.$logout)
            
            }else if(Singleton.shared.userType == "Business"){
                BusinessHomeView(logout: self.$logout)
            }else if(Singleton.shared.userType == "HealthCentre"){
                HealthOfficialView(logout: self.$logout)
            }
        }.onAppear(){
            self.uField = ""
            self.pField = ""
        }
            .navigationBarBackButtonHidden(true)
    }
}













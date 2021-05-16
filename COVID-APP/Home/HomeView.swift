//
//  HomeView.swift
//  COVID-APP
//
//  Created by user188450 on 4/29/21.
//


//Contains home view and other views accessed from homeview
// feel free to move other view into seperate files

import SwiftUI
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct HomeView: View {
    
    //@EnvironmentObject var CurrentUser: User
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                
                VStack(alignment: .leading, spacing: 0.0) {
                    
                   // Text(CurrentUser.uid)
                    Text("hi")
                   // Text(CurrentUser.individualID ?? "")
                    
                    
                    
                    
                 /*   NavigationLink(destination: CheckInView()){
                        Text("Check-In")
                            .font(.headline)
                            .foregroundColor(.purple)
                            .multilineTextAlignment(.center)
                            
                            .frame(width: 160, height: 30)
                    
                        
                    } */
                    
                    
                    
                    NavigationLink(destination: VaccinesView()){
                        Text("Vaccines")
                            .font(.headline)
                            .foregroundColor(.purple)
                            .multilineTextAlignment(.center)
                            
                            .frame(width: 160, height: 30)
                        
                        
                    }
                    
                    
                    
                    NavigationLink(destination: AlertsView()){
                        Text("Alerts")
                            .font(.headline)
                            .foregroundColor(.purple)
                            .multilineTextAlignment(.center)
                            
                            .frame(width: 160, height: 30)
                        
                        
                        
                        
                        
                    }
                    NavigationLink(destination: RestrictionsView()){
                        Text("Restrictions")
                            .font(.headline)
                            .foregroundColor(.purple)
                            .multilineTextAlignment(.center)
                            
                            .frame(width: 160, height: 30)
                        
                        
                        
                        
                        
                    }
                    
                    
                    NavigationLink(destination: DependentView()){
                        Text("Dependents")
                            .font(.headline)
                            .foregroundColor(.purple)
                            .multilineTextAlignment(.center)
                            
                            .frame(width: 160, height: 30)
                        
                        
                        
                        
                        
                    }
                    
                }
                Spacer()
                    
                    .padding()
                
            }
            /* NavigationView {
             VStack {
             NavigationLink(destination: SecondView()) {
             Text("Show Detail View")
             }
             
             }
             } */
            .padding()
            Spacer()
            
        }//.environmentObject(CurrentUser)
    }
    
    
}





struct VaccinesView: View {
    
    var body: some View {
        VStack{}
    }
    
}

struct AlertsView: View {
    
    var body: some View {
        VStack{}
    }
    
}



struct RestrictionsView: View {
    
    var body: some View {
        VStack{}
    }
    
}




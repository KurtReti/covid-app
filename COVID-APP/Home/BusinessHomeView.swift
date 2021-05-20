//
//  BusinessHomeView.swift
//  COVID-APP
//
//  Created by user188450 on 5/10/21.
//

import SwiftUI

struct BusinessHomeView: View {
    
    @EnvironmentObject var CurrentUser: User

    var body: some View {
        
        NavigationView {
        VStack {
           
            
            VStack(alignment: .leading, spacing: 0.0) {
                
                Text(CurrentUser.uid)
                Text("Hello")
                
                

                
              
                
                
                
                
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

            }.environmentObject(CurrentUser)
    }
            
            
        }

struct BusinessHomeView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessHomeView()
    }
}

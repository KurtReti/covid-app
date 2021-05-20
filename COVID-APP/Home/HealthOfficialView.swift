//
//  HealthOfficialView.swift
//  COVID-APP
//
//  Created by Connor Jones on 17/5/21.
//

import SwiftUI

struct HealthOfficialView: View {
    var body: some View {
        
        NavigationView {
            VStack {
                
                
                VStack(alignment: .leading, spacing: 0.0) {
                    
                    
                    
                    
                    NavigationLink(destination: VaccineIndividualSearchView()){
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
            
        }.navigationViewStyle(StackNavigationViewStyle())//.environmentObject(CurrentUser)
    }
        
}


struct HealthOfficialView_Previews: PreviewProvider {
    static var previews: some View {
        HealthOfficialView()
    }
}



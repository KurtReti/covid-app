//
//  AlertsView.swift
//  COVID-APP
//
//  Created by Juliet Gobran on 19/5/21.
//

import SwiftUI
import Firebase
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct AlertsView: View {
    
    @ObservedObject private var viewModel = AlertsViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
                return List(viewModel.alerts){ alertsForUser in
                    VStack(alignment: .leading){
                        Text(alertsForUser.title)
                            .font(.headline)
                        Text(alertsForUser.message)
                            .font(.subheadline)
                    }
                }
                .onAppear() {
                    self.viewModel.fetchInfectedUsersID()
                }
                
                
            }
            .navigationTitle("Alerts")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(trailing: Image(systemName: "exclamationmark.circle")
                                    .font(.system(size: 34))
                                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))))
            
            
        }
        .accentColor(Color(#colorLiteral(red: 0.6196078431, green: 0, blue: 0, alpha: 1)))
        
    }
}

struct AlertsView_Preview: PreviewProvider {
    static var previews: some View {
        AlertsView()
    }
}


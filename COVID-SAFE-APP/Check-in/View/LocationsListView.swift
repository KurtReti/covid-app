//
//  LocationViewModel.swift
//  COVID-APP
//
//  Created by Megan Moss on 19/5/21.
//


import SwiftUI
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct LocationsListView: View {
    @StateObject private var viewModel = LocationsViewModel()
    

    var body: some View {
        VStack{
            if(viewModel.complete == true){
            List(viewModel.checkInList) { location in
                VStack {
                    Text(location.bName)
                    HStack{
                        Text("Address:")
                        Text(location.address)
                    }
                    HStack{
                        Text("check in:")
                        Text(location.signInTime)
                        Text(location.signInDate)
                    }
                    HStack{
                        Text("check out:")
                        Text(location.signOutTime)
                        Text(location.signOutDate)
                    }

            }
            }
            }
        }.onAppear(){
            viewModel.fetchData()
        }
            .navigationBarTitle("Previous Check Ins")

        
    }
}




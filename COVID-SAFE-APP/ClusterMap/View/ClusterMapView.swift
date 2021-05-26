//
//  ClusterMapView.swift
//  COVID-SAFE-APP
//
//  Created by Taylah Galea on 25/5/21.
//

import SwiftUI

struct ClusterMapView: View {
    
    @ObservedObject var viewModel = ClusterMapViewModel()
    
    var body: some View {
        List {
            Section(header: Text("COVID Safe Details")) {
                Text("Number of Individuals: \(viewModel.individualCount.count)")
                Text("Number of Businesses: \(viewModel.businessCount.count)")
                Text("Number of COVID Tests: \(viewModel.testsCount.count)")
                Text("Number of Vaccination: \(viewModel.vaccinationCount.count)")
            }
            Section(header: Text("COVID Cases")) {
                Text("Number of Positive Test Cases: \(viewModel.individualsWithCovid.count)")
                Text("Number of Covid Related Contacts: \(viewModel.covidRelatedSigns.count)")
                Text("Number of Covid Contact Locations: \(viewModel.markers.count)")
                MapView(viewModel: MapViewModel(lat: -25.688172, long: 134.273534, latD: 50, longD: 50), markers: viewModel.markers)
                    .aspectRatio(contentMode: .fit)
                    .edgesIgnoringSafeArea(.all)
            }
            Section(header: Text("COVID Statisics")) {
                Text("Percentage of individuals vaccinated: \(viewModel.individualCount.count)")
                Text("Percentage of affected individuals: \(viewModel.businessCount.count)")
                Text("Percentage of Positive Tests: \(viewModel.testsCount.count)")
            }
        }
        .navigationBarTitle("COVID Reports")
        .onAppear() {
            viewModel.fetchData()
            //viewModel.calStats()
        }
    }
}

struct ClusterMapView_Previews: PreviewProvider {
    static var previews: some View {
        ClusterMapView()
    }
}

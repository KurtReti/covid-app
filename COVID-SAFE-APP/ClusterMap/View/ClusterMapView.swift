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
        }
        .navigationBarTitle("COVID Report")
        .onAppear() {
            viewModel.fetchData()
        }
    }
}

struct ClusterMapView_Previews: PreviewProvider {
    static var previews: some View {
        ClusterMapView()
    }
}

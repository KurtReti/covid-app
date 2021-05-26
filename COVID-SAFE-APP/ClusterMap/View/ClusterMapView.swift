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
        NavigationView {
            List {
                MapView(viewModel: MapViewModel(lat: -25.688172, long: 134.273534, latD: 50, longD: 50), markers: viewModel.markers)
                    .aspectRatio(contentMode: .fit)
                    .edgesIgnoringSafeArea(.all)
            }
            .navigationBarTitle("Contact Locations")
            .onAppear() {
                viewModel.fetchData()
            }
        }
    }
}

struct ClusterMapView_Previews: PreviewProvider {
    static var previews: some View {
        ClusterMapView()
    }
}
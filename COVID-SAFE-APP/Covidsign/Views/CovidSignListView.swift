//
//  CovidSignListView.swift
//  COVID-APP
//
//  Created by Taylah Galea on 13/5/21.
//

import SwiftUI
import Firebase
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct CovidSignListView: View {
    
    @StateObject var viewModel = CovidSignListViewModel()
    @State var addCovidSign = false
    
    private var addButton: some View {
        Button(action: {self.addCovidSign.toggle() }) {
            Image(systemName: "plus")
        }
    }
    
    var body: some View {
        VStack {
            NavigationView{
                List(viewModel.covidSignList) { sign in
                    NavigationLink (destination: CovidSignDetailsView(covidSign: sign)) {
                            Text(sign.name)
                    }
                }
                .navigationBarTitle("COVID Signs")
                .navigationBarItems(trailing: addButton)
                .onAppear() {
                    self.viewModel.fetchData()
                }
                .sheet(isPresented: self.$addCovidSign) {
                    AddSignView()
                }
            }
        }
    }
}

struct CovidSignListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CovidSignListView()
        }
    }
}

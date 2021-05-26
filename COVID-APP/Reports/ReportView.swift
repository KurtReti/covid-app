//
//  ReportView.swift
//  COVID-APP
//
//  Created by Megan Moss on 24/5/21.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ReportView: View {
    @ObservedObject private var viewModel = ReportViewModel()
    
    var body: some View {

        VStack {
            Text("Number of Positive Test Cases")
            Text("\(viewModel.countOfInfectedUsers)")
        }
        .onAppear() {
            self.viewModel.fetchInfectedUsersID()
        }
    }
}

//
//  IndividualAlertsView.swift
//  COVID-APP
//
//  Created by Connor Jones on 24/5/21.
//

import SwiftUI

struct IndividualAlertsView: View {
    var body: some View {
 
        VStack{
            
        }
        
    }
}

import SwiftUI
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class IndividualAlertsViewModel: ObservableObject
{

    @Published var alertList = [AlertInd]()
    
    init() {
       
    }
    
    func getData() {
        // test
        
    }
    
}

import SwiftUI
import Firebase
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct AlertInd: Identifiable, Codable {
    var id: String?
    let type: String
    let description: String
    let individualID: String
    var checkIn: String
    var Date: String?
    var active: Bool
    
    
}


struct IndividualAlertsView_Previews: PreviewProvider {
    static var previews: some View {
        IndividualAlertsView()
    }
}

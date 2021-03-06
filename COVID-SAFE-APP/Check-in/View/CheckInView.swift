//
//  CheckIn.swift
//  COVID-APP
//
//  Created by Connor Jones on 15/5/21.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift



struct CheckInSelectorView: View {
    
    @State private var authPath = 0
    
    /* ... */
    
    var body: some View {
        
        
        CheckInView(authPath: $authPath)
        
        
    }
}

import CodeScanner

struct CheckInView: View {
    let date = Date()
    @Binding var authPath: Int
    @State private var isShowingScanner = false
    @State var index = 1
    //this is for easy access in testing
    var individualID = "zGWW38yv0hBL7Zw8mym0"
    //@AppStorage("indiID") var UID: String = "zGWW38yv0hBL7Zw8mym0"
    
    @StateObject var CheckInVM = CheckInVeiwModel()
    
    var body: some View {
        VStack {
            HStack {
                Picker(selection: $index, label: Text("What is your favorite color?")) {
                    Text("Scan").tag(1)
                    Text("Previous Check-in").tag(0)
                    
                } .pickerStyle(SegmentedPickerStyle())
            }
            
        }
        .navigationBarTitle("Check In", displayMode: .inline)
        
        
        
        
        if(index==0){
            Spacer()
            LocationsListView()
            Spacer()
            
        }else if(index==1){
            if CheckInVM.isLoading{
                Spacer()
                VStack{
                    ProgressView()
                }
                Spacer()
                
            }else{
                
                if CheckInVM.initialLoadComplete == false{
                    Spacer()
                    VStack{
                        
                        ProgressView().onAppear(){
                            CheckInVM.checkForCurrentCheckIn()}
                        //ttestScreen
                    }
                    Spacer()
                }else{
                    if CheckInVM.showCheckinPreview == true {
                        CheckInPreviewScreen
                        //checkinPreviewScreen
                    }else if(CheckInVM.checkinConfirmed == true){
                        CheckedInScreen
                        //checkinDisplayScreen
                    }else{
                        ScanScreen.onAppear(){CheckInVM.indID = self.individualID}
                        //scanScreen.onAppear(){CheckInVM.indID = self.individualID}
                    }
                }
            }
        }
        
    }
    
    // find this keeps the main view clean so we can see the state logic
    
/*    var visitHistory: some View {
        VStack{
        NavigationView {
            return List(CheckInVM.locations) { location in
                VStack {
                    HStack{
                       Text("Checkin: ")
                        Text(location.checkIn)
                    }
                        HStack{
                        Text("Checkout: ")
                        Text(location.checkOut!)
                    }
                    Text(location.businessSignID)
                    Text(location.checkIn)
                    Text(location.checkOut!)
                    Text("Hello")
                }
            }
            .navigationBarTitle("Previous Check Ins")
            .onAppear() {
                CheckInVM.fetchData()
            }
        }
        
        }
    } */

    
    var ScanScreen: some View {
        
        VStack{
            Spacer()
            GroupBox() {
                
                Text("")
                Text("Scan QR")
                    .font(.headline)
                    .frame(width: 300.0, height: 0.0)
                Image("qrImage")
                    .resizable()
                    .frame(width: 50.0, height: 50.0)
                
                
                Text("Press Scan")
                Text("To open camera")
                
                Text("Or enter url")
                
                
                TextField("url", text: $CheckInVM.url).background(Color.white)
                
                
                Button(action: {
                    CheckInVM.urlBusinessSign()
                    //CheckInVM.checkin()
                }){
                    Text("Confirm")
                        .font(.body)
                        .foregroundColor(Color.white)
                        .background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/)
                                        .foregroundColor(Color(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)))
                                        .frame(width: 200.0, height: 25.0))
                }
                
            }
            .frame(width: 300.0, height: 200.0)
            Spacer()
            
            Button(action: {
                isShowingScanner = true
                //CheckInVM.checkin()
            }){
                Text("Scan")
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(Color(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)))
                                    .frame(width: 350.0, height: 50.0))
            }.sheet(isPresented: $isShowingScanner){
                CodeScannerView(codeTypes: [.qr], simulatedData: "test", completion: self.handleScan)
            }
        }
    }
    var CheckedInScreen: some View {
        
        VStack{
            Spacer()
            GroupBox() {
                Image("Image")
                    .resizable()
                    .frame(width: 30.0, height: 30.0)
                Text("")
                Text(CheckInVM.currentBusiness.name)
                    .font(.headline)
                    .frame(width: 300.0, height: 0.0)
                Spacer()
                Text("Address:")
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                Text("\(CheckInVM.busSignLocation.name)")
                Text("Checked in:")
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                Text(CheckInVM.currentVisit.signInTime)
                Text(CheckInVM.currentVisit.signInDate)
                
                Text("")
                
            }
            .frame(width: 300.0, height: 200.0)
            Spacer()
            
            Button(action: {
                
                CheckInVM.checkout()
            }){
                Text("Check Out")
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(Color(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)))
                                    .frame(width: 350.0, height: 50.0))
            }
        }
    }
    
    var CheckInPreviewScreen: some View {
        
        VStack{
            Spacer()
            GroupBox() {
                Image("greyCircle")
                    .resizable()
                    .frame(width: 30.0, height: 30.0)
                    .opacity(0.4)
                Text("")
                Text(CheckInVM.currentBusiness.name)
                    .font(.headline)
                    .frame(width: 300.0, height: 0.0)
                Spacer()
                Text("Address:")
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                Text("\(CheckInVM.busSignLocation.location)")
                //Text(date, style: .time)
                Text("Time & Date:")
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                Text(CheckInVM.getFormattedTime())
                Text(CheckInVM.getFormattedDateAndTime())
                
                Text("")
                
            }
            .frame(width: 300.0, height: 200.0)
            Spacer()
            
            Button(action: {
                CheckInVM.checkIn()
            }){
                Text("Check in")
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(Color(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)))
                                    .frame(width: 350.0, height: 50.0))
            }
        }
    }
    
    
    
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>){
        self.isShowingScanner = false
        
        switch result {
        case .success(let code):
            //let details = code.components(separatedBy: "\n")
            // guard details.count == 2 else { return }
            // print("scan in")
            //word1 = code
            //word2 = code
            CheckInVM.qrCodeScan(qr: code)
            
        case .failure( _):
            print("scan failed")
        }
    }
}



//
//  LocationView.swift
//  COVID-APP
//
//  Created by Megan Moss on 19/5/21.
//


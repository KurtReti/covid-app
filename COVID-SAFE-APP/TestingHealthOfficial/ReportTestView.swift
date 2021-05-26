//
//  ReportTestView.swift
//  COVID-APP
//
//  Created by Connor Jones on 18/5/21.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ReportTestView: View {
    var accountID = "2de45fd4-6c05-4756-ace7-33f0f1bdd9f3"
    @State var medicare = ""
    @State var isActive = false
    @StateObject var ReportTestVM = ReportTestViewModel()
    var body: some View {
        
        
        //initial load prepares data
        if(ReportTestVM.initialLoad == false){
            ProgressView().onAppear(){
                ReportTestVM.healthOfficialID = accountID
                ReportTestVM.fetchData()
                
            }
            //shows medicare search
        }else{
        
            VStack{
               


                GroupBox() {
                    Image("searchIcon")
                        .resizable()
                        .frame(width: 30.0, height: 30.0)
                        .opacity(1)
                    Text("Search")
                        .font(.title)
                    Text("Search Individual by medicare number to confirm testing")
                        .multilineTextAlignment(.center)
                    Text("")
                   
                    //Spacer()
                    TextField("Medicare Number", text: $medicare).frame(width: 300.0, height: 30.0).background(Color.white)
                        .padding(.bottom, 15)
                    
                    NavigationLink(destination: TestScreen, isActive: $ReportTestVM.isActive) {
                                    Button(action: {
                                        
                                        ReportTestVM.individualSearch(medicare: medicare)
                                      
                                    }){
                                        Text("Confirm")
                                            .font(.body)
                                            .foregroundColor(Color.white)
                                            .background(RoundedRectangle(cornerRadius: 0)
                                                            .foregroundColor(Color(#colorLiteral(red: 0.8900507092, green: 0.1440600455, blue: 0.0343856439, alpha: 1)))
                                                            .frame(width: 300.0, height: 40.0))
                                    }.padding(.bottom, 15)
                    }
                    
                 

                
                  
                    
                }
                //.frame(width: 350.0, height: 300.0)
               // if(VaccineAdminVM.an){
              
               
             
                
            }
            
            .navigationBarTitle("Vaccination Admission", displayMode: .inline)

    }
            
        
    }
    
    
    var TestScreen: some View {
        VStack{
        
            Picker(selection: $ReportTestVM.positiveOrNegative, label: Text("What is your favorite color?")) {
                Text("Negative").tag(false)
                Text("Positive").tag(true)
                
            }
            
            
            Button(action: {

                ReportTestVM.reportTestResult()
                ReportTestVM.isActive = false
                medicare = ""
                //IndividualSearchVM.vaccineHistorySearch(medicare: medicare)
              
            }){
                Text("Confirm")
                    .font(.body)
                    .foregroundColor(Color.white)
                    .background(RoundedRectangle(cornerRadius: 0)
                                    .foregroundColor(Color(#colorLiteral(red: 0.8900507092, green: 0.1440600455, blue: 0.0343856439, alpha: 1)))
                                    .frame(width: 300.0, height: 40.0))
            }
         
            
        }
        


      
        
    }
}

struct ReportTestView_Previews: PreviewProvider {
    static var previews: some View {
        ReportTestView()
    }
}





class ReportTestViewModel: ObservableObject{
    
    private let db = Firestore.firestore()
    
    @Published var currentIndividual: Individual
    @Published var currentHealthOfficial: HealthOfficial
    @Published var currentTest: CovidTest
    @Published var isActive = false
    @Published var positiveOrNegative = false
    
    @Published var showProfile = false
    @Published var medicareNum = ""
    @Published var initialLoad = false
    var healthOfficialID = ""
    
    init() {
        currentIndividual = Individual(id: "", firstName: "", lastName: "", address: "", email: "", phoneNum: "", dob: "")
        
        currentHealthOfficial = HealthOfficial(id: "", firstName: "", lastName: "", address: "", email: "", phoneNum: "", occupation: "", dob: "", accessLevel: "", uid: "")
        
        currentTest = CovidTest(id: "", individualID: "", healthOfficialID: "", date: "", result: false, notes: "", bookingID: "", status: "")
        
        
        
    
        
    }
    
    func fetchData(){
        //gets health officials data
       
        db.collection("healthOfficial").whereField("accountID", isEqualTo: Singleton.shared.accountID ?? "").limit(to: 1).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
                
            } else {
                for document in querySnapshot!.documents {
                    
                    let data = document.data()
                    //  let id = document.documentID
                    let fsAccountID = data["accountID"] as? String ?? ""
                    let fsAddress = data["address"] as? String ?? ""
                    let fsDOB = data["dob"] as? String ?? ""
                    let fsEmail = data["email"] as? String ?? ""
                    let fsFirstName = data["first_name"] as? String ?? ""
                    let fsLastName = data["last_name"] as? String ?? ""
                    let fsPhoneNum = data["phoneNum"] as? String ?? ""
                    let fsAccessLevel = data["access_level"] as? String ?? ""
                    let fsOccupation = data["occupation"] as? String ?? ""
                    
                    
                    self.currentHealthOfficial = HealthOfficial(id: fsAccountID, firstName: fsFirstName, lastName: fsLastName, address: fsAddress, email: fsEmail, phoneNum: fsPhoneNum, occupation: fsOccupation, dob: fsDOB, accessLevel: fsAccessLevel)
                    
 
                }
                
                //
                //stops display of looading 
                self.initialLoad = true
                
                
            }
            
        }
        
        
    }
    
    func individualSearch(medicare: String){
        
       
        db.collection("individual").whereField("accountID", isEqualTo: medicare).limit(to: 1).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
                
            } else {
                for document in querySnapshot!.documents {
                    
                    let data = document.data()
                    //  let id = document.documentID
                    let fsAccountID = data["accountID"] as? String ?? ""
                    let fsAddress = data["address"] as? String ?? ""
                    let fsDOB = data["dob"] as? String ?? ""
                    let fsEmail = data["email"] as? String ?? ""
                    let fsFirstName = data["first_name"] as? String ?? ""
                    let fsLastName = data["last_name"] as? String ?? ""
                    let fsPhoneNum = data["phoneNum"] as? String ?? ""
                    
                    
                    self.currentIndividual = Individual(id: fsAccountID, firstName: fsFirstName, lastName: fsLastName, address: fsAddress, email: fsEmail, phoneNum: fsPhoneNum, dob: fsDOB)
                    
                 
                    print(fsFirstName)
                    //self.getVaccinationHistory()
                    
                    // self.getBusiness()
                    self.isActive = true
                    //do some error stuff
                }
                
                //
                
                
                
            }
            
        }

        
        
        
        
        
    }
    
    
    func reportTestResult(){
        
        let currentTimeDate = getFormattedDateAndTime()
        
        let ref = db.collection("testResult").document()
        //let busSignref = db.collection("businessSign").document(busSign.id!)
        //let indref = db.collection("individuals").document(UID)
        let idref = ref.documentID
        
        ref.setData(["resultID": idref, "bookingID": "placeholder", "healthOfficialID": Singleton.shared.accountID ?? "","individualID": self.currentIndividual.id as Any, "notes": "", "date": currentTimeDate, "result": positiveOrNegative]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                
                
        
                //self.isActive = true
                //self.isLoading = false
                //self.checkinConfirmed = true
                //self.showCheckinPreview = false
                
            }
        }

        
        
    }
    
    
    func getFormattedDateAndTime()->String{
        
        
        let inputFormatter = DateFormatter()
   
        inputFormatter.dateFormat = "dd/MM/yyyy"
        
        let myString = inputFormatter.string(from: Date())
        
        let yourDate = inputFormatter.date(from: myString)

        let myStringafd = inputFormatter.string(from: yourDate!)
        
      
        
        print(myStringafd)
        
        return myStringafd
    }
    
    
    
}





struct HomeTestView: View {

    var body: some View {
            VStack{
               
                NavigationView{
                NavigationLink(destination: ReportTestView()){
                    Text("text")
                        
                }
                    
                    
                    
                    
                    
                }
              

    
    
            }

      
        
    }
}

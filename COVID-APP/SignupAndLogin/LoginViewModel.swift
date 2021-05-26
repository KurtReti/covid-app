//
//  LoginViewModel.swift
//  COVID-APP
//
//  Created by Connor Jones on 23/4/21.
//

import Foundation
import Firebase
import SwiftUI
import FirebaseAuth
class LoginViewModel: ObservableObject
{
 
    @Published var password: String = ""
    @Published var email: String = ""
    
    @Published var loginComplete = false

    @Published var showErrorMessage = false
    
    @Published var loading = false
    
    @Published var userTypeLogin = -1
    
    //allows navigation to continue contentView where login is complete
    @Published var isActive = false
    
    
    
    
    
    
    
    func fieldEmpty() -> Bool
    {
        var result = false
        if email.isEmpty {
        
            showErrorMessage.toggle()
            print(showErrorMessage)
            result = true
        }else if password.isEmpty {
          
            showErrorMessage.toggle()
            result = true
        }
        showErrorMessage = true
        return result
    }
    
    //checks if account is of type business
    //if so login is completed and singleton is given it uid amd accountID and UserType
    //IsActive set to true an login is complete
    // if not move onto healtCentreCheck()
    func businessCheck(res: String) {
        let db = Firestore.firestore()
       
        
        
        
        db.collection("business").whereField("uid", isEqualTo: res).limit(to: 1).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
                
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let accountID = data["accountID"] as? String ?? ""
                    print("\(document.documentID) => \(document.data())")
                  
                    self.loginComplete = true
                    
                    Singleton.shared.UID = res
                    Singleton.shared.accountID = accountID
                    Singleton.shared.userType = "business"
                    self.loading = false
                    //takes to next view login complete
                    self.isActive = true
                    
                }
                
                self.healthCentreCheck(res: res)
    
 
                
            }
    }
 
    }
    
    //checks if account is of type health centre
    //if so login is completed and singleton is given it uid amd accountID and UserType
    //IsActive set to true an login is complete
    // if not move onto healtCentreCheck()
    func healthCentreCheck(res: String) {
        let db = Firestore.firestore()
       
        
        
        
        db.collection("healthCentre").whereField("uid", isEqualTo: res).limit(to: 1).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
                
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let accountID = data["healthCentreID"] as? String ?? ""
                    print("\(document.documentID) => \(document.data())")
                   
                    self.loginComplete = true
                    print(res)
                   
                    Singleton.shared.UID = res
                    Singleton.shared.accountID = accountID
                    Singleton.shared.userType = "HealthCentre"
                    self.loading = false
                    
                    self.isActive = true
                    
                }
              
               
                print(res)
                
                if(!self.loginComplete){
                self.loading = false
                self.showErrorMessage = true
                //self.loginComplete = true
                }

                
                
            }
    }
      //  return  false
    }
    
    
    //checks if account is of type Individual
    //if so login is completed and singleton is given it uid amd accountID and UserType
    //IsActive set to true an login is complete
    // if not move onto healtCentreCheck()
    func indCheck(res: String){
        let db = Firestore.firestore()
        print(getFormattedDateAndTime())
       
       // let indRef = db.collection("individuals")
        
        db.collection("individual").whereField("uid", isEqualTo: res).limit(to: 1).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
                
            } else {
                for document in querySnapshot!.documents {
                    print("118i")
                    //print("\(document.documentID) => \(document.data())")
                   // let indID = document.documentID
                    let data = document.data()
                    let accountID = data["accountID"] as? String ?? ""
                    print(accountID)
                   
                
                    self.loginComplete = true
                    Singleton.shared.accountID = accountID
                    Singleton.shared.userType = "Individual"
                    self.loading = false
                    self.isActive = true
                    
                }
                
                self.businessCheck(res: res)
                
                
            }
    }
  
    }
    func login(){
        self.loading = true
        
        Auth.auth().signIn(withEmail: self.email, password: self.password){(res, err) in
            
            if err != nil{
               
                    
                    print("failss")
                self.loading = false
                   self.showErrorMessage = true
                
                
            }else{
                self.indCheck(res: res!.user.uid)
                
                
                                
                
                
            }

            
            
        }
        
        
        
    }
    

    
    
    
    
    
    func validateFields(){
        
        
        
        
        
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



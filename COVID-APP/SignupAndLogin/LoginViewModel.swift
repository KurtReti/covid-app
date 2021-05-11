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
    // info published on @Published
    /* https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-published-property-wrapper */
    
    @Published var userAuth = false
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var email: String = ""
    
    @Published var wrongLoginAlert = false
    @Published var loginComplete = false
    @Published var isLoading = false
    @Published var CurrentUser = User()
    @Published var showErrorMessage = false
    
    @Published var loading = false
    @State var error = false
    @AppStorage("UID") var UID: String = ""
    @Published var userTypeLogin = -1
    
    
    
    
    
    
    
    
    func fieldEmpty() -> Bool
    {
        var result = false
        if email.isEmpty {
            print("hi1")
            showErrorMessage.toggle()
            print(showErrorMessage)
            result = true
        }else if password.isEmpty {
            print("hi2")
            showErrorMessage.toggle()
            result = true
        }
        showErrorMessage = true
        return result
    }
    
    
    func businessCheck(res: String) {
        let db = Firestore.firestore()
       
        
        let citiesRef = db.collection("business")
        
        db.collection("business").whereField("uid", isEqualTo: res).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
                
            } else {
                for document in querySnapshot!.documents {
                    print("118b")
                    print("\(document.documentID) => \(document.data())")
                    self.userTypeLogin = 1
                    self.loginComplete = true
                    
                }
                print("123b")
                print(citiesRef.whereField("uid", isEqualTo: res))
                
                
            
                
                //self.loginComplete = true
                
                //var value = docRef.getString("username");
                print("132b")
                print(res)
                self.CurrentUser.uid = res
                self.UID = res
                //self.loading = false
                
            }
    }
      //  return  false
    }
    
    func indCheck(res: String){
        let db = Firestore.firestore()
       
        
        let citiesRef = db.collection("individual")
        
        db.collection("individual").whereField("uid", isEqualTo: res).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
                
            } else {
                for document in querySnapshot!.documents {
                    print("118i")
                    print("\(document.documentID) => \(document.data())")
                    self.userTypeLogin = 0
                    self.loginComplete = true
                   
                    
                }
                print("123i")
                print(citiesRef.whereField("uid", isEqualTo: res))
                
                
            
                
                //self.loginComplete = true
                
                //var value = docRef.getString("username");
                print("132i")
                print(res)
                self.CurrentUser.uid = res
                self.UID = res
                //self.loading = false
                
            }
    }
       // return  false
    }
    func login2(){
        Auth.auth().signIn(withEmail: self.email, password: self.password){(res, err) in
            
            if err != nil{
               
                    
                    print("fail")
                   self.showErrorMessage = true
                
                
            }else{
                self.businessCheck(res: res!.user.uid)
                
                self.indCheck(res: res!.user.uid)
                
                
                
            }
            print("great success!")
            
            
            
            print(self.loginComplete)
            
            
        }
        
        
        
    }
    

    
    
    
    
    
    func validateFields(){
        
        
        
        
        
    }
    
    
    
    
}

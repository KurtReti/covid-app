//
//  LoginViewModel.swift
//  COVID-APP
//
//  Created by Connor Jones on 23/4/21.
//

import Foundation
import Firebase
import SwiftUI
class LoginViewModel: ObservableObject
{
    // info published on @Published
/* https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-published-property-wrapper */
    
    @Published var userAuth = false
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var email: String = ""
    @Published var showErrorMessage = false
    @Published var wrongLoginAlert = false
    @Published var loginComplete = false
    @Published var isLoading = false
    @Published var CurrentUser = User()
    
    
    @State var loading = false
    @State var error = false
    @AppStorage("log_Status") var status = false
    @AppStorage("UID") var UID = ""
    
    @EnvironmentObject var session: SessionStore
    

    
    
   

    
    
    func login(){
        
        self.isLoading = true
        
        print("here")
        Auth.auth().signIn(withEmail: self.email, password: self.password){(res, err) in
            
            if err != nil{
DispatchQueue.main.async {

    print("fail")
    self.wrongLoginAlert = true
                            }
            
            
            }else{
                DispatchQueue.main.async {
                self.status = true
                    self.loginComplete = true
                    
                    self.UID = res!.user.uid
                }
            }
        print("great success!")
        
       
        
        print(self.loginComplete)
        
       
        }
    }
   
    
    

    
    
    func validateFields(){
        
        
        
        
        
    }
    

   
    
}

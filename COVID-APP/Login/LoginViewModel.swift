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
    
    @Published var wrongLoginAlert = false
    @Published var loginComplete = false
    @Published var isLoading = false
    @Published var CurrentUser = User()
    
    @State var loading = false
    @State var error = false
    @AppStorage("UID") var UID: String = ""
    
    
    
    
    
    
    
    
    
    
    
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
                
                self.loginComplete = true
                
                //var value = docRef.getString("username");
                
                print(res!.user.uid)
                self.CurrentUser.uid = res!.user.uid
                self.UID = res!.user.uid
                
                
                
                
                
            }
            print("great success!")
            
            
            
            print(self.loginComplete)
            
            
        }
    }
    
    
    
    
    
    
    func validateFields(){
        
        
        
        
        
    }
    
    
    
    
}

//
//  SignupViewModel.swift
//  COVID-APP
//
//  Created by Connor Jones on 17/4/21.
//
//this view model handles logic code for view. it takes requests and retrieves data from the model (database and classes) to be presented to view

import Foundation
import Firebase
//signupview will contain an object SignupViewModel
// where data and functions related to the view will be conatined
class SignupViewModel: ObservableObject
{
    // info published on @Published
/* https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-published-property-wrapper */
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var postcode: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var email: String = ""
    @Published var date = Date()
    @Published var showErrorMessage = false
    
    
    

    
    //validation functions
    func passwordMatch() -> Bool
    {
        password == confirmPassword
    }
    
    
    
    func fieldEmpty() -> Bool
    {
        var result = false
        if firstName.isEmpty {
            print("hi1")
            showErrorMessage.toggle()
            print(showErrorMessage)
            result = true
        }else if firstName.isEmpty {
            print("hi2")
            showErrorMessage.toggle()
            result = true
        }else if lastName.isEmpty {
            showErrorMessage.toggle()
            result = true
        }else if postcode.isEmpty {
            showErrorMessage.toggle()
            result = true
        }else if confirmPassword.isEmpty {
            showErrorMessage.toggle()
            result = true
        }else if email.isEmpty {
            showErrorMessage.toggle()
            result = true
        }
        showErrorMessage = true
        return result
    }
    
    func validateFields(){
        
        
        
        
        
    }
    
    //registers the user
    func register(){
        
        //validate the fields
        //create user
        //transition to homescreen
    
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        
        
        var dob: String = formatter1.string(from: self.date)
        
        print("here")
        Auth.auth().createUser(withEmail: self.email, password: self.password){(res, err) in if err != nil{
            print("fail")
           
            
        }else{
            //after sucessfull user register, individual data is added and linked to email/password by UID
            let db = Firestore.firestore()
            db.collection("individual").addDocument(data: ["firstname":self.firstName, "lastname": self.lastName,"DOB": dob, "postcode": self.postcode, "uid": res!.user.uid ]) { (error) in
                
                if error != nil {
                    //show error
                    print("error in ind")
                
                }
            }
        } }
    }
    
}

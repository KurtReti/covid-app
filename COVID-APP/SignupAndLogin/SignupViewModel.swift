//
//  SignupViewModel.swift
//  COVID-APP
//
//  Created by Connor Jones on 17/4/21.
//
//this view model handles logic code for view. it takes requests and retrieves data from the model (database and classes) to be presented to view

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
//signupview will contain an object SignupViewModel
// where data and functions related to the view will be conatined
class IndividualSignupViewModel: ObservableObject
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
    
    
    // checks if any fields are empty
    //needs to be cleaned up
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
       // }else if confirmPassword.isEmpty {
          //  showErrorMessage.toggle()
           // result = true
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
        print(self.email)
        print(self.password)
        print(self.firstName)
        print(self.lastName)
        print(self.lastName)
        print(self.date)
        print(self.postcode)
        Auth.auth().createUser(withEmail: self.email, password: self.password){(res, err) in if err != nil{
            print("fail")
           
            
        }else{
            //after sucessfull user register, individual data is added and linked to email/password by UID
            print("fail")
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


class busSignupViewModel: ObservableObject
{
    // info published on @Published
/* https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-published-property-wrapper */
    
    @Published var name: String = ""
    @Published var ABN: String = ""
    @Published var bType: String = ""
    @Published var address: String = ""
    @Published var phoneNum: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var showErrorMessage = false

        
    
    //validation functions
    func passwordMatch() -> Bool
    {
        password == confirmPassword
    }
    
    
    // checks if any fields are empty
    //needs to be cleaned up
    func fieldEmpty() -> Bool
    {
        var result = false
        
        
        
        if name.isEmpty {
            print("hi1")
            //showErrorMessage.toggle()
           //print(showErrorMessage)
            result = true
        }else if ABN.isEmpty {
            print("hi2")
            //showErrorMessage.toggle()
            result = true
        }else if bType.isEmpty {
            print("hi3")
            //showErrorMessage.toggle()
            result = true
        }else if address.isEmpty {
            print("hi4")
            //showErrorMessage.toggle()
            result = true
       }else if email.isEmpty {
        print("hi5")
            //showErrorMessage.toggle()
           result = true
        }else if password.isEmpty {
            print("hi6")
            //showErrorMessage.toggle()
            result = true
        }else if confirmPassword.isEmpty {
            print("hi7")
            //showErrorMessage.toggle()
            result = true
        }
        //showErrorMessage = true
        return result
    }
    
    func validateFields(){
        
        
        
        
        
    }
    
    //registers the user
    func register(){
        
        //validate the fields
        //create user
        //transition to homescreen
    
       // let formatter1 = DateFormatter()
        //formatter1.dateStyle = .short
        
        
        //var dob: String = formatter1.string(from: self.date)
        
        
        Auth.auth().createUser(withEmail: self.email, password: self.password){(res, err) in if err != nil{
            print("fail")
           
            
        }else{
            //after sucessfull user register, individual data is added and linked to email/password by UID
            
            let db = Firestore.firestore()
            db.collection("business").addDocument(data: ["ABN":self.ABN, "name": self.name,"type": self.bType, "address": self.address, "uid": res!.user.uid ]) { (error) in
                
                if error != nil {
                    //show error
                    print("error in bus")
                
                }
            }
        } }
    }
    
}

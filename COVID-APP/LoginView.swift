//
//  LoginView.swift
//  COVID-APP
//
//  Created by Connor Jones on 13/4/21.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State var userAuth = false
    @State var username: String = ""
    @State var password: String = ""
    @State var email: String = ""
    @State private var showingSheet = false
    @State var wrongLoginAlert = false
    @Binding var index: Int
    @Binding var buttonBackground1: Color
    @Binding var buttonBackground2: Color
    @Binding var loginComplete: Bool
    
    var accentColor: Color = Color.blue
    var grayBackground: Color = Color.gray.opacity(0.2)
    
    
    
    var body: some View {
        VStack{
            
            TextField("Email", text: $email)
                .overlay(VStack{Divider().offset(x: 0, y: 15)})
                .padding()
                
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            SecureField("Password", text: $password)
                .overlay(VStack{Divider().offset(x: 0, y: 15)})
                .padding()
                
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            Text("Forgot my password")
                .font(.caption)
                .foregroundColor(.accentColor)
                .fontWeight(.semibold)
                .padding(.bottom, 20)
            
            
            Button(action: {
                login()
              
            
            }){
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 320, height: 50)
                    .background(accentColor)
                    .cornerRadius(15.0)
            }.padding(.bottom, 20)
            .padding()
            
    
            
            
        }.alert(isPresented: $wrongLoginAlert) {
            Alert(title: Text("Please try again"), message: Text("Username and password do not match our records"), dismissButton: .default(Text("OK")))
        }
        
        
        
    }
    func login(){
        print("here")
        Auth.auth().signIn(withEmail: self.email, password: self.password){(res, err) in if err != nil{
            print("fail")
            wrongLoginAlert = true
            
            return
        }
        print("great success!")
        loginComplete = true
       
        }
    }
    
    func quickUserLogin(){
        print("here")
        Auth.auth().signIn(withEmail: self.email, password: self.password){(res, err) in if err != nil{
            print("fail")
            wrongLoginAlert = true
            
            return
        }
        print("great success!")
        loginComplete = true
       
        }
    }
    
    func quickBusinessLogin(){
        print("here")
        Auth.auth().signIn(withEmail: self.email, password: self.password){(res, err) in if err != nil{
            print("fail")
            wrongLoginAlert = true
            
            return
        }
        print("great success!")
        loginComplete = true
       
        }
    }
    
    func quickHealthlogin(){
        print("here")
        Auth.auth().signIn(withEmail: self.email, password: self.password){(res, err) in if err != nil{
            print("fail")
            wrongLoginAlert = true
            
            return
        }
        print("great success!")
        loginComplete = true
       
        }
    }
}


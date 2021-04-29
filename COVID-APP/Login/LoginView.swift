//
//  LoginView.swift
//  COVID-APP
//
//  Created by Connor Jones on 13/4/21.
//

import SwiftUI
import Firebase

struct LoginView: View {
    
    @State var loginVM = LoginViewModel()
    @State var username: String = ""
    @State var password: String = ""
    @State var email: String = ""
    @State var wrongLoginAlert = false
    
    @AppStorage("UID") var UID: String = ""
    @EnvironmentObject var CurrentUser: User
    
    
    @Binding var index: Int
    @Binding var buttonBackground1: Color
    @Binding var buttonBackground2: Color
    @Binding var loginComplete: Bool
    
    
    var accentColor: Color = Color.blue
    var grayBackground: Color = Color.gray.opacity(0.2)
    
    
    
    var body: some View {
        
        if loginVM.loginComplete {
            
        }
        VStack{
            
            TextField("Email", text: $loginVM.email)
                .autocapitalization(.none)
                .overlay(VStack{Divider().offset(x: 0, y: 15)})
                .padding()
                
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            SecureField("Password", text: $loginVM.password)
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
                
                // problem with this. it finishes function before firebase login is done.
                //the dispatchqueue is a quickfix
                loginVM.login()
                
                // really need to figure out async firebase request. this adds a 2 second wait so the function above has recieved the firebase call (very hacky)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    
                    if loginVM.loginComplete {
 
                        CurrentUser.uid = UID
                        
                        self.loginComplete = true
 
                    }else{ wrongLoginAlert = true}
                }
                
                //login()
                
                
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
    
    
    
    
    
}




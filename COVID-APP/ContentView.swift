//
//  ContentView.swift
//  COVID-APP
//
//  Created by Taylah Galea on 25/3/21.
//

import SwiftUI
import Firebase
import Combine

struct ContentView: View {
    
    
    @State var index = 0
    @State var loginComplete = false
    @State var showMenu = false
    

    
    @State var buttonBackground1: Color = Color.blue
    @State var buttonBackground2: Color = Color.gray.opacity(0.2)

    @AppStorage("log_Status") var status = false
    @AppStorage("UID") var UID = ""
    @StateObject var CurrentUser = User()
    
    //@EnvironmentObject var session: SessionStore
    
 
    func getUser () {
       // session.listen()
    }
    
    var body: some View {
        
       
        
        
        if loginComplete {
            
            HomeView().environmentObject(CurrentUser)
    
        }else{
            //only way i've been able to keep the heading and toggle buttons at the top
            //not sure if best way
            //top half remains the same. if statements below control whether signup or login shows
        ZStack{
            ZStack(alignment: .top) {
                
                Color.clear
                VStack{
                    
                    Text("Covid Safety")
                        .font(.largeTitle)
                        .foregroundColor(.accentColor)
                        .fontWeight(.semibold)
                        .padding(.bottom, 20)
                    
                    //login and signup toggle buttons
                    HStack(alignment: .center) {
                        
                        Button(action: {
                           
                            self.index = 0
                            self.buttonBackground1 = Color.blue
                            self.buttonBackground2 = Color.gray.opacity(0.2)
                            
                            
                            
                        }){
                            Text("Login")
                                .font(.headline)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(width: 160, height: 30)
                                
                                .background(buttonBackground1)
                                .cornerRadius(15.0)
                            
                            
                        }
                        
                        Button(action: {
                            self.index = 1
                            self.buttonBackground1 = Color.gray.opacity(0.2)
                            self.buttonBackground2 = Color.blue
                        }){
                            Text("Sign Up")
                                .font(.headline)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(width: 160, height: 30)
                                .background(buttonBackground2)
                                .cornerRadius(15.0)
                                .navigationBarBackButtonHidden(true)
                                .navigationBarHidden(true)
                            
                            
                        }
                        
                    }
                }
            }.padding(EdgeInsets.init(top: 100, leading: 0, bottom: 50, trailing: 0))
        }
        //.onAppear(perform: getUser)
        
        
            
            
            
            
            //index is tied which view is shown, login or signup
            if self.index == 0 {
                //index is needed to be past in as it is bound to index of contentview
                //allowing for switch to signup on button press within LoginView
                //the colours of the toggle buttons login/signup are tied to content view and need to be accessed within LoginView (might be a better way to do this)
                //loginComplete will allow the HomeView to be accessed when set to true with user login
            
                LoginView(index: $index, buttonBackground1: $buttonBackground1, buttonBackground2: $buttonBackground2, loginComplete: $loginComplete).environmentObject(CurrentUser)

                
                
                
            }else if self.index == 1{
                //index is needed to be past as it is bound to index of contentview
                //allowing for switch to LoginView on button press within SignUpView
                // loginc
                SignUpView(index: $index, buttonBackground1: $buttonBackground1, buttonBackground2: $buttonBackground2  )
                
                
            }
            
            
            
            
            
        
        
        }
    }
}











        
        


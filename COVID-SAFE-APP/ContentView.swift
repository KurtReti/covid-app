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
    
    
    @State var index = -1
    @State var loginComplete = false
    @State var showMenu = false
    @State var loading = false
    @State var userTypeLogin = -1
    
  
    
    @AppStorage("log_Status") var status = false
    @AppStorage("UID") var UID = ""
    @StateObject var CurrentUser = User()
    
    //@EnvironmentObject var session: SessionStore
    
    
    func getUser () {
        // session.listen()
    }
    
    var body: some View {
        
        
        
        
        if loginComplete {
            
            if userTypeLogin == 0  {
                LoadingView(isShowing: $loading) {
                
                HomeView().environmentObject(CurrentUser)
                    
                }
            }else if userTypeLogin == 1 {
                BusinessHomeView().environmentObject(CurrentUser)
                
            }
            
            
            
        }else{
            //only way i've been able to keep the heading and toggle buttons at the top
            //not sure if best way
            //top half remains the same. if statements below control whether signup or login shows
            
            
            
            //.onAppear(perform: getUser)
            
            if (self.index == -1){
                LoginOptionsView(index: self.$index)
            }else if (self.index == 0 || self.index == 1){
                
                //loading = true
                LoadingView(isShowing: $loading) {
                    
                    LoginSignupView(index: self.$index, loading: $loading, loginComplete: $loginComplete, userTypeLogin: $userTypeLogin ).environmentObject(CurrentUser)
                    
                }
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
        }
        
    }
}













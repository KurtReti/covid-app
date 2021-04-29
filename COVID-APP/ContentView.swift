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
    
    //@State var UID
    
    @State var buttonBackground1: Color = Color.blue
    @State var buttonBackground2: Color = Color.gray.opacity(0.2)

    @AppStorage("log_Status") var status = false
    @AppStorage("UID") var UID = ""
    
    @EnvironmentObject var session: SessionStore
    
 
    func getUser () {
        session.listen()
    }
    
    var body: some View {
        
       
        
        
        if loginComplete {
            
            HomeView()
    
        }else{
            //only way i've been able to keep the heading and toggle buttons at the top
            //not sure if best way
            //top half remains the same as if statements below control whether signup or login shows
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
        
        
            
            
            
            
            //index is tied to state of what view is shown, login or signup
            if self.index == 0 {
                //index is needed to be past in as it is bound to index of contentview
                //allowing for switch to signup on button press within LoginView
                //the colours of the toggle buttons login/signup are tied to content view and need to be accessed within LoginView (might be a better way to do this)
                //loginComplete will allow the HomeView to be accessed when set to true with user login
                LoginView(index: $index, buttonBackground1: $buttonBackground1, buttonBackground2: $buttonBackground2, loginComplete: $loginComplete).environmentObject(SessionStore())

                
                
                
            }else if self.index == 1{
                //index is needed to be past as it is bound to index of contentview
                //allowing for switch to LoginView on button press within SignUpView
                // loginc
                SignUpView(index: $index, buttonBackground1: $buttonBackground1, buttonBackground2: $buttonBackground2  )
                
                
            }
            
            
            
            
            
        
        
        }
    }
}










struct HomeView: View {
   
    @AppStorage("UID") var UID = ""
    @State var user:User?
    init() {
        user = User(uid: UID, displayName: "hi")
    }
    var body: some View {
        
        NavigationView {
        VStack {
           
            
            VStack(alignment: .leading, spacing: 0.0) {
                NavigationLink(destination: CheckinView()){
                Text(UID)
                    .font(.headline)
                    .foregroundColor(.purple)
                    .multilineTextAlignment(.center)
                    
                    .frame(width: 160, height: 30)
                    
                    
                    
                
                
            }
                NavigationLink(destination: VaccinesView()){
                Text("Vaccines")
                    .font(.headline)
                    .foregroundColor(.purple)
                    .multilineTextAlignment(.center)
                    
                    .frame(width: 160, height: 30)
          
                
            }
                
                
                
                NavigationLink(destination: AlertsView()){
                Text("Alerts")
                    .font(.headline)
                    .foregroundColor(.purple)
                    .multilineTextAlignment(.center)
                  
                    .frame(width: 160, height: 30)
                    
                    
                   
                
                
            }
                NavigationLink(destination: RestrictionsView()){
                Text("Restrictions")
                    .font(.headline)
                    .foregroundColor(.purple)
                    .multilineTextAlignment(.center)
                   
                    .frame(width: 160, height: 30)
                    
                    
                    
                
                
            }
                
                NavigationLink(destination: MenuView()){
                Text("Settings")
                    .font(.headline)
                    .foregroundColor(.purple)
                    .multilineTextAlignment(.center)
                   
                    .frame(width: 160, height: 30)
                    
                    
                    
                
                
            }
                
            }
            Spacer()
           
            .padding()
            
        }
       /* NavigationView {
                   VStack {
                       NavigationLink(destination: SecondView()) {
                           Text("Show Detail View")
                       }
                       
                   }
               } */
            .padding()
                Spacer()

            }
    }
            
            
        }
        
        
struct MenuView: View {
    
    
    @AppStorage("log_Status") var status = false
    
    var body: some View {
       
        VStack(alignment: .trailing) {
                    HStack {
                        Button(action: {
                        print("Edit button was tapped")
                    }) {
                            Image(systemName: "person")
                                .foregroundColor(.gray)
                                .imageScale(.large)
                            Text("Profile")
                                .foregroundColor(.purple)
                                .font(.headline)
                    }
                        
                    }
                    .padding(.top, 100)
                    HStack {
                        
                        Button(action: {
                           
                        print("Edit button was tapped")
                    }) {
                        Image(systemName: "envelope")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                        Text("Settings")
                            .foregroundColor(.purple)
                            .font(.headline)
                        }
                    }
                        .padding(.top, 30)
                    HStack {
                        Button(action: {
                           // self.showMenu = false
                            self.status = false
                    }) {
                        Image(systemName: "gear")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                        Text("Logout")
                            .foregroundColor(.purple)
                            .font(.headline)
                        }
                    }
                    .padding(.top, 30)
                    Spacer()
                }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    //.background(Color(red: 32/255, green: 32/255, blue: 32/255))
                    .edgesIgnoringSafeArea(.all)
            }

           

    
         
         
     }
struct CheckinView: View {
    
    var body: some View {
        VStack{}
    }
    
}


struct VaccinesView: View {
    
    var body: some View {
        VStack{}
    }
    
}

struct AlertsView: View {
    
    var body: some View {
        VStack{}
    }
    
}



struct RestrictionsView: View {
    
    var body: some View {
        VStack{}
    }
    
}

//https://stackoverflow.com/questions/62083056/how-do-i-rerender-my-view-in-swiftui-after-a-user-logged-in-with-google-on-fireb


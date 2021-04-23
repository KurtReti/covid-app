//
//  ContentView.swift
//  COVID-APP
//
//  Created by Taylah Galea on 25/3/21.
//

import SwiftUI
import Firebase





struct ContentView: View {
    @State var index = 0
    @State var loginComplete = false
    @State var showMenu = false
    
    
    @State var buttonBackground1: Color = Color.blue
    @State var buttonBackground2: Color = Color.gray.opacity(0.2)
    
    init(){
        
        
    }
    
    //not using atm
    func swapButtonColors(swapNumber: Int){
        if swapNumber == 0{
            buttonBackground1 = Color.blue
            buttonBackground2 = Color.gray.opacity(0.2)
        }else{
            buttonBackground2 = Color.blue
            buttonBackground1 = Color.gray.opacity(0.2)
        }
        
    }
    
    var body: some View {
        
        
        if self.loginComplete == true {
          
            
            let drag = DragGesture()
                .onEnded {
                    if $0.translation.width > -100 {
                        withAnimation {
                            self.showMenu = false
                        }
                    }
                }
            
            GeometryReader { geometry in
                ZStack(alignment: .trailing) {
                HomeView(showMenu: self.$showMenu)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                if self.showMenu {
                                    MenuView()
                                        .frame(width: geometry.size.width/2)
                                        .transition(.move(edge: .trailing))
                                }
                    }
            .gesture(drag)
            }
    
        }else{
            //only way i've been able to keep the heading and toggle buttons at the top
            //not sure if best way
            //top half remains the same as if statements bellow control whether signup or login shows
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
        
        
            
            
            
            
            //index is tied to state of what view is shown, login or signup
            if self.index == 0 {
                //index is needed to be past in as it is bound to index of contentview
                //allowing for switch to signup on button press within LoginView
                //the colours of the toggle buttons login/signup are tied to content view and need to be accessed within LoginView (might be a better way to do this)
                //loginComplete will allow the HomeView to be accessed when set to true with user login
                LoginView(index: $index, buttonBackground1: $buttonBackground1, buttonBackground2: $buttonBackground2, loginComplete: $loginComplete )
                
                
                
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
   
    
    @Binding var showMenu: Bool
    
    var body: some View {
        
        VStack {
           
        HStack {

            Spacer()
             
            Button(action: {
                self.showMenu = true
                  }) {
                Image(systemName: "gear")
                     
                  }
                    .padding(.trailing, 10)
                    .padding(.top, 10)
          
           
        }
            Spacer()
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
        
        
struct MenuView: View {
   
    
    
    
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
                                .foregroundColor(.gray)
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
                        Text("Messages")
                            .foregroundColor(.gray)
                            .font(.headline)
                        }
                    }
                        .padding(.top, 30)
                    HStack {
                        Button(action: {
                        print("Edit button was tapped")
                    }) {
                        Image(systemName: "gear")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                        Text("Settings")
                            .foregroundColor(.gray)
                            .font(.headline)
                        }
                    }
                    .padding(.top, 30)
                    Spacer()
                }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(red: 32/255, green: 32/255, blue: 32/255))
                    .edgesIgnoringSafeArea(.all)
            }

           

    
         
         
     }

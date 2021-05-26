//
//  LoginSignupView.swift
//  COVID-APP
//
//  Created by user188450 on 5/11/21.
//

import SwiftUI

struct LoginSignupView: View {
    
        @State var index:  Int
        @State var userTypeIndex = 0
        @StateObject private var LoginVM = LoginViewModel()
        @StateObject private var indSignupVM = IndividualSignupViewModel()
        @StateObject private var busSignupVM = busSignupViewModel()
        @State var showErrorMessage = false
       
       
        var body: some View {
            if(LoginVM.loading){
                ProgressView()
            }else{
                NavigationView{
            VStack{
                logoHeader
                Spacer()
                    .frame(width:400, height:30)
                loginSignupPicker
                Spacer()
                    .frame(width:400, height:30)
                
                if (index == 0)
                {
                    loginForm
                    
                }
                else
                {
                    userTypePicker
                    
                    if (userTypeIndex == 0 ){
                        
                        individualForm
                        
                    }else{
                        
                        businessForm
                        
                        
                    }
                }
                Spacer()
                
            }.padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }
        }
            
        }
    
    
    var logoHeader: some View{
        VStack{
        HStack{
            Image("Virus")
                .resizable()
                .frame(width: 130, height: 130)
            VStack(alignment: .leading){
                Text("COVID")
                    .font(.system(size:30))
                    .fontWeight(.heavy)
                    .foregroundColor(Color(#colorLiteral(red: 0.6196078431, green: 0, blue: 0, alpha: 1)))
                Text("SAFETY")
                    .font(.system(size:30))
                    .fontWeight(.heavy)
                    .foregroundColor(Color(#colorLiteral(red: 0.6196078431, green: 0, blue: 0, alpha: 1)))
            }
        }
        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/)
            .frame(width: 300, height: 1)
            .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
    }
    }
    
    var loginSignupPicker: some View{
        VStack{
        Picker(selection: $index, label: Text("")) {
            Text("Log in").tag(0)
            Text("Sign up").tag(1)
            
        }
        .frame(width: 350)
        .pickerStyle(SegmentedPickerStyle())
    }
    }
    var loginForm: some View{
    VStack{
    //THIS IS OKAY

    TextField("Email", text: $LoginVM.email).autocapitalization(.none)        .frame(width:350, height:50)
    Divider()
        .frame(width:370)
    SecureField("Password", text: $LoginVM.password)
        .frame(width:350, height:50)
    Divider()
        .frame(width:370)
    Text("Forgot your password?")
        .foregroundColor(Color(#colorLiteral(red: 0.6196078431, green: 0, blue: 0, alpha: 1)))
        .padding(.vertical)
    
        NavigationLink(destination: ContentView(logout: self.$LoginVM.isActive, uField: $LoginVM.email, pField: $LoginVM.password), isActive: $LoginVM.isActive) {
    Button(action: {
        
        LoginVM.login()
        
        
        
        
    }){
        Text("Log in")
            .font(.title2)
            .foregroundColor(Color.white)
            .background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/)
                            .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                            .frame(width: 350.0, height: 50.0))
    }.alert(isPresented: $LoginVM.showErrorMessage) {
        Alert(title: Text("Error"), message: Text("Please Enter all details correctly!"), dismissButton: .default(Text("OK")))
        
    } }
  
}
    }
    
    
    var userTypePicker: some View {
        VStack{
        Picker(selection: $userTypeIndex, label: Text("What is your favorite color?")) {
            Text("Individual").tag(0)
            Text("Business").tag(1)
            
        }            .frame(width: 350.0)
        .pickerStyle(SegmentedPickerStyle())
    }
    }
    
    var individualForm: some View {
        
        ScrollView {
            Group {
                TextField("First Name", text: $indSignupVM.firstName)
                    .frame(width:350, height:50)
                Divider()
                    .frame(width:370)
                TextField("Last Name", text: $indSignupVM.lastName)
                    .frame(width:350, height:50)
                Divider()
                    .frame(width:370)
                TextField("Email", text: $indSignupVM.email).autocapitalization(.none)                    .frame(width:350, height:50)
                Divider()
                    .frame(width:370)
                SecureField("Password", text: $indSignupVM.password)
                    .frame(width:350, height:50)
                Divider()
                    .frame(width:370)
            }
            DatePicker("Date Of Birth", selection: $indSignupVM.date, displayedComponents: .date)
                .datePickerStyle(WheelDatePickerStyle())
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            TextField("Home Address", text: $indSignupVM.address)
                .frame(width:350, height:50)
            Divider()
                .frame(width:370)
            
            
            Button(action: {
                
                indSignup()
                
                
                
                
            }){
                Text("Sign in")
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                    .frame(width: 350.0, height: 50.0))
            }                        .alert(isPresented: $showErrorMessage) {
                Alert(title: Text("Error"), message: Text("Please Enter all details correctly!"), dismissButton: .default(Text("OK")))
            } .padding()
        }

        
    }
    
    var businessForm: some View {
        ScrollView{
            Group {
                TextField("Business Name", text: $busSignupVM.name)
                    .frame(width:350, height:50)
                Divider()
                    .frame(width:370)
                TextField("ABN", text: $busSignupVM.ABN)
                    .frame(width:350, height:50)
                Divider()
                    .frame(width:370)
                TextField("Business Type", text: $busSignupVM.bType)
                    .frame(width:350, height:50)
                Divider()
                    .frame(width:370)
                TextField("Phone Number", text: $busSignupVM.phoneNum)
                    .frame(width:350, height:50)
                Divider()
                    .frame(width:370)
            }
            TextField("Address", text: $busSignupVM.address)
                .frame(width:350, height:50)
            Divider()
                .frame(width:370)
            
            TextField("Email", text: $busSignupVM.email).autocapitalization(.none)                .frame(width:350, height:50)
            Divider()
                .frame(width:370)
            
            SecureField("Password", text: $busSignupVM.password)
                .frame(width:350, height:50)
            Divider()
                .frame(width:370)
            
            SecureField("Confirm Password", text: $busSignupVM.confirmPassword)
                .frame(width:350, height:50)
            Divider()
                .frame(width:370)
            
            
            Button(action: {
                
                busSignup()
                
                
                
                
            }){
                Text("Sign in")
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                    .frame(width: 350.0, height: 50.0))
            }                        .alert(isPresented: $showErrorMessage) {
                Alert(title: Text("Error"), message: Text("Please Enter all details correctly!"), dismissButton: .default(Text("OK")))
            } .padding()
        }
    }
        
    
    var HealthCentreForm: some View {
        ScrollView{
            Group {
                TextField("Name", text: $busSignupVM.name)
                    .frame(width:350, height:50)
                Divider()
                    .frame(width:370)
                TextField("Address", text: $busSignupVM.ABN)
                    .frame(width:350, height:50)
                Divider()
                    .frame(width:370)
                TextField("PhoneNumber", text: $busSignupVM.bType)
                    .frame(width:350, height:50)
                Divider()
                    .frame(width:370)
                TextField("Email", text: $busSignupVM.phoneNum)
                    .frame(width:350, height:50)
                Divider()
                    .frame(width:370)
            }
            
            SecureField("Password", text: $busSignupVM.password)
                .frame(width:350, height:50)
            Divider()
                .frame(width:370)
            
            SecureField("Confirm Password", text: $busSignupVM.confirmPassword)
                .frame(width:350, height:50)
            Divider()
                .frame(width:370)
            
            
            Button(action: {
                
                busSignup()
                
                
                
                
            }){
                Text("Sign in")
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                    .frame(width: 350.0, height: 50.0))
            }                        .alert(isPresented: $showErrorMessage) {
                Alert(title: Text("Error"), message: Text("Please Enter all details correctly!"), dismissButton: .default(Text("OK")))
            } .padding()
        }
    }
        
        
        func indSignup() {
            
            if !indSignupVM.fieldEmpty(){
                
                indSignupVM.register()
                print(indSignupVM.showErrorMessage)
                index = 0
                
            }else{
                self.showErrorMessage  = true
            }
            
            
        }
        
        func busSignup() {
            
            if !busSignupVM.fieldEmpty(){
                
                busSignupVM.register()
                print(indSignupVM.showErrorMessage)
                index = 0
                
            }else{
                self.showErrorMessage  = true
            }
            
            
        }
    }






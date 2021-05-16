//
//  LoginSignupView.swift
//  COVID-APP
//
//  Created by user188450 on 5/11/21.
//

import SwiftUI

struct LoginSignupView: View {
        @Binding var index:  Int
        @Binding var loading: Bool
        @Binding var loginComplete: Bool
        @Binding var userTypeLogin: Int
        @State var userTypeIndex = 0
        @EnvironmentObject var CurrentUser: User
        @State private var LoginVM = LoginViewModel()
        @State private var indSignupVM = IndividualSignupViewModel()
        @State var busSignupVM = busSignupViewModel()
        @AppStorage("UID") var UID: String = ""
        @State var wrongLoginAlert = false
        @State var showErrorMessage = false
       
        
        //THIS IS NOT DONE
        var body: some View {
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
                
                Spacer()
                    .frame(width:400, height:30)
                
                Picker(selection: $index, label: Text("What is your favorite color?")) {
                    Text("Log in").tag(0)
                    Text("Sign up").tag(1)
                    
                }
                .frame(width: 350)
                .pickerStyle(SegmentedPickerStyle())
                
                Spacer()
                    .frame(width:400, height:30)
                
                if (index == 0)
                {
                    //THIS IS OKAY
                    TextField("Email", text: $LoginVM.email)
                        .frame(width:350, height:50)
                    Divider()
                        .frame(width:370)
                    SecureField("Password", text: $LoginVM.password)
                        .frame(width:350, height:50)
                    Divider()
                        .frame(width:370)
                    Text("Forgot your password?")
                        .foregroundColor(Color(#colorLiteral(red: 0.6196078431, green: 0, blue: 0, alpha: 1)))
                        .padding(.vertical)
                    
                    Button(action: {
                        
                        login()
                        
                        
                        
                        
                    }){
                        Text("Log in")
                            .font(.title2)
                            .foregroundColor(Color.white)
                            .background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/)
                                            .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                            .frame(width: 350.0, height: 50.0))
                    }.alert(isPresented: $showErrorMessage) {
                        Alert(title: Text("Error"), message: Text("Please Enter all details correctly!"), dismissButton: .default(Text("OK")))
                        
                    }
                    
                }
                else
                {
                    Picker(selection: $userTypeIndex, label: Text("What is your favorite color?")) {
                        Text("Individual").tag(0)
                        Text("Business").tag(1)
                        
                    }            .frame(width: 350.0)
                    .pickerStyle(SegmentedPickerStyle())
                    
                    if (userTypeIndex == 0 ){
                        
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
                                TextField("Email", text: $indSignupVM.email)
                                    .frame(width:350, height:50)
                                Divider()
                                    .frame(width:370)
                                TextField("Password", text: $indSignupVM.password)
                                    .frame(width:350, height:50)
                                Divider()
                                    .frame(width:370)
                            }
                            DatePicker(selection: $indSignupVM.date, displayedComponents: .date, label: { Text("Date of Birth") } )
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
                    }else{
                        
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
                            
                            TextField("Email", text: $busSignupVM.email)
                                .frame(width:350, height:50)
                            Divider()
                                .frame(width:370)
                            
                            TextField("Password", text: $busSignupVM.password)
                                .frame(width:350, height:50)
                            Divider()
                                .frame(width:370)
                            
                            TextField("Confirm Password", text: $busSignupVM.confirmPassword)
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
                }
                Spacer()
                
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
        
        func login() {
            
            let formatter = DateFormatter()
            // initially set the format based on your datepicker date / server String
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

            let myString = formatter.string(from: Date()) // string purpose I add here
            // convert your string to date
            let yourDate = formatter.date(from: myString)
            //then again set the date format whhich type of output you need
            formatter.dateFormat = "dd-MMM-yyyy HH:mm:ss"
            // again convert your date to string
            let myStringafd = formatter.string(from: yourDate!)

            print(myStringafd)
            
            
            if !LoginVM.fieldEmpty(){
               LoginVM.login2()
                loading = true
                
                // really need to figure out async firebase request. this adds a 2 second wait so the function above has recieved the firebase call (very hacky)
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                    
                    
                    
                    if LoginVM.loginComplete {
                      if LoginVM.userTypeLogin == 0 {
                        CurrentUser.uid = UID
                        CurrentUser.individualID = LoginVM.CurrentUser.individualID
                            userTypeLogin = 0
                      }else if LoginVM.userTypeLogin == 1{
                        
                        userTypeLogin = 1
                    }
                        CurrentUser.uid = UID
                        
                        self.loginComplete = true
                        loading = false
                    }else{
                        
                        self.showErrorMessage = true
                        loading = false
                        LoginVM.email = ""
                        LoginVM.password = ""
                        
                        
                    }
                }
            }else{
               self.showErrorMessage  = true
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
            
            
            
            
            //  presentationMode.wrappedValue.dismiss()
            
        }
        
        func busSignup() {
            
            if !busSignupVM.fieldEmpty(){
                
                busSignupVM.register()
                print(indSignupVM.showErrorMessage)
                index = 0
                
            }else{
                self.showErrorMessage  = true
            }
            
            
            
            
            //  presentationMode.wrappedValue.dismiss()
            
        }
    }

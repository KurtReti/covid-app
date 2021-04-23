//
//  SwiftUIView.swift
//  COVID-APP
//
//  Created by Connor Jones on 13/4/21.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var signupVM = SignupViewModel()
    //allows state index st be accesible inside this struct so you can toggle back to login
    @Binding var index: Int
    //allows us to change the toggle buttons color from inside the struct
    //seems hacky not sure
    // also means you have to pass the colors in the parameters in the if statement of contentview
    @Binding var buttonBackground1: Color
    @Binding var buttonBackground2: Color
    @State private var showErrorMessage = false
    var accentColor: Color = Color.blue
    var grayBackground: Color = Color.gray.opacity(0.2)
    
    var body: some View {
        
        
        ScrollView {
            
            
            VStack{
                
                DatePicker(
                    "Date of Birth",
                    selection: $signupVM.date,
                    displayedComponents: .date
                    
                ).datePickerStyle(CompactDatePickerStyle())
                
                .padding()
                
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                .accentColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                
                
                HStack {
                TextField("First Name", text: $signupVM.firstName)
                    .overlay(VStack{Divider().offset(x: 0, y: 15)})
                    
                }
                    .padding()
                    
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                TextField("Last Name", text: $signupVM.lastName)
                    .overlay(VStack{Divider().offset(x: 0, y: 15)})
                    .padding()
                    
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                
                
                TextField("Email", text: $signupVM.email)
                    .overlay(VStack{Divider().offset(x: 0, y: 15)})
                    .padding()
                    
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                TextField("Home Postcode", text: $signupVM.postcode)
                    .overlay(VStack{Divider().offset(x: 0, y: 15)})
                    .padding()
                    
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                SecureField("Password", text: $signupVM.password)
                    .overlay(VStack{Divider().offset(x: 0, y: 15)})
                    .padding()
                    
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                SecureField("Confirm Password", text: $signupVM.confirmPassword)
                    .overlay(VStack{Divider().offset(x: 0, y: 15)})
                    .padding()
                    
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                Button(action: {
                    
                    if !signupVM.fieldEmpty(){
                    
                        signupVM.register()
                        print(signupVM.showErrorMessage)
                        index = 0
                        buttonBackground1 = Color.blue
                        buttonBackground2 = Color.gray.opacity(0.2)
                    }else{
                        self.showErrorMessage  = true
                    }
                
                 
                    
                    
                    presentationMode.wrappedValue.dismiss()
                    
                }){
                    Text("Sign Up!")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 320, height: 50)
                        .background(accentColor)
                        .cornerRadius(15.0).padding(.bottom, 20)
                        .alert(isPresented: $showErrorMessage) {
                            Alert(title: Text("Error"), message: Text("Please Enter all details correctly!"), dismissButton: .default(Text("OK")))
                        }
                }
                
                .padding()
                
            } }
            .frame(height: 350)
            .padding(.top)
       
        
    }
    
    
    
    
    
}




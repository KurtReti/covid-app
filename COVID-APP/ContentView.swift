//
//  ContentView.swift
//  COVID-APP
//
//  Created by Taylah Galea on 25/3/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // Loading Screen Design
        VStack {
            VStack {
                Text("COVID SAFETY")
                    .font(.system(size:45))
                    .fontWeight(.heavy)
                    .foregroundColor(Color(#colorLiteral(red: 0.6196078431, green: 0, blue: 0, alpha: 1)))
                Image("Virus").resizable().frame(width: 270, height: 270)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct LoginOptionsView: View {
    var body: some View {
        // Log in Options Screen Design
        VStack {
            Spacer()
                .frame(width: 350.0, height: 100)
            
            Text("COVID SAFETY")
                .font(.system(size:45))
                .fontWeight(.heavy)
                .foregroundColor(Color(#colorLiteral(red: 0.6196078431, green: 0, blue: 0, alpha: 1)))
            Image("Virus").resizable().frame(width: 270, height: 270)
            
            Spacer()
                .frame(width: 350.0, height: 200)
            
            // LOG IN BUTTON
            // wrap with navigation link to activate
            Text("Log in")
                .font(.title2)
                .foregroundColor(Color.white)
                .background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/)
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                .frame(width: 350.0, height: 50.0))
            Spacer()
                .frame(width: 350.0, height: 50)
           
            // SIGN UP BUTTON
            // wrap with navigation link to activate
            Text("Sign Up")
                .font(.title2)
                .foregroundColor(Color.white)
                .background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/)
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                .frame(width: 350.0, height: 50.0))
        }

    }
}

struct LoginOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        LoginOptionsView()
    }
}

struct LoginSignupView: View {
    @State private var option = 1
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
            
            Picker(selection: $option, label: Text("What is your favorite color?")) {
                           Text("Log in").tag(0)
                           Text("Sign up").tag(1)
                        
            }
                        .frame(width: 350)
                       .pickerStyle(SegmentedPickerStyle())
            
            Spacer()
                .frame(width:400, height:30)
            
            if (option == 0)
            {
                //THIS IS OKAY
                TextField("Email", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .frame(width:350, height:50)
                Divider()
                    .frame(width:370)
                SecureField("Password", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("Apple")/*@END_MENU_TOKEN@*/)
                    .frame(width:350, height:50)
                Divider()
                    .frame(width:370)
                Text("Forgot your password?")
                    .foregroundColor(Color(#colorLiteral(red: 0.6196078431, green: 0, blue: 0, alpha: 1)))
                    .padding(.vertical)
                
                Text("Log in")
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                    .frame(width: 350.0, height: 50.0))
                
            }
            else
            {
                TextField("First Name", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .frame(width:350, height:50)
                Divider()
                    .frame(width:370)
                TextField("Last Name", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .frame(width:350, height:50)
                Divider()
                    .frame(width:370)
                TextField("Email", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .frame(width:350, height:50)
                Divider()
                    .frame(width:370)
                DatePicker(selection: /*@START_MENU_TOKEN@*/.constant(Date())/*@END_MENU_TOKEN@*/, displayedComponents: .date, label: { Text("Date of Birth") } )
                    .datePickerStyle(WheelDatePickerStyle())
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                TextField("Home Postcode", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .frame(width:350, height:50)
                Divider()
                    .frame(width:370)
            }
            Spacer()
        
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct LoginSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        LoginSignupView()
    }
}

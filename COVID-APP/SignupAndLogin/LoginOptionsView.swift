//
//  LoginOptionsView.swift
//  COVID-APP
//
//  Created by user188450 on 5/11/21.
//

import SwiftUI

struct LoginOptionsView: View {
    @Binding var index: Int
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
            Button(action: {
                
                self.index = 0
                
                
                
                
            }){
                Text("Log in")
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                    .frame(width: 350.0, height: 50.0))
            }
            Spacer()
                .frame(width: 350.0, height: 50)
            
            
            // SIGN UP BUTTON
            // wrap with navigation link to activate
            Button(action: {
                
                self.index = 1
                
                
                
                
            }){
                Text("Sign Up")
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                    .frame(width: 350.0, height: 50.0))
                
            }
        }
        
    }
}




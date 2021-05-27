//
//  BusinessHomeView.swift
//  COVID-APP
//
//  Created by user188450 on 5/10/21.
//

import SwiftUI

struct BusinessHomeView: View {
    
   // @EnvironmentObject var CurrentUser: User
    @Binding var logout: Bool
    var body: some View {
       
        // template from indvidual view. make to fit business home screen

            VStack {
//                Text(CurrentUser.uid)
                
                Group{
                    HStack{
                        Image("Virus")
                            .resizable()
                            .frame(width: 80, height: 80)
                        VStack(alignment: .leading){
                            Text("COVID")
                                .font(.system(size:25))
                                .fontWeight(.heavy)
                                .foregroundColor(Color(#colorLiteral(red: 0.6196078431, green: 0, blue: 0, alpha: 1)))
                            Text("SAFETY")
                                .font(.system(size:25))
                                .fontWeight(.heavy)
                                .foregroundColor(Color(#colorLiteral(red: 0.6196078431, green: 0, blue: 0, alpha: 1)))
                        }
                        Spacer()
                            .frame(width: 100)
                        
                         //SETTINGS BUTTON
                        NavigationLink(destination: SettingsView(logout: self.$logout)){
                            Image(systemName: "gearshape.fill")
                                .font(.system(size:50))
                               .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                        }
                    }
                    
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/)
                        .frame(width: 300, height: 1)
                        .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                    Spacer()
                        .frame(height: 20)
                    Text("Welcome! \nYour safety is our priority.")
                        .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                        .frame(width: 350, alignment: .topLeading)
                    Spacer()
                        .frame(height: 10)
                }
                    

                
                // COVID SIGN BUTTON
                Group{
                   ZStack{
                    // only wrap rectangle - otherwise formatting issue
                    NavigationLink(destination: CovidSignListView()){
                       RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/)
                           .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                           .frame(width: 350.0, height: 50.0)
                    }
                       HStack {
                           Image(systemName: "person.2.fill")
                               .font(.system(size: 24))
                               .foregroundColor(.white)
                           Text("COVID Signs")
                               .font(.body)
                               .fontWeight(.semibold)
                               .foregroundColor(.white)
                       }
                       .frame(width: 320, alignment: .topLeading)
                   }
                   Spacer()
                       .frame(height: 30)
                }
                    
                // RESTRICTIONS BUTTON
                Group{
                   ZStack{
                    // only wrap rectangle - otherwise formatting issue
                    NavigationLink(destination: RestrictionsView()){
                       RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/)
                           .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                           .frame(width: 350.0, height: 50.0)
                    }
                       HStack {
                           Image(systemName: "exclamationmark.triangle.fill")
                               .font(.system(size: 34))
                               .foregroundColor(.white)
                           Text("Restrictions")
                               .font(.body)
                               .fontWeight(.semibold)
                               .foregroundColor(.white)
                       }
                       .frame(width: 320, alignment: .topLeading)
                   }
                }
                Spacer()
                    
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
            
            
}



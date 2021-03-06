//
//  HealthOfficialView.swift
//  COVID-APP
//
//  Created by Connor Jones on 17/5/21.
//

import SwiftUI

struct HealthOfficialView: View {
    @Binding var logout: Bool
    var body: some View {
       
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
                        
                        // SETTINGS BUTTON
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
                    
                // CHECK-IN BUTTON
                Group{
                    ZStack{
                        // only wrap rectangle - otherwise formatting issue
                        NavigationLink(destination: ReportTestView()){
                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/)
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                .frame(width: 350.0, height: 50.0)
                        }
                        HStack {
                            Image(systemName: "stethoscope")
                                .font(.system(size: 34))
                                .foregroundColor(.white)
                            Text("Covid Test")
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                        .frame(width: 320, alignment: .topLeading)
                        
                    }
                    Spacer()
                        .frame(width: 350.0, height: 30)
                }

                // VACCINES BUTTON
                Group{
                    ZStack{
                        // only wrap rectangle - otherwise formatting issue
                        NavigationLink(destination: VaccineIndividualSearchView()){
                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/)
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                .frame(width: 350.0, height: 50.0)
                        }
                        HStack {
                            Image("Vaccine")
                                .resizable()
                                .frame(width:34, height: 34)
                            Text("Vaccinate")
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                        .frame(width: 320, alignment: .topLeading)
                    }
                    Spacer()
                        .frame(width: 350.0, height: 30)
                }
                    
                // ALERTS BUTTON
                Group{
                   ZStack{
                    // only wrap rectangle - otherwise formatting issue
                    NavigationLink(destination: VaccineSupplyView()){
                       RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/)
                           .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                           .frame(width: 350.0, height: 50.0)
                    }
                       HStack {
                           Image(systemName: "exclamationmark.circle")
                               .font(.system(size: 34))
                               .foregroundColor(.white)
                           Text("Vaccine Supply")
                               .font(.body)
                               .fontWeight(.semibold)
                               .foregroundColor(.white)
                       }
                       .frame(width: 320, alignment: .topLeading)
                   }
                   Spacer()
                       .frame(height: 30)
                }

                //Reports Button
                Group{
                   ZStack{
                    // only wrap rectangle - otherwise formatting issue
                    NavigationLink(destination: ClusterMapView()){
                       RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/)
                           .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                           .frame(width: 350.0, height: 50.0)
                    }
                       HStack {
                           Image(systemName: "person.2.fill")
                               .font(.system(size: 24))
                               .foregroundColor(.white)
                           Text("Reports")
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
                    
           /* NavigationView {
                       VStack {
                           NavigationLink(destination: SecondView()) {
                               Text("Show Detail View")
                           }
                           
                       }
            } */
                
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        
    }
        
}





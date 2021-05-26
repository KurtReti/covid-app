//
//  HomeView.swift
//  COVID-APP
//
//  Created by user188450 on 4/29/21.
//


//Contains home view and other views accessed from homeview
// feel free to move other view into seperate files

import SwiftUI
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift



struct HomeView: View {
    
    @EnvironmentObject var CurrentUser: User

    var body: some View {
        NavigationView {
            VStack {
                Text(CurrentUser.uid)
                
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
                        NavigationLink(destination: SettingsView()){
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
                        NavigationLink(destination: CheckinView()){
                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/)
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                .frame(width: 350.0, height: 50.0)
                        }
                        HStack {
                            Image(systemName: "qrcode.viewfinder")
                                .font(.system(size: 34))
                                .foregroundColor(.white)
                            Text("Check-ins")
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
                        NavigationLink(destination: VaccinesView()){
                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/)
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                .frame(width: 350.0, height: 50.0)
                        }
                        HStack {
                            Image("Vaccine")
                                .resizable()
                                .frame(width:34, height: 34)
                            Text("Vaccines")
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
                    NavigationLink(destination: AlertsView()){
                       RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/)
                           .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                           .frame(width: 350.0, height: 50.0)
                    }
                       HStack {
                           Image(systemName: "exclamationmark.circle")
                               .font(.system(size: 34))
                               .foregroundColor(.white)
                           Text("Alerts")
                               .font(.body)
                               .fontWeight(.semibold)
                               .foregroundColor(.white)
                       }
                       .frame(width: 320, alignment: .topLeading)
                   }
                   Spacer()
                       .frame(height: 30)
                }
                
                // DEPENDENTS BUTTON
                Group{
                   ZStack{
                    // only wrap rectangle - otherwise formatting issue
                    NavigationLink(destination: DependentView()){
                       RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/)
                           .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                           .frame(width: 350.0, height: 50.0)
                    }
                       HStack {
                           Image(systemName: "person.2.fill")
                               .font(.system(size: 24))
                               .foregroundColor(.white)
                           Text("Dependents")
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
            .environmentObject(CurrentUser)
    }
            
}

struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(User())
    }
}

struct CheckinView: View {
    @EnvironmentObject var CurrentUser: User
    var body: some View {
        VStack{
            Text(CurrentUser.uid)
            
        }
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
        NavigationView {
            VStack{
                List {
                    Link("ACT", destination: URL(string:"https://www.covid19.act.gov.au/")!)
                        
                    Link("NSW", destination: URL(string:"https://www.nsw.gov.au/covid-19")!)
                    
                    Link("NT", destination: URL(string:"https://coronavirus.nt.gov.au/")!)
                    
                    Link("QLD", destination: URL(string:"https://www.qld.gov.au/health/conditions/health-alerts/coronavirus-covid-19")!)
                    
                    Link("SA", destination: URL(string:"https://www.covid-19.sa.gov.au/")!)
                    
                    Link("TAS", destination: URL(string:"https://coronavirus.tas.gov.au/")!)
                    
                    Link("VIC", destination: URL(string:"https://www.coronavirus.vic.gov.au/")!)
                    
                    Link("WA", destination: URL(string:"https://www.wa.gov.au/government/covid-19-coronavirus")!)
                }
                Spacer()
            }
            .navigationTitle("Restrictions")
            .navigationBarItems(trailing: Image(systemName: "exclamationmark.triangle.fill")
                                    .font(.system(size: 34))
                                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))))
        }
        .accentColor(Color(#colorLiteral(red: 0.6196078431, green: 0, blue: 0, alpha: 1)))
    }
}

struct RestrictionsView_Preview: PreviewProvider {
    static var previews: some View {
        RestrictionsView()
    }
}

struct SettingsView: View {
    
    
    @AppStorage("log_Status") var status = false
    
    var body: some View {
       
        VStack(alignment: .trailing) { }
    
            }

           

    
         
         
     }

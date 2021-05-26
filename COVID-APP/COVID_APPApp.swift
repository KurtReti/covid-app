//
//  COVID_APPApp.swift
//  COVID-APP
//
//  Created by Taylah Galea on 25/3/21.
//

import SwiftUI
import Firebase

@main
struct COVID_APPApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            //this runs from login
            //ContentView()
            LoginSignupView(index: 0)
            //this is for checkin testing
            //FakeHomeForCheckInTest()
            //HomeView()
            //HealthOfficialView()
            //HealthOfficialView()
           //HomeTestView()
            //CovidSignListView()
        }
    }
    
    class AppDelegate: NSObject, UIApplicationDelegate {
      func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
      }
    }
}


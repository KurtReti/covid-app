//
//  COVID_APPApp.swift
//  COVID-APP
//
//  Created by Taylah Galea on 25/3/21.
//

import SwiftUI
import Firebase
import GoogleMaps

@main
struct COVID_APPApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            CovidSignListView()
            //DependentView()
            //ContentView()
        }
    }
    
    class AppDelegate: NSObject, UIApplicationDelegate {
      func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        GMSServices.provideAPIKey("")
        FirebaseApp.configure()
        return true
      }
    }
}


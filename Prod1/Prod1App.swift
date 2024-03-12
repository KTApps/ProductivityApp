//
//  Prod1App.swift
//  Prod1
//
//  Created by Tanaka Bere on 10/02/2024.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct Prod1App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let object = Objects()
    @StateObject var authModel = AuthModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            StartView()
                .environmentObject(object)
                .environmentObject(authModel)
        }
    }
}

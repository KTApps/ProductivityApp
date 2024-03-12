//
//  Prod1App.swift
//  Prod1
//
//  Created by Tanaka Bere on 10/02/2024.
//

import SwiftUI
import Modals
import Firebase

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
    
    var body: some Scene {
        WindowGroup {
            ModalStackView {
                ContentView()
                    .environmentObject(object)
            }
        }
    }
}

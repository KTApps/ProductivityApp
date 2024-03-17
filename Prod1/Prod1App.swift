//
//  Prod1App.swift
//  Prod1
//
//  Created by Tanaka Bere on 10/02/2024.
//

import SwiftUI
import Firebase

@main
struct Prod1App: App {
    @StateObject var object = Objects()
    @StateObject var authModel = AuthViewModel()
    
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

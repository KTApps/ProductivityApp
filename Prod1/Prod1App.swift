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

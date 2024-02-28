//
//  Prod1App.swift
//  Prod1
//
//  Created by Tanaka Bere on 10/02/2024.
//

import SwiftUI
import Modals

@main
struct Prod1App: App {
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

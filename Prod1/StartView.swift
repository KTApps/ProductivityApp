//
//  StartView.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 12/03/2024.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var authModel: AuthModel
    var body: some View {
        Group {
            if authModel.userSession != nil {
                ContentView()
            } else {
                LogInView()
            }
        }
    }
}

#Preview {
    StartView()
}

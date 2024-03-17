//
//  SettingsView.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 12/03/2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        if let user = authViewModel.currentUser {
            List {
                Section {
                    HStack {
                        Text(user.initials)
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .frame(width: 70, height: 70)
                            .background(Color.gray)
                            .clipShape(Circle())
                        VStack(alignment: .leading) {
                            Text(user.fullname)
                            Text(user.email)
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                Section("Account") {
                    Button {
                        authViewModel.signOut()
                    } label: {
                        SettingsButton(image: "arrow.left.circle.fill", action: "Sign Out")
                    }
                    
                    Button {
                        authViewModel.deleteAccount()
                    } label: {
                        SettingsButton(image: "x.circle.fill", action: "Delete Account")
                    }
                }
                .foregroundColor(.black)
            }
        } 
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

//
//  SettingsView.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 12/03/2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authModel: AuthModel
    
    var body: some View {
        List {
            Section {
                HStack {
                    Text(UserObject.mockUser.initials)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .frame(width: 70, height: 70)
                        .background(Color.gray)
                        .clipShape(Circle())
                    VStack(alignment: .leading) {
                        Text(UserObject.mockUser.fullname)
                        Text(UserObject.mockUser.email)
                            .foregroundColor(.gray)
                    }
                }
            }
            
            Section("Account") {
                Button {
                    authModel.signOut()
                } label: {
                    SettingsModel(image: "arrow.left.circle.fill",
                                  action: "Sign Out")
                }
                
                Button {
                    authModel.deleteAccount()
                } label: {
                    SettingsModel(image: "x.circle.fill",
                                  action: "Delete Account")
                }
            }
            .foregroundColor(.black)
        }
    }
}

#Preview {
    SettingsView()
}
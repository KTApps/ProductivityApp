//
//  SignUpView.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 11/03/2024.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authModel: AuthViewModel
    
    @State private var forename = ""
    @State private var sureName = ""
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Spacer()
                    .frame(height: 60)
                
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                
                Spacer()
                    .frame(height: 20)
                
                Input(text: $forename, title: "name", placeHolder: "name")
                .foregroundColor(.white)
                
                Spacer()
                    .frame(height: 20)
                
                Input(text: $sureName, title: "Surename", placeHolder: "name")
                .foregroundColor(.white)
                
                Spacer()
                    .frame(height: 20)
                
                Input(text: $email, title: "Email Address", placeHolder: "name@example.com")
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                
                Spacer()
                    .frame(height: 20)
                
                ZStack(alignment: .trailing) {
                    Input(text: $password,
                                title: "Password",
                                placeHolder: "********",
                                secureField: true)
                    .foregroundColor(.white)
                    
                    if !password.isEmpty {
                        if password.count < 6 {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.title3)
                                .foregroundColor(.red)
                        } else {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.title3)
                                .foregroundColor(.green)
                        }
                    }
                }
                
                Spacer()
                    .frame(height: 30)
                
                Button {
                    Task {
                        try await authModel.signUp(withEmail: email,
                                                   password: password,
                                                   fullname: "\(forename) \(sureName)")
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 350, height: 40)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Text("SIGN UP")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
                .disabled(!isFormValid)
                .opacity(isFormValid ? 1 : 0.5)
                
                Spacer()
                
                NavigationLink {
                    LogInView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack {
                        Text("Already have an account?")
                        Text("LOG IN")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .foregroundColor(.white)
                }
            }
            .padding(.horizontal, 10)
        }
    }
}

extension SignUpView: AuthFormValidation {
    var isFormValid: Bool {
        return !forename.isEmpty
        && !sureName.isEmpty
        && !email.isEmpty
        && email.contains("@")
        && password.count > 5
    }
}

#Preview {
    SignUpView()
}

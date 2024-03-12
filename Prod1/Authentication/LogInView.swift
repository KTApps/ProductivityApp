//
//  SignInView.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 11/03/2024.
//

import SwiftUI

struct LogInView: View {
    @EnvironmentObject var authModel: AuthModel
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView {
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
                        .frame(height: 60)
                    
                    SignUpInput(text: $email,
                                title: "Email Address",
                                placeholder: "name@example.com")
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    SignUpInput(text: $password,
                                title: "Password",
                                placeholder: "********",
                                secureField: true)
                    .foregroundColor(.white)
                    
                    Spacer()
                        .frame(height: 30)
                    
                    Button {
                        Task {
                            try await authModel.logIn(withEmail: email, 
                                                      password: password)
                        }
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 350, height: 40)
                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            Text("LOG IN")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                    }
                    
                    Spacer()
                    
                    NavigationLink {
                        SignUpView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack {
                            Text("You don't have an account?")
                            Text("SIGN UP")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }
                        .foregroundColor(.white)
                    }
                }
                .padding(.horizontal, 10)
            }
        }
    }
}

#Preview {
    LogInView()
}
//
//  SignUpView.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 11/03/2024.
//

import SwiftUI

struct SignUpView: View {
    
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
                    .frame(height: 60)
                
                SignUpInput(text: $email,
                            title: "Email Address",
                            placeholder: "name@example.com")
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                
                Spacer()
                    .frame(height: 20)
                
                SignUpInput(text: $email,
                            title: "Password",
                            placeholder: "********",
                            secureField: true)
                .foregroundColor(.white)
                
                Spacer()
                    .frame(height: 30)
                
                Button {
                    
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
                
                Spacer()
            }
            .padding(.horizontal, 10)
        }
    }
}

#Preview {
    SignUpView()
}

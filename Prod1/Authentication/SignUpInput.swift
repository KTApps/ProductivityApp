//
//  SignUpInput.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 11/03/2024.
//

import SwiftUI

struct SignUpInput: View {
    
    @Binding var text: String
    let title: String
    let placeholder: String
    var secureField = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            if secureField {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
        }
    }
}

#Preview {
    SignUpInput(text: .constant(""), title: "Email Address", placeholder: "name@example.com")
}

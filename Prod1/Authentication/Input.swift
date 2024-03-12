//
//  Input.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 11/03/2024.
//

import SwiftUI

struct Input: View {
    @Binding var text: String
    let title: String
    let placeHolder: String
    var secureField = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            
            if secureField {
                SecureField(placeHolder, text: $text)
            } else {
                TextField(placeHolder, text: $text)
            }
        }
    }
}

#Preview {
    Input(text: .constant(""), title: "Email Address", placeHolder: "name@example.com")
}

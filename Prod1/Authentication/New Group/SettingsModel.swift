//
//  SettingsModel.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 12/03/2024.
//

import SwiftUI

struct SettingsModel: View {
    let image: String
    let action: String
    
    var body: some View {
        HStack {
            Image(systemName: image)
                .font(.title)
                .foregroundColor(.red)
            Text(action)
                .font(.title3)
        }
    }
}

#Preview {
    SettingsModel(image: "arrow.left.circle.fill", action: "Sign Out")
}

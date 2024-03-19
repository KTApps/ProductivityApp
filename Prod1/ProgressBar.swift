//
//  ProgressBar.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 19/03/2024.
//

import SwiftUI

//struct ProgressBar: View {
//    var body: some View {
//        CustomProgressBar()
//    }
//}

struct CustomProgressBar: View {
    let maxTime: CGFloat = 360
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            ZStack(alignment: .trailing) {
                Capsule()
                    .fill(Color.gray)
                    .frame(width: maxTime, height: 40)
                
                Text("50%")
                    .padding()
            }
            
            Capsule()
                .fill(Color.blue)
                .frame(width: (maxTime * 0.5), height: 40)
        }
        .padding()
    }
}

#Preview {
    CustomProgressBar()
}

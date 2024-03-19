//
//  ProgressView.swift
//  Prod1
//
//  Created by Tanaka Bere on 11/02/2024.
//

import SwiftUI
import Charts
 
struct ViewYourProgress: View {
    @State private var count: Int = 7
    
    var body: some View {
        ZStack{
            Color.gray.ignoresSafeArea()
            VStack {
                Text("Progress")
                    .font(.largeTitle)
                    .fontWeight(.semibold)

                Spacer()
                    .frame(height: 0)
                
                CalendarView()
                
                Spacer()
            }
            .padding(.vertical, 30)
        }
    }
}

/*
extension Color {
    static let darkGray = Color(red: 0.333, green: 0.333, blue: 0.333)
}
*/

struct ViewYourProgress_Previews: PreviewProvider {
    static var previews: some View {
        ViewYourProgress()
    }
}

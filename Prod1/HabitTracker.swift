//
//  HabitTracker.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 16/02/2024.
//

import SwiftUI

struct HabitTracker: View {
    var body: some View {
        VStack {
            Text("Monday")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
            
            VStack {
                Text("5AM Wake")
                Text("Cold Shower")
                Text("Morning Sun")
                Text("Make Bed")
                Text("50 Press Ups")
                Text("Walk")
            }
            .font(.title)
            .fontWeight(.bold)
            
            Spacer()
            
            Button(action: {
                
            }) {
                Text("Add Habit")
                    .font(.title3)
                    .fontWeight(.bold)
            }
        }
        .padding(.vertical, 80)
    }
}

#Preview {
    HabitTracker()
}

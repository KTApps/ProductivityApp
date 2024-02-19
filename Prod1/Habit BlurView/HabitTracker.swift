//
//  HabitTracker.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 16/02/2024.
//

import SwiftUI

struct HabitTracker: View {
    
    private var WeekDay = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    @State var WeekDayIndexCounter = 0
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    if WeekDayIndexCounter != 0 {
                        WeekDayIndexCounter -= 1
                    } else {
                        WeekDayIndexCounter = 6
                    }
                    print(WeekDayIndexCounter)
                }) {
                    Image(systemName: "chevron.left")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                Text(WeekDay[WeekDayIndexCounter])
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                    if WeekDayIndexCounter != 6 {
                        WeekDayIndexCounter += 1
                    } else {
                        WeekDayIndexCounter = 0
                    }
                    print(WeekDayIndexCounter)
                }) {
                    Image(systemName: "chevron.right")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
            }
            .padding(.horizontal, 40)
            
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

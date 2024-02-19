//
//  HabitTracker.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 16/02/2024.
//

import SwiftUI

struct HabitTracker: View {
    
    private var WeekDay = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    @State private var WeekDayIndexCounter = 0
    
    @State private var IsAddHabitVisible = false
    
    @State private var habitArray: [String] = []

    @State private var selectedHabit: String?
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
                        .shadow(radius: 3, x: 3, y: 3)
                }
                
                Spacer()
                
                Text(WeekDay[WeekDayIndexCounter])
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .shadow(radius: 3, x: 3, y: 3)
                
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
                        .shadow(radius: 3, x: 3, y: 3)
                }
            }
            .padding(.horizontal, 40)
            
            Spacer()
                .frame(height: 70)
            
            ForEach(habitArray, id: \.self) { habit in
                VStack {
                    Button(action: {
                        selectedHabit = habit
                    }) {
                        Text(habit)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .shadow(radius: 3, x: 3, y: 3)
                    }
                    Spacer()
                        .frame(height: 2)
                }
            }
            
            Spacer()
            
            Button(action: {
                IsAddHabitVisible.toggle()
            }) {
                Text("Add Habit")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(15)
                    .foregroundColor(.white)
                    .background(Color.accentColor)
                    .cornerRadius(25)
                    .shadow(radius: 3, x: 3, y: 3)
            }
            .popover(isPresented: $IsAddHabitVisible, arrowEdge: .top, content: {
                ZStack {
                    BlurEffect(style: .light)
                    HabitAdder(habitArray: $habitArray)
                }
                .ignoresSafeArea()
            })
        }
        .padding(.vertical, 80)
        .onChange(of: selectedHabit) { habitToRemove in
            if let habitToRemove = habitToRemove {
                habitArray.removeAll { $0 == habitToRemove }
            }
        }
    }
}

#Preview {
    HabitTracker()
}

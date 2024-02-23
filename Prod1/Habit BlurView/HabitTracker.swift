//
//  HabitTracker.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 16/02/2024.
//

import SwiftUI

struct HabitTracker: View {
    @EnvironmentObject var objects: Objects
    
    private var WeekDay = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    @State private var WeekDayIndexCounter = 0
    
    @State private var IsAddHabitVisible = false
    
    @State private var habitArray: [String] = []
    @State private var habitDict: [String: String] = [:]
            
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 100)
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
                    .font(.title)
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
                .frame(height: 80)
            
            ForEach(habitArray, id: \.self) { habit in
                VStack {
                    Text(habit)
                        .font(.title)
                        .fontWeight(.bold)
                        .shadow(radius: 3, x: 3, y: 3)
                    Text(habitDict[habit] ?? "10:00")
                        .font(.body)
                }
                .offset(objects.habitPositions[habit] ?? .zero)
                .overlay(
                    objects.isHabitStriked[habit] ?? false ?
                        Rectangle()
                            .frame(height: 4)
                            .foregroundColor(.black)
                            .offset(x: objects.habitPositions[habit]?.width ?? 0, y: -6)
                        : nil
                )
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            let movement = CGSize(width: value.translation.width, height: 0)
                            objects.habitPositions[habit] = movement
                            if let position = objects.habitPositions[habit], position.width < -90 || position.width > 90 {
                                objects.isHabitStriked[habit] = true
                            } else {
                                objects.isHabitStriked[habit] = false
                            }
                        })
                        .onEnded({ value in
                            if let position = objects.habitPositions[habit], position.width < -90 || position.width > 90 {
                                objects.selectedHabit = habit
                                objects.habitPositions[habit] = .zero
                            } else {
                                objects.habitPositions[habit] = .zero
                            }
                        })
                )
                Spacer()
                    .frame(height: 15)
            }
            
            Spacer()
            
            HStack {
                Button(action: {
                    IsAddHabitVisible = true
                }) {
                    Text("Add Habit")
                        .font(.title3)
                        .fontWeight(.bold)
                }
                .sheet(isPresented: $IsAddHabitVisible) {
                    ZStack {
                        BlurEffect(style: .light)
                        HabitAdder(habitArray: $habitArray, habitDict: $habitDict)
                            .presentationDetents([.height(300)])
                    }
                }
            }
            Spacer()
                .frame(height: 30)
        }
        .padding(.vertical, 10)
        .onChange(of: objects.selectedHabit) { habitToRemove in
            if let habitToRemove = habitToRemove {
                habitArray.removeAll { $0 == habitToRemove }
            }
        }
    }
}

#Preview {
    HabitTracker()
        .foregroundColor(.black)
        .environmentObject(Objects())
}

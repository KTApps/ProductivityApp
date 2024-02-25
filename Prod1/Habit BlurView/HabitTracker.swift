//
//  HabitTracker.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 16/02/2024.
//

import SwiftUI

struct HabitTracker: View {
    @EnvironmentObject var objects: Objects
    
    @State private var IsAddHabitVisible = false
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 100)
            
//            MARK: WEEKDAY HStack
            HStack {
                
//                MARK: LEFT CHEVRON
                Button(action: {
                    if objects.WeekDayIndexCounter != 0 {
                        objects.WeekDayIndexCounter -= 1
                    } else {
                        objects.WeekDayIndexCounter = 6
                    }
                    print(objects.WeekDayIndexCounter)
                }) {
                    Image(systemName: "chevron.left")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .shadow(radius: 3, x: 3, y: 3)
                }
                
                Spacer()
                
//                MARK: WEEKDAY ARRAY
                Text(objects.WeekDay[objects.WeekDayIndexCounter])
                    .font(.title)
                    .fontWeight(.bold)
                    .shadow(radius: 3, x: 3, y: 3)
                
                Spacer()
                
//                MARK: RIGHT CHEVRON
                Button(action: {
                    if objects.WeekDayIndexCounter != 6 {
                        objects.WeekDayIndexCounter += 1
                    } else {
                        objects.WeekDayIndexCounter = 0
                    }
                    print(objects.WeekDayIndexCounter)
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
            
//            MARK: HABIT ARRAY
            ForEach(objects.WeekDayHabits[objects.WeekDay[objects.WeekDayIndexCounter]] ?? [], id: \.self) { habit in
                VStack {
                    Text(objects.habitIdDict[habit] ?? "")
                        .font(.title)
                        .fontWeight(.bold)
                        .shadow(radius: 3, x: 3, y: 3)
                    Text(objects.habitDict[habit] ?? "")
                        .font(.body)
                }
                .offset(objects.habitPositions[habit] ?? .zero)
                .overlay(
                    objects.isHabitStriked[habit] ?? false ?
                        Rectangle()
                            .frame(height: 4)
                            .foregroundColor(.black)
                            .offset(x: objects.habitPositions[habit]?.width ?? 0, y: -7)
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
            
//            MARK: ADD HABIT Button
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
                        HabitAdder()
                            .presentationDetents([.height(300)])
                    }
                }
            }
            
            Spacer()
                .frame(height: 30)
        }
        .padding(.vertical, 10)
        
//        MARK: REMOVE HABIT CODE
        .onChange(of: objects.selectedHabit) { habitToRemove in
            if let habitToRemove = habitToRemove {
                objects.habitIdArray.removeAll { $0 == habitToRemove }
            }
        }
    }
}

#Preview {
    HabitTracker()
        .foregroundColor(.black)
        .environmentObject(Objects())
}

//
//  HabitTracker.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 16/02/2024.
//

import SwiftUI

struct HabitTracker: View {
    @EnvironmentObject var object: Objects
        
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 120)
            
//            MARK: WEEKDAY HStack
            HStack {
                
//                MARK: LEFT CHEVRON
                Button(action: {
                    if object.WeekDayIndexCounter != 0 {
                        object.WeekDayIndexCounter -= 1
                    } else {
                        object.WeekDayIndexCounter = 6
                    }
                    print(object.WeekDayIndexCounter)
                }) {
                    Image(systemName: "chevron.left")
                        .shadow(radius: 3, x: 3, y: 3)
                }
                .padding(20)
                
                Spacer()
                
//                MARK: WEEKDAY ARRAY
                Text(object.WeekDay[object.WeekDayIndexCounter])
                    .shadow(radius: 3, x: 3, y: 3)
                    .fontWeight(.heavy)
                
                Spacer()
                
//                MARK: RIGHT CHEVRON
                Button(action: {
                    if object.WeekDayIndexCounter != 6 {
                        object.WeekDayIndexCounter += 1
                    } else {
                        object.WeekDayIndexCounter = 0
                    }
                    print(object.WeekDayIndexCounter)
                }) {
                    Image(systemName: "chevron.right")
                        .shadow(radius: 3, x: 3, y: 3)
                }
                .padding(20)
            }
            .font(.custom("Big title", size: 35))
            .fontWeight(.black)
            .padding(.horizontal, 20)
            Spacer()
                .frame(height: 80)
            
//            MARK: HABIT ARRAY
            ForEach(object.habitIdArray, id: \.self) { habit in
                VStack {
                    HStack {
                        Image(systemName: object.habitTickBoxDict[habit] ?? false ? "checkmark.square.fill" : "square")
                            .font(.custom("Big Header", size: 20))
                        
                        Spacer()
                            .frame(width: 105)
                        
                        Text(object.habitIdDict[habit] ?? "")
                            .font(.custom("Big Header", size: 30))
                            .overlay(
                                object.isHabitStriked[habit] ?? false ?
                                    Rectangle()
                                        .frame(height: 4)
                                        .colorInvert()
                                        .padding(.horizontal, -10)
                                    : nil
                            )
                        
                        Spacer()
                        
                        Text(object.habitDict[habit] ?? "")
                            .font(.custom("Big Header", size: 20))
                    }
                    .fontWeight(.black)
                    .shadow(radius: 3, x: 3, y: 3)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 1)
                    .onTapGesture {
                        object.habitTickBoxDict[habit]?.toggle()
                    }
                    .gesture(
                        LongPressGesture(minimumDuration: 1.5)
                            .onChanged { _ in
                                object.isHabitStriked[habit] = true
                            }
                            .onEnded { _ in
                                object.isHabitStriked[habit] = false
                                object.selectedHabit = habit
                            }
                    )
                }
            }
            
            Spacer()
            
//            MARK: ADD HABIT Button
            HStack {
                Button(action: {
                    object.IsAddHabitVisible = true
                }) {
                    Text("Add Habit")
                        .font(.title)
                        .fontWeight(.bold)
                }
                .padding(20)
                .sheet(isPresented: $object.IsAddHabitVisible) {
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
        .onChange(of: object.selectedHabit) { habitToRemove in
            if let habitToRemove = habitToRemove {
                object.habitIdArray.removeAll { $0 == habitToRemove }
            }
        }
    }
}

#Preview {
    HabitTracker()
        .foregroundColor(.black)
        .environmentObject(Objects())
}

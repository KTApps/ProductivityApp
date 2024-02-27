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
                .frame(height: 120)
            
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
                        .shadow(radius: 3, x: 3, y: 3)
                }
                .padding(20)
                
                Spacer()
                
//                MARK: WEEKDAY ARRAY
                Text(objects.WeekDay[objects.WeekDayIndexCounter])
                    .shadow(radius: 3, x: 3, y: 3)
                    .fontWeight(.heavy)
                
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
                        .shadow(radius: 3, x: 3, y: 3)
                }
                .padding(20)
            }
            .font(.custom("Big title", size: 40))
            .fontWeight(.black)
            .padding(.horizontal, 20)
            Spacer()
                .frame(height: 80)
            
//            MARK: HABIT ARRAY
            ForEach(objects.habitIdArray, id: \.self) { habit in
                VStack {
                    HStack {
                        Image(systemName: objects.habitTickBoxDict[habit] ?? false ? "checkmark.square.fill" : "square")
                            .font(.custom("Big Header", size: 20))
                        
                        Spacer()
                            .frame(width: 105)
                        
                        Text(objects.habitIdDict[habit] ?? "")
                            .font(.custom("Big Header", size: 30))
                            .overlay(
                                objects.isHabitStriked[habit] ?? false ?
                                    Rectangle()
                                        .frame(height: 4)
                                        .colorInvert()
                                        .padding(.horizontal, -10)
                                    : nil
                            )
                        
                        Spacer()
                        
                        Text(objects.habitDict[habit] ?? "")
                            .font(.custom("Big Header", size: 20))
                    }
                    .fontWeight(.black)
                    .shadow(radius: 3, x: 3, y: 3)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 1)
                    .onTapGesture {
                        objects.habitTickBoxDict[habit]?.toggle()
                    }
                    .gesture(
                        LongPressGesture(minimumDuration: 1.5)
                            .onChanged { _ in
                                objects.isHabitStriked[habit] = true
                            }
                            .onEnded { _ in
                                objects.isHabitStriked[habit] = false
                                objects.selectedHabit = habit
                            }
                    )
                }
            }
            
            Spacer()
            
//            MARK: ADD HABIT Button
            HStack {
                Button(action: {
                    IsAddHabitVisible = true
                }) {
                    Text("Add Habit")
                        .font(.title)
                        .fontWeight(.bold)
                }
                .padding(20)
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

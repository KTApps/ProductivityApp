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
            
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 60)
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
                Text(habit)
                    .font(.title)
                    .fontWeight(.bold)
                    .offset(objects.habitPositions[habit] ?? .zero)
                    .shadow(radius: 3, x: 3, y: 3)
                    .overlay(
                        objects.isHabitStriked[habit] ?? false ?
                            Rectangle()
                                .frame(height: 5)
                                .foregroundColor(.black)
                                .offset(x: objects.habitPositions[habit]?.width ?? 0, y: 0)
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
            }
            
            Spacer()
            
            HStack {
                Image(systemName: "chevron.left")
                Spacer()
                    .frame(width: 20)
                Text("Swipe task to delete")
                Spacer()
                    .frame(width: 20)
                Image(systemName: "chevron.right")
            }
            
            Spacer()
                .frame(height: 30)
            
            HStack {
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
            .padding(.horizontal, 40)
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
        .environmentObject(Objects())
}

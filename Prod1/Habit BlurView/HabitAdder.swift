//
//  HabitAdder.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 18/02/2024.
//

import SwiftUI

struct HabitAdder: View {
    @EnvironmentObject var objects: Objects
    
    @State private var habitName: String = ""
    
    @Binding var habitArray: [String]
    private func habitAppender() {
        habitArray.append(habitName)
    }
    
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("Task")
                    Spacer()
                }
                .shadow(radius: 3, x: 3, y: 3)
                .padding(.horizontal, 2)
                
                TextField("Task Name", text: $habitName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .colorInvert()
                    .shadow(radius: 5, x: 3, y: 3)
                
                Spacer()
                    .frame(height: 30)
                
                Button(action: {
                    habitAppender()
                    habitName = ""
                    print(habitArray)
                }) {
                    Text("Save")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(15)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(25)
                        .shadow(radius: 5, x: 3, y: 3)
                }
                
                Spacer()
                    .frame(height: 10)
                
                HStack {
                    Text("Preview")
                    Spacer()
                }
                .shadow(radius: 3, x: 3, y: 3)
                .padding(.horizontal, 2)
                
                Spacer()
                    .frame(height: 20)
                
                ForEach(habitArray, id: \.self) { habit in
                    Text(habit)
                        .font(.title)
                        .fontWeight(.bold)
                        .offset(objects.habitPositions[habit] ?? .zero)
                        .foregroundColor(.black)
                        .shadow(radius: 3, x: 3, y: 3)
                        .overlay(
                            objects.isHabitStriked[habit] ?? false ?
                                Rectangle()
                                    .frame(height: 5)
                                    .foregroundColor(.white)
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
                    .frame(height: 60)
            }
            .padding(.top, 50)
            .padding(.horizontal, 30)
        }
        .onChange(of: objects.selectedHabit) { habitToRemove in
            if let habitToRemove = habitToRemove { // if 'habitToRemove' != nil then...
                habitArray.removeAll { $0 == habitToRemove } // remove all strings in array (if they're equal to 'habitToRemove
            }
        }
    }
}

struct HabitAdder_Previews: PreviewProvider {
    @State static var habitArray: [String] = ["Wake up", "Read", "Exercise"]

    static var previews: some View {
        HabitAdder(habitArray: $habitArray)
            .environmentObject(Objects())
    }
}

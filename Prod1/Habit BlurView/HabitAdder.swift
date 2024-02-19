//
//  HabitAdder.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 18/02/2024.
//

import SwiftUI

struct HabitAdder: View {
    
    @State private var habitName: String = ""
    
    @Binding var habitArray: [String]
    private func habitAppender() {
        habitArray.append(habitName)
    }
    
    @State private var selectedHabit: String?
    
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
                    }
                }
                Spacer()
            }
            .padding(.top, 50)
            .padding(.horizontal, 30)
        }
        .onChange(of: selectedHabit) { habitToRemove in
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
    }
}

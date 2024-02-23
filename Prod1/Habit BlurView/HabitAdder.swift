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
    @State private var habitTime: String = ""
    
    @Binding var habitArray: [String]
    @Binding var habitDict: [String: String]
    private func habitAppender() {
        habitArray.append(habitName)
        habitDict[habitName] = habitTime
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
                    .frame(height: 20)
                
                HStack {
                    Text("Time")
                    Spacer()
                }
                .shadow(radius: 3, x: 3, y: 3)
                .padding(.horizontal, 2)
                
                TextField("Time", text: $habitTime)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .colorInvert()
                    .shadow(radius: 5, x: 3, y: 3)
                
                Spacer()
                    .frame(height: 25)
                
                Button(action: {
                    habitAppender()
                    habitName = ""
                    habitTime = ""
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
            }
            .padding(.top, 50)
            .padding(.horizontal, 30)
        }
    }
}

struct HabitAdder_Previews: PreviewProvider {
    @State static var habitArray: [String] = [""]
    @State static var habitDict: [String: String] = ["": ""]
    
    static var previews: some View {
        HabitAdder(habitArray: $habitArray, habitDict: $habitDict)
            .foregroundColor(.black)
            .environmentObject(Objects())
    }
}

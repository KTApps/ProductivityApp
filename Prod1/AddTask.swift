//
//  AddTask.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 24/03/2024.
//

import SwiftUI

struct AddTask: View {
    @EnvironmentObject var object: Objects
    var body: some View {
        VStack {
            TextField("Task name", text: $object.TaskString)
                .padding(10)
                .border(Color.white)
            
            Spacer()
                .frame(height: 20)
            
            Button {
                object.TaskAdder()
            } label: {
                ZStack {
                    Capsule()
                        .fill(Color.gray)
                    .frame(width: 150, height: 32)
                    
                    Text("Add Task")
                        .font(.title3)
                        .foregroundColor(Color.white)
                }
            }
            Spacer()
        }
        .padding(20)
    }
}

struct AddTask_Previews: PreviewProvider {
    static var previews: some View {
        AddTask()
            .environmentObject(Objects())
    }
}

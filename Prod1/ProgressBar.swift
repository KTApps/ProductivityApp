//
//  ProgressBar.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 19/03/2024.
//

import SwiftUI

struct CustomProgressBar: View {
    @EnvironmentObject var object: Objects

    var body: some View {
        ScrollView {
            Spacer()
                .frame(height: 12)
            HStack {
                Text("Select Your Task")
                Spacer()
            }
            .padding(.horizontal, 17)
            ForEach(object.Tasks.indices, id:\.self) {index in
                let item = object.Tasks[index]
                Button {
                    withAnimation {
                        object.TaskName = item
                        object.IsTaskDropDownVisible.toggle()
                        object.TaskTime = object.resetTimer() ?? 0
                    }
                } label: {
                    ZStack(alignment: .leading) {
                        
                        ZStack(alignment: .trailing) {
                            Capsule()
                                .fill(Color.gray)
                                .frame(width: object.maxWidth, height: 32)
                            
                            Text("\(object.TaskPercentageDict[item] ?? 0)%")
                                .foregroundColor(.white)
                                .padding()
                        }
                        
                        Capsule()
                            .fill(Color.blue)
                            .frame(width: (CGFloat(object.newTimeArray[item] ?? 0)), height: 32)
                        
                        HStack {
                            Spacer()
                            Text("\(item)")
                                .foregroundColor(.white)
                            Spacer()
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, -5)
                }
            }
            Button(action: {
                object.isAddTaskVisible.toggle()
            }) {
                ZStack {
                    Capsule()
                        .fill(Color.gray)
                    .frame(width: 150, height: 32)
                    
                    Text("Add Task")
                        .font(.title3)
                        .foregroundColor(Color.white)
                }
            }
            .padding(.vertical, 15)
            .sheet(isPresented:  $object.isAddTaskVisible) {
                AddTask()
                    .presentationDetents([.fraction(1/4)])
            }
        }
    }
}

//#Preview {
//    CustomProgressBar()
//}

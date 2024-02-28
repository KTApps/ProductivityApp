//
//  ContentView.swift
//  Prod1
//
//  Created by Tanaka Bere on 10/02/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var object: Objects
    
    @State var TaskTime: Int = 0
    @State var TimerCount: Int = 0
    private func TaskTimer() -> Int? {
        for item in drop { // Use '.forEach{}' when performing an operation. Use 'ForEach(){}' when presenting a view.
            if (item.title == object.TaskName) {
                if object.TaskTimerDictionary[item.title] != nil {
                    object.TaskTimerDictionary[item.title]? += 1
                } else {
                    TimerCount = 0
                    TimerCount += 1
                    object.TaskTimerDictionary[item.title] = TimerCount
                }
                return object.TaskTimerDictionary[item.title]
            }
        }
        return nil
    }
    
    private func resetTimer() -> Int? {
        for item in drop {
            if (item.title == object.TaskName) {
                if object.TaskTimerDictionary[item.title] == nil {
                    return 0
                } else {
                    return object.TaskTimerDictionary[item.title]
                }
            }
        }
        return nil
    }
    
    var body: some View {
        
//        MARK: ZStack for BlurView
        ZStack {
            VStack{
                
//                MARK: TASK TITLE & TASK DROP DOWN ZStack
                ZStack{
                    
//                    MARK: TASK DROP DOWN ZStack
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.gray)
                        ScrollView{
                            LazyVStack(spacing: 17) {
                                
//                                MARK: LIST OF DROPDOWN Buttons
                                ForEach(drop) { item in
                                    Button(action: {
                                        withAnimation {
                                            object.TaskName = item.title
                                            object.IsTaskDropDownVisible = true
                                        }
                                        TaskTime = resetTimer() ?? 0
                                    }) {
                                        HStack {
                                            Text(item.title)
                                                .foregroundColor(.white)
                                                .font(.callout)
                                                .multilineTextAlignment(.center)
                                                .bold()
                                            Spacer()
                                        }
                                    }
                                }
                                .padding(.horizontal)
                                
//                                MARK: ADD DROPDOWN ITEM Button
                                Button(action: {
                                    
                                }) {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(lineWidth: 1)
                                            .frame(width: 100, height: 30)
                                            .foregroundColor(.white)
                                        Text("Add item")
                                            .font(.callout)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 15)
                        }
                    }
                    .frame(height: object.IsTaskDropDownVisible ? 200 : 0) // If show = true, ZStack height = 220, else height = 0
                    .offset(y: object.IsTaskDropDownVisible ? 160 : 20) // Control Transition of DropDown
                    
//                    MARK: TASK TITLE ZStack
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 60)
                            .foregroundColor(.black)
                        HStack{
                            Text(object.TaskName)
                                .font(.title2)
                            Image(systemName: "chevron.down")
                        }
                        .bold()
                        .foregroundColor(.white)
                    }
                    .offset(y: 20)
                    .onTapGesture {
                        withAnimation {
                            object.IsTaskDropDownVisible.toggle()
                        }
                    }
                }
                .zIndex(1)
                .padding(.horizontal, 10)
                
//                            MARK: HOUR GLASS Label
                HStack {
                    Label("\(TaskTime)", systemImage: "hourglass.bottomhalf.fill")
                        .onReceive(object.timer) { time in
                            if object.IsTimerOn {
                                TaskTime = TaskTimer() ?? 0
                            }
                        }
                    
                    Spacer()
                        .frame(width: 30)
                    
                    Button(action: {
                        object.IsTimerOn.toggle()
                        if object.IsTimerOn {
                            object.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                        } else {
                            object.timer.upstream.connect().cancel()
                        }
                    }) {
                        Image(systemName: object.IsTimerOn ? "stop.circle.fill" : "play.circle.fill")
                    }
                }
                .font(.title3)
                .bold()
                .padding(.vertical, 30)
                .offset(x: -5, y: -5)
                
//                            MARK: CIRCLE ZStack
                ZStack{
                    
//                                MARK: INNER CIRCLE Button
                    Button(action: {
                        object.IsBlurViewVisible = true
                    }) {
                        Circle()
                            .stroke(lineWidth: 20)
                            .opacity(0.3)
                            .foregroundColor(.gray)
                            .frame(width: 220, height: 220)
                    }
                    
//                                MARK: OUTER CIRCLE
                    Circle()
                        .stroke(
                            style: StrokeStyle(
                                lineWidth: 20,
                                lineCap: .round,
                                lineJoin: .round
                            )
                        )
                        .foregroundColor(.blue)
                        .rotationEffect(.degrees(-90))
                        .frame(width: 300, height: 300)
                    VStack{
                        Text("3 Hours")
                            .font(.callout)
                        Text("Today")
                            .font(.caption) // placeholder for date
                    }
                }
                Spacer()
                    .frame(height: 60)
                
//                            MARK: LAST 10 DAYS BLOCK
                VStack{
                    HStack{
                        Text("Last 10 Days")
                            .font(.headline)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.horizontal, 10)
                    
//                                MARK: VIEW YOUR PROGRESS Rectangle
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 200)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 7)
                        
//                                    MARK: VIEW YOUR PROGRESS Button
                        VStack{
                            Spacer()
                            Button(action: {
                                object.IsViewYourProgressVisible = true
                            }) {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(lineWidth: 1)
                                        .frame(width: 180, height: 40)
                                    Text("View Your Progress")
                                }
                                .foregroundColor(.white)
                            }
                            .sheet(isPresented: $object.IsViewYourProgressVisible) {
                                ViewYourProgress()
                                    .presentationDetents([.medium, .large])
                            }
                        }
                        .padding()
                    }
                }
            }
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
            
//            MARK: BlurView Button
            if object.IsBlurViewVisible {
                BlurView()
                    .ignoresSafeArea()
            }
        }
    }
}
        
        
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Objects())
    }
}

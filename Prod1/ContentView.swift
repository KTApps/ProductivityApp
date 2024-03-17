//
//  ContentView.swift
//  Prod1
//
//  Created by Tanaka Bere on 10/02/2024.
//

import SwiftUI
import Charts

struct ContentView: View {
    @EnvironmentObject var object: Objects
    
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
                                            object.IsTaskDropDownVisible.toggle()
                                        }
                                        object.TaskTime = object.resetTimer() ?? 0
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
                    .offset(y: object.IsTaskDropDownVisible ? 140 : 35) // Control Transition of DropDown
                    
//                    MARK: TASK TITLE ZStack
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 0)
                            .foregroundColor(.black)
                        HStack{
                            Text(object.TaskName)
                                .font(.largeTitle)
                                .offset(x: 20)

                            Image(systemName: "chevron.down")
                                .offset(x: 25)
                                
                            Button {
                                object.isSettingsVisible = true
                            } label: {
                                Image(systemName: "gear")
                                    .resizable()
                            }
                            .frame(width: 25, height: 25)
                            .offset(x: 110)
                            .sheet(isPresented: $object.isSettingsVisible) {
                                SettingsView()
                                    .presentationDetents([.medium])
                            }
                        }
                        .bold()
                        .foregroundColor(.white)
                    }
                    .offset(y: 10)
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
                    Label("\(object.TaskTime)", systemImage: "hourglass.bottomhalf.fill")
                        .onReceive(object.timer) { time in
                            if object.IsTimerOn {
                                object.TaskTime = object.TaskTimer() ?? 0
                            }
                        }
                    
                    Spacer()
                        .frame(width: 30)
                    
                    Button(action: {
                        object.IsTimerOn.toggle()
                        if object.IsTimerOn {
                            object.timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
                        } else {
                            object.timer.upstream.connect().cancel()
                        }
                    }) {
                        Image(systemName: object.IsTimerOn ? "stop.circle.fill" : "play.circle.fill")
                    }
                }
                .font(.title)
                .bold()
                .offset(x: -5, y: 15)
                
//                            MARK: CIRCLE ZStack
                ZStack{
                    
//                                MARK: OUTER CIRCLE
                    Chart(drop) { task in
                        SectorMark(
                            angle: .value("Time Spent", object.TaskTimerDictionary[task.title] ?? 0),
                            innerRadius: 140,
                            outerRadius: 170,
                            angularInset: 1
                        )
                        .foregroundStyle(task.colour)
                        .cornerRadius(5)
                    }
                    
//                                MARK: INNER CIRCLE Button
                    Button(action: {
                        object.IsBlurViewVisible = true
                    }) {
                        ZStack {
                            Circle()
                                .stroke(lineWidth: 20)
                                .opacity(0.3)
                                .foregroundColor(.gray)
                                .frame(width: 220, height: 220)
                            Chart(object.habitIdArray, id:\.self) { habit in
                                SectorMark(
                                    angle: .value("isTicked", 1),
                                    innerRadius: 90,
                                    outerRadius: 120,
                                    angularInset: 1
                                )
                                .foregroundStyle(object.ColorReturn(value: habit))
                            }
                            VStack{
                                Text("\(object.TaskTime) Seconds")
                                    .font(.title2)
                                Text("Today")
                                    .font(.title3) // placeholder for date
                            }
                        }
                        .foregroundColor(.white)
                    }
                }
                
//                            MARK: LAST 10 DAYS BLOCK
                VStack{
                    HStack{
                        Text("Last 10 Days")
                            .font(.title3)
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
                            Button(action: {
                                object.IsViewYourProgressVisible = true
                            }) {
                                VStack {
                                    Spacer()
                                        .frame(height: 100)
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(lineWidth: 1)
                                            .frame(width: 210, height: 40)
                                        Text("View Your Progress")
                                            .font(.title3)
                                            .fontWeight(.bold)
                                    }
                                    .foregroundColor(.white)
                                }
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

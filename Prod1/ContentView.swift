//
//  ContentView.swift
//  Prod1
//
//  Created by Tanaka Bere on 10/02/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var objects: Objects
    var dropMenu = DropMenu.self
    
    @State var TaskName = "Task"

//    MARK: BOOLEAN STATE VARIABLES
    @State var IsTaskDropDownVisible = false
    @State private var IsViewYourProgressVisible = false
    
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
                                            TaskName = item.title
                                            IsTaskDropDownVisible = true
                                        }
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
                    .frame(height: IsTaskDropDownVisible ? 200 : 0) // If show = true, ZStack height = 220, else height = 0
                    .offset(y: IsTaskDropDownVisible ? 160 : 20) // Control Transition of DropDown
                    
//                    MARK: TASK TITLE ZStack
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 60)
                            .foregroundColor(.black)
                        HStack{
                            Text(TaskName)
                                .font(.title2)
                            Image(systemName: "chevron.down")
                        }
                        .bold()
                        .foregroundColor(.white)
                    }
                    .offset(y: 20)
                    .onTapGesture {
                        withAnimation {
                            IsTaskDropDownVisible.toggle()
                        }
                    }
                }
                .zIndex(1)
                .padding(.horizontal, 10)
                
//                            MARK: HOUR GLASS Label
                HStack {
                    Label("\(objects.TimerCount)", systemImage: "hourglass.bottomhalf.fill")
                        .onReceive(objects.timer) { time in
                            if objects.IsTimerOn {
                                objects.TimerCount += 1
                            }
                        }
                    
                    Spacer()
                        .frame(width: 30)
                    
                    Button(action: {
                        objects.IsTimerOn.toggle()
                        if objects.IsTimerOn {
                            objects.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                        } else {
                            objects.timer.upstream.connect().cancel()
                        }
                    }) {
                        Image(systemName: objects.IsTimerOn ? "stop.circle.fill" : "play.circle.fill")
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
                        objects.IsBlurViewVisible = true
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
                                IsViewYourProgressVisible = true
                            }) {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(lineWidth: 1)
                                        .frame(width: 180, height: 40)
                                    Text("View Your Progress")
                                }
                                .foregroundColor(.white)
                            }
                            .sheet(isPresented: $IsViewYourProgressVisible) {
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
            if objects.IsBlurViewVisible {
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

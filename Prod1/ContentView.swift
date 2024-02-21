//
//  ContentView.swift
//  Prod1
//
//  Created by Tanaka Bere on 10/02/2024.
//
struct DropMenu: Identifiable {
    var id = UUID()
    var title: String
}
let drop = [
    DropMenu(title: "Piano"),
    DropMenu(title: "Chess"),
    DropMenu(title: "Creative Writing"),
    DropMenu(title: "Reading"),
    DropMenu(title: "Spanish Speaking"),
    DropMenu(title: "Sudoku")
]

import SwiftUI
import Modals

struct ContentView: View {
    @State var show = false
    @State var name = "Task"
    @State private var isPresented = false
    @State var isBlurActive = false
    var body: some View {
        ZStack {
            VStack{
                ZStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                        ScrollView{
                            VStack(spacing: 17){
                                ForEach(drop) { item in
                                    Button {
                                        withAnimation {
                                            name = item.title
                                            show.toggle()
                                        }
                                    } label: {
                                        Text(item.title).foregroundColor(.white).font(.callout).multilineTextAlignment(.center)
                                            .bold()
                                        Spacer()
                                    }
                                }
                                .padding(.horizontal)
                                
                                HStack {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1)
                                            .frame(width: 100, height: 30)
                                            .foregroundColor(.white)
                                        Text("Add Task").font(.callout).fontWeight(.bold).foregroundColor(.white).bold()
                                        Button(action: {}) {
                                        }
                                    }
                                }
                                
                            }
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .padding(.vertical,15)
                            
                        }
                    }
                    .frame(height: show ? 220 : 50)
                    .offset(y: show ? 0 : -135)
                    .foregroundColor(.gray)
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 10).frame(height: 60)
                            .foregroundColor(.black)
                        HStack{
                            Text(name).font(.title2)
                            
                            Image(systemName: "chevron.down")
                        }
                        .bold()
                        .padding(.horizontal)
                        .foregroundColor(.white)
                    }
                    .offset(y: -135)
                    .onTapGesture {
                        withAnimation {
                            show .toggle()
                        }
                    }
                }
                .zIndex(1)
                .padding(30)
                VStack {
                    VStack{
                        VStack{
                            Label("00:00:00", systemImage: "hourglass.bottomhalf.fill").font(.callout)
                                .bold()
                                .padding()
                                .offset(x: -5)
                                .padding(10)
                            
                            ZStack{
                                Button(action: {
                                    isBlurActive.toggle()
                                }) {
                                    Circle()
                                        .stroke(lineWidth: 20.0)
                                        .opacity(0.3)
                                        .foregroundColor(.gray)
                                        .frame(width: 220, height: 220)
                                }
                                Circle()
                                    .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                                    .foregroundColor(.blue)
                                    .rotationEffect(.degrees(-90))
                                    .frame(width: 300, height: 300)
                                VStack{
                                    Text("3 Hours").font(.callout)
                                    Text("Today").font(.caption) // placeholder for date
                                }
                            }
                            VStack{
                                HStack{
                                    Text("Last 10 Days")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                                .padding(.horizontal, 10)
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10).frame(height: 200)
                                        .foregroundColor(.gray)
                                    VStack{
                                        Spacer()
                                        Button {
                                            isPresented = true
                                        } label: {
                                            ZStack{
                                                RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1)
                                                    .frame(width: 180, height: 40)
                                                    .foregroundColor(.white)
                                                Text("View Your Progress")
                                                    .foregroundColor(Color.white)
                                            }
                                            .modal(isPresented: $isPresented) {
                                                ViewYourProgress()
                                            }
                                            
                                        }
                                    }
                                    .padding()
                                }
                                .offset(y: 60)
                            }
                        }
                        .offset(y: 100)
                    }
                    .padding()
                    .frame(height: 300).offset(y: -140)
                    .preferredColorScheme(.dark)
                }
            }
            if isBlurActive {
                Button(action: {
                    isBlurActive.toggle()
                }) {
                    BlurView()
                        .ignoresSafeArea()
                }
            }
        }
    }
}
        
        
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

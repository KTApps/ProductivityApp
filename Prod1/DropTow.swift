//
//  DropTow.swift
//  Prod1
//
//  Created by Tanaka Bere on 11/02/2024.
//

import SwiftUI

struct DropTow: View {
    @State var show = true
    @State var name = "Task"
    var body: some View {
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
                                    Text(item.title).foregroundColor(.white)
                                        .bold()
                                    Spacer()
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.vertical,15)
                    }
                }
                .frame(height: show ? 200 : 50)
                .offset(y: show ? 0 : -135)
                .foregroundColor(.gray)
                
                
                
                ZStack{
                    RoundedRectangle(cornerRadius: 10).frame(height: 60)
                        .foregroundColor(.white)
                    HStack{
                        Text(name).font(.title2)
                        Spacer()
                        
                        Image(systemName: "chevron.down")
                    }
                    .bold()
                    .padding(.horizontal)
                    .foregroundColor(.black)
                }
                .offset(y: -135)
                .onTapGesture {
                    withAnimation {
                        show .toggle()
                    }
                    }
                }
            }
            .padding()
            .frame(height: 300).offset(y: 30)
        }
}

struct DropTow_Previews: PreviewProvider {
    static var previews: some View {
        DropTow()
    }
}

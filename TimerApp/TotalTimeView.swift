//
//  TotalTimeView.swift
//  TimerApp
//
//  Created by atj on 2020/05/20.
//  Copyright © 2020 atj. All rights reserved.
//

import SwiftUI

/*
 let now = Date()
 let tomorrow = Date().addingTimeInterval(86400)
 let range = now ... tomorrow
 
 */

struct TotalTimeView: View {
    
    @ObservedObject var timeManager = TimeManager()
    
    let day: [String] = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
    
    var body: some View {
        /*
        GeometryReader { g in
            VStack {
                if self.timeManager.totalTime > 3600 { //시:분:초
                    Text("\((self.timeManager.totalTime) / 3600):\(((self.timeManager.totalTime) % 3600) / 60):\((((self.timeManager.totalTime) % 3600) % 60) % 60)")
                    .font(.system(size: 20))
                }
                else {//self.timeManager.leftMainTime > 60 { //분:초
                    Text("\((self.timeManager.totalTime) / 60) : \((self.timeManager.totalTime) % 60)")
                    .font(.system(size: 20))
                }
            }
            .onTapGesture(perform: {
                self.timeManager.totalTime = 0
            })
        }
        */
        GeometryReader { g in
            VStack {
                // MARK: 상단 arrow, 월, 주 표시
                ZStack {
                    HStack {
                        Button(action: {
                            
                        }) {
                            Image(systemName: "arrowtriangle.left")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }) {
                            Image(systemName: "arrowtriangle.right")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.black)
                        }
                    }
                    
                    Text("Month   week1")
                        .fontWeight(.bold)
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                
                Spacer()
                
                // MARK: Time table 내용.
                ScrollView {
                    ForEach(0...6,id: \.self) { i in
                        ZStack {
                            RoundedRectangle(cornerRadius: 10.0)
                                .stroke(Color.black)
                                .frame(width: g.size.width-10, height: 70)
                                .padding(.horizontal)
                            
                            Spacer()
                            
                            HStack() {
                                Text(self.day[i])
                                
                                Spacer()
                                
                                ZStack() {
                                    /*
                                    Capsule()
                                        .frame(width: 20, height: 150)
                                        .rotationEffect(Angle(degrees: 90))
                                    Capsule()
                                    .frame(width: 20, height: 100)
                                        .foregroundColor(.gray)
                                    .rotationEffect(Angle(degrees: 90))
                                    */
                                    Text("")
                                        .frame(width: g.size.width/1.5, height: -15, alignment: .leading)
                                        .padding()
                                        .background(Color.black)
                                        .clipShape(Capsule())
                                    
                                    Text("")
                                        .frame(width: g.size.width/2, height: -15, alignment: .leading)
                                        .padding()
                                        .background(Color.gray)
                                        .clipShape(Capsule())

                                }
                            }
                            .padding(.horizontal)
                            .frame(width: g.size.width-10)
                            
                        }
                    }
                }

            }
        }
        
    }
}


struct TotalTimeView_Previews: PreviewProvider {
    static var previews: some View {
        TotalTimeView()
    }
}

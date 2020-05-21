//
//  MainTimer.swift
//  TimerApp
//
//  Created by atj on 2020/05/15.
//  Copyright © 2020 atj. All rights reserved.
//

import SwiftUI

struct MainTimer: View {
    
    @ObservedObject var timeManager = TimeManager()
    
    // 시간 선택 화면 modal을 위한 Bool  변수.
    @State private var showTimeSelection: Bool = false
    
    // TotalTime view modal.
    @State private var showTotalTime: Bool = false
    
    // 시간 선택 화면에서 시간을 받아오는 임시 변수.
    @State private var tmpTime: Int = 0
    
    // main timer / break timer를 구별해주는 변수.
    @State private var isMainTimer: Bool = false
        
    var body: some View {
            
        VStack {
            GeometryReader { g in
                /****************************상단 쉬는시간 타이머, 총 시간 *********************************/
                HStack(alignment: .center) {
                    
                    
                    VStack {
                        HStack {
                            Image(systemName: "gobackward")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .onTapGesture(perform: {
                                self.timeManager.resetBreakTimer()
                            })
                            
                            Spacer()
                            
                            // MARK: Break timer
                            VStack {
                                if self.timeManager.leftBreakTime > 3600 { //시:분:초
                                    Text("\((self.timeManager.leftBreakTime) / 3600):\(((self.timeManager.leftBreakTime) % 3600) / 60):\((((self.timeManager.leftBreakTime) % 3600) % 60) % 60)")
                                    .font(.system(size: 35))
                                }
                                else {//self.timeManager.leftMainTime > 60 { //분:초
                                    Text("\((self.timeManager.leftBreakTime) / 60) : \((self.timeManager.leftBreakTime) % 60)")
                                    .font(.system(size: 30))
                                }
                            }
                            .onTapGesture(perform: {
                                self.showTimeSelection = true
                            })
                            .sheet(isPresented: self.$showTimeSelection){
                                TimeSelection(showTimeSelection: self.$showTimeSelection, isMainTimer: self.$isMainTimer, timeManager: self.timeManager)
                            }
                            
                            Spacer()
                            
                            Image(systemName: self.timeManager.breakTimerMode == .running ? "pause" : "play")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .onTapGesture(perform: {
                                self.timeManager.breakTimerMode == .running ?
                                    self.timeManager.pauseBreakTimer() : self.timeManager.startBreakTimer()
                            })
                        }
                        .padding(.horizontal)
                    
                    }
                    .frame(maxWidth: .infinity)
                    
                    
                    Divider().frame(width: 10, height: g.size.height / 15)

                    // MARK: Total time
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
                    .frame(maxWidth: .infinity)
                    .onTapGesture(perform: {
                        self.showTotalTime = true
                    })
                    .sheet(isPresented: self.$showTotalTime){
                        TotalTimeView(timeManager: self.timeManager)
                    }
                    
                    
                }
                .frame(height: g.size.height / 15)
                        
                /****************************메인 타이머, 초기화, 시작 버튼 *********************************/
                VStack {
                    // MARK: Main timer
                    ZStack {
                        if self.timeManager.leftMainTime > 3600 { //시:분:초
                            Text("\((self.timeManager.leftMainTime) / 3600):\(((self.timeManager.leftMainTime) % 3600) / 60):\((((self.timeManager.leftMainTime) % 3600) % 60) % 60)")
                            .font(.system(size: 60))
                        }
                        else {//self.timeManager.leftMainTime > 60 { //분:초
                            Text("\((self.timeManager.leftMainTime) / 60) : \((self.timeManager.leftMainTime) % 60)")
                            .font(.system(size: 60))
                        }
                    }
                    //타이머 숫자를 터치하면 시간 선택.
                    .onTapGesture(perform: {
                        self.showTimeSelection = true
                        self.isMainTimer = true
                    })
                    .sheet(isPresented: self.$showTimeSelection){
                        TimeSelection(showTimeSelection: self.$showTimeSelection, isMainTimer: self.$isMainTimer, timeManager: self.timeManager)
                    }
                    
                    Spacer()
                        .frame(height: g.size.height/4)
                    
                    
                    // MARK: Buttons for main timer
                    HStack{
                        Image(systemName: "gobackward")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .onTapGesture(perform: {
                                self.timeManager.resetMainTimer()
                            })
                        
                        //초기화 <-> 시작 버튼 간격.
                        Spacer()
                            .frame(width: g.size.height/3.5)
                        
                        //타이머 시작 버튼.
                        Image(systemName: self.timeManager.mainTimerMode == .running ? "pause" : "play")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .onTapGesture(perform: {
                                if self.timeManager.mainTimerMode == .running {
                                    self.timeManager.pauseMainTimer()
                                }
                                else {
                                    // Reset break timer when main timer starts.
                                    self.timeManager.resetBreakTimer()
                                    self.timeManager.startMainTimer()
                                }
                            })
                                
                        
                    }
                }
                .frame(width: g.size.width, height: g.size.height / 2)
                .offset(y: g.size.height/2.5)
            }
        }
    }
}

struct MainTimer_Previews: PreviewProvider {
    static var previews: some View {
        MainTimer()
    }
}

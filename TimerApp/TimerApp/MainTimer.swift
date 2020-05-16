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
    @State private var showTimeSelection: Bool = false
    
    var body: some View {
            
        VStack {
            GeometryReader { g in
                VStack {
                    
                    //타이머 시간 표시.
                    ZStack {
                        Text("\(self.timeManager.leftMainTime)")
                            .font(.system(size: 60))
                    }
                    //타이머 숫자를 터치하면 시간 선택.
                    .onTapGesture(perform: {
                        self.showTimeSelection = true
                    })
                    .sheet(isPresented: self.$showTimeSelection){
                        TimeSelection()
                    }
                    
                    Spacer()
                        .frame(height: g.size.height/4)
                    
                    
                    //타이머 초기화, 시작 버튼.
                    HStack{
                        Image(systemName: "gobackward")
                            .resizable()
                            .frame(width: g.size.width/14, height: g.size.height/22)
                            .onTapGesture(perform: {
                                self.timeManager.reset()
                            })
                        
                        //초기화 <-> 시작 버튼 간격.
                        Spacer()
                            .frame(width: g.size.height/3.5)
                        
                        //타이머 시작 버튼.
                        Image(systemName: self.timeManager.timerMode == .running ? "pause" : "play")
                            .resizable()
                            .frame(width: g.size.width/14, height: g.size.height/22)
                            .onTapGesture(perform: {
                                self.timeManager.timerMode == .running ?
                                    self.timeManager.pause() : self.timeManager.start()
                            })
                                
                        
                    }
                }
                .frame(width: g.size.width, height: g.size.height/2, alignment: .bottom)
                .offset(y: g.size.height/6)
            }
        }
    }
}

struct MainTimer_Previews: PreviewProvider {
    static var previews: some View {
        MainTimer()
    }
}

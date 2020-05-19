//
//  TimeManager.swift
//  TimerApp
//
//  Created by atj on 2020/05/16.
//  Copyright © 2020 atj. All rights reserved.
//

import SwiftUI
import Foundation

//현재 타이머의 상태.
enum TimerMode {
    case running //진행 중.
    case paused //일시 정지.
    case reset //초기화.
}

class TimeManager: ObservableObject {
    
    //현재 메인 타이머의 상태.
    @Published var timerMode: TimerMode = .reset
    
    //메인 타이머의 남은 시간.
    @Published var leftMainTime: Int = 0
    
    //사용자가 선택한 메인 타이머 시간.
    var _selectedMainTime: Int = 0
    var selectedMainTime: Int {
        get { return _selectedMainTime }
        set { _selectedMainTime = newValue }
    }

    //메인 타이머.
    var mainTimer = Timer()
    
    //쉬는 시간 타이머.
    var breakTimer = Timer()
    
    
    init(_ time: Int) {
        self.selectedMainTime = time
        self.leftMainTime = self.selectedMainTime
    }
    
    //타이머 시간 변경.
    func setTime(_ time: Int) {
        self.selectedMainTime = time
        self.leftMainTime = self.selectedMainTime
    }
    
    //타이머 작동 시작.
    func start() {
        
        timerMode = .running
        
        mainTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            
            self.leftMainTime -= 1
            
            //타이머 종료.
            if self.leftMainTime == 0 {
                self.reset()
            }
            
        })
    }
    
    func reset() {
        self.timerMode = .reset
        //self.leftTime = timeForMainTimer
        self.leftMainTime = self.selectedMainTime
        mainTimer.invalidate()
    }
    
    func pause() {
        self.timerMode = .paused
        mainTimer.invalidate()
    }
}

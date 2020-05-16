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
    
    //현재 타이머의 상태.
    @Published var timerMode: TimerMode = .reset
    
    //메인 타이머의 남은 시간.
    @Published var leftTime: Int = 60
    
    //사용자가 선택한 메인 타이머 시간.
    var _timeForMainTimer: Int = 0
    var timeForMainTimer: Int {
        get { return _timeForMainTimer }
        set {
            _timeForMainTimer = newValue
        }
    }
    
    var timer = Timer()
    
    /*
    init() {
        self.timeForMainTimer = 60
        self.leftTime = 60
    }
 */
   
    //타이머 작동 시작.
    func start() {
        
        timerMode = .running
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            //타이머 종료.
            if self.leftTime == 0 {
                self.reset()
            }
            self.leftTime -= 1
        })
    }
    
    func reset() {
        self.timerMode = .reset
        //self.leftTime = timeForMainTimer
        self.leftTime = 60
        timer.invalidate()
    }
    
    func pause() {
        self.timerMode = .paused
        timer.invalidate()
    }
}

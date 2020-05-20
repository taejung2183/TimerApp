//
//  TimeManager.swift
//  TimerApp
//
//  Created by atj on 2020/05/16.
//  Copyright © 2020 atj. All rights reserved.
//

import AVFoundation
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
    @Published var mainTimerMode: TimerMode = .reset
    
    //break 타이머 상태.
    @Published var breakTimerMode: TimerMode = .reset

    
    //메인 타이머의 남은 시간.
    @Published var leftMainTime: Int = 0
    //break 타이머 남은 시간.
    @Published var leftBreakTime: Int = 0

    
    //사용자가 선택한 메인 타이머 시간.
    var _selectedMainTime: Int = 0
    var selectedMainTime: Int {
        get { return _selectedMainTime }
        set { _selectedMainTime = newValue }
    }
    //사용자가 선택한 break 타이머 시간.
    var _selectedBreakTime: Int = 0
    var selectedBreakTime: Int {
        get { return _selectedBreakTime }
        set { _selectedBreakTime = newValue }
    }

    //메인 타이머.
    var mainTimer = Timer()
    
    //쉬는 시간 타이머.
    var breakTimer = Timer()
    
    //Total time
    var totalTime: Int = 0
    
    
    init(_ mainTime: Int, _ breakTime: Int) {
        self.selectedMainTime = mainTime
        self.leftMainTime = self.selectedMainTime
        
        self.selectedBreakTime = breakTime
        self.leftBreakTime = self.selectedBreakTime
    }
    
    //타이머 시간 변경.
    func setMainTime(_ time: Int) {
        self.selectedMainTime = time
        self.leftMainTime = self.selectedMainTime
    }
    func setBreakTime(_ time: Int) {
        self.selectedBreakTime = time
        self.leftBreakTime = self.selectedBreakTime
    }
    
    //메인 타이머 작동.
    func startMainTimer() {
        
        mainTimerMode = .running
        
        mainTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            
            self.leftMainTime -= 1
            self.totalTime += 1
            
            //타이머 종료.
            if self.leftMainTime == -1 {
                self.resetMainTimer()
                self.startBreakTimer()
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            }
            
        })
    }
    
    func resetMainTimer() {
        self.mainTimerMode = .reset
        //self.leftTime = timeForMainTimer
        self.leftMainTime = self.selectedMainTime
        mainTimer.invalidate()
    }
    
    func pauseMainTimer() {
        self.mainTimerMode = .paused
        mainTimer.invalidate()
    }
    
    //break 타이머 작동.
    func startBreakTimer() {
        
        breakTimerMode = .running
        
        breakTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            
            self.leftBreakTime -= 1
            
            //타이머 종료.
            if self.leftBreakTime == -1 {
                self.resetBreakTimer()
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            }
            
        })
    }
    
    func resetBreakTimer() {
        self.breakTimerMode = .reset
        //self.leftTime = timeForMainTimer
        self.leftBreakTime = self.selectedBreakTime
        breakTimer.invalidate()
    }
    
    func pauseBreakTimer() {
        self.breakTimerMode = .paused
        breakTimer.invalidate()
    }
}

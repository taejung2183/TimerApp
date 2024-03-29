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

    

    //사용자가 선택한 메인 타이머 시간.
    var _selectedMainTime: Int = UserDefaults.standard.integer(forKey: "mainTime")
    var selectedMainTime: Int {
        get { return _selectedMainTime }
        set { _selectedMainTime = newValue }
    }
    //사용자가 선택한 break 타이머 시간.
    var _selectedBreakTime: Int = UserDefaults.standard.integer(forKey: "breakTime")
    var selectedBreakTime: Int {
        get { return _selectedBreakTime }
        set { _selectedBreakTime = newValue }
    }
    
    //메인 타이머의 남은 시간.
    @Published var leftMainTime: Int = UserDefaults.standard.integer(forKey: "mainTime")
    //break 타이머 남은 시간.
    @Published var leftBreakTime: Int = UserDefaults.standard.integer(forKey: "breakTime")

    //메인 타이머.
    var mainTimer = Timer()
    
    //쉬는 시간 타이머.
    var breakTimer = Timer()
    
    //Total time
    @Published var totalTime: Int = UserDefaults.standard.integer(forKey: "totalTime")
    
    // Variables for current time info.
    var curTime: [Int] = []
    var timeTable: [[Int]] = []
    
    
    /*
    init() {
        self.leftMainTime = self.selectedMainTime
        self.leftBreakTime = self.selectedBreakTime
    }
    */
    
    //타이머 시간 변경.
    func setMainTime(_ time: Int) {
        self.selectedMainTime = time
        self.leftMainTime = self.selectedMainTime
    }
    func setBreakTime(_ time: Int) {
        self.selectedBreakTime = time
        self.leftBreakTime = self.selectedBreakTime
    }
    
    // MARK: Main timer operations
    func startMainTimer() {
        
        // Save current month,day,hour,minute.
        curTime = getCurTime()
        timeTable.append(curTime)
        
        // Set the timer mode to .running.
        mainTimerMode = .running
        
        // 타이머 동작.
        mainTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            
            self.leftMainTime -= 1
            self.totalTime += 1
            
            //타이머 종료.
            if self.leftMainTime == 0 {
                self.Notify()
                self.resetMainTimer()
                
                self.startBreakTimer()
                UserDefaults.standard.set(self.totalTime, forKey: "totalTime")
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                
                // Save current month,day,hour,minute.
                self.curTime = self.getCurTime()
                self.timeTable.append(self.curTime)
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
        UserDefaults.standard.set(self.totalTime, forKey: "totalTime")
        mainTimer.invalidate()
        
        // Save current month,day,hour,minute.
        curTime = getCurTime()
        timeTable.append(curTime)
    }
    
    // MARK: Break timer operations
    func startBreakTimer() {
        
        breakTimerMode = .running
        
        breakTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            
            self.leftBreakTime -= 1
            
            //타이머 종료.
            if self.leftBreakTime == 0 {
                self.Notify()
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
    
    // Returns current time info.
    func getCurTime() -> Array<Int> {
        
        var curTime: [Int] = []
        
        let components = Calendar.current.dateComponents([.month, .day, .hour, .minute], from: Date())
        curTime.append(components.month ?? 0)
        curTime.append(components.day ?? 0)
        curTime.append(components.hour ?? 0)
        curTime.append(components.minute ?? 0)
        
        return curTime
    }
    
    // Notifies timer expiration.
    func Notify() {
        
        let content = UNMutableNotificationContent()
        content.title = "Message"
        content.body = "Timer completed!"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let req = UNNotificationRequest(identifier: "MSG", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
    }

}

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
    
    var body: some View {
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
    }
}


struct TotalTimeView_Previews: PreviewProvider {
    static var previews: some View {
        TotalTimeView()
    }
}

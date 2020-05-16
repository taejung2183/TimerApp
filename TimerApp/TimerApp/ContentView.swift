//
//  ContentView.swift
//  TimerApp
//
//  Created by atj on 2020/05/15.
//  Copyright © 2020 atj. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            //GeometryReader { g in
                HStack(alignment: .center) {
                    
                    //쉬는 시간 타이머.
                    VStack(alignment: .center, spacing: 10) {
                        Text("Break timer")
                    }
                    .frame(maxWidth: .infinity)
                    
                    Divider().frame(height: 30)

                    //누적 시간.
                    VStack {
                        Text("Total time")
                    }
                    .frame(maxWidth: .infinity)
                }
                
                Divider()
                Spacer()
                    //.frame(height: g.size.height/3)
                
                MainTimer()
            //}
        }
        .frame(maxHeight: .infinity)
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

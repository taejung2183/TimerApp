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
        GeometryReader { g in
            VStack {
                
                MainTimer()
            }
        }
      
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

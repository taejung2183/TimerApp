//
//  TimeSelection.swift
//  TimerApp
//
//  Created by atj on 2020/05/16.
//  Copyright © 2020 atj. All rights reserved.
//

import SwiftUI

struct TimeSelection: View {
    
    @State private var selectedIndex = 0
    
    var body: some View {
        Picker("", selection: $selectedIndex) {
            Text("Custom").tag(0)
            Text("1m").tag(1)
            Text("5m").tag(2)
            
        }.pickerStyle(SegmentedPickerStyle())
    }
}

struct TimeSelection_Previews: PreviewProvider {
    static var previews: some View {
        TimeSelection()
    }
}

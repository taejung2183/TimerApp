//
//  TimeSelection.swift
//  TimerApp
//
//  Created by atj on 2020/05/16.
//  Copyright © 2020 atj. All rights reserved.
//

import SwiftUI

struct TimeSelection: View {
    
    @State private var selectedTimeUnit = 0
    
    var body: some View {
        GeometryReader { g in
            VStack(spacing:15) {
                //Color(#colorLiteral(red: 0.2794816196, green: 0.9357709289, blue: 0.7412140369, alpha: 1)).edgesIgnoringSafeArea(.all)
                
                //시간 단위 선택.
                Picker(selection: self.$selectedTimeUnit, label: Text("")) {
                    Text("Custom").tag(0)
                    Text("1m").tag(1)
                    Text("5m").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, g.size.width/15)
                
                //시간 선택.
                //Custom
                if self.selectedTimeUnit == 0 {
                    HStack(spacing: 10) {
                        ForEach(0..<4) { num in
                            ZStack{
                                RoundedRectangle(cornerRadius: 10.0)
                                .stroke(Color.black)
                                .frame(width: 80, height: 80)
                                
                                Text("\(num)m")
                            }
                        }
                    }
                    .animation(.default)
                }
                //1분 단위
                else if self.selectedTimeUnit == 1 {
                    HStack(spacing: 10) {
                        ForEach(0..<4) { num in
                            ZStack{
                                RoundedRectangle(cornerRadius: 10.0)
                                .stroke(Color.black)
                                .frame(width: 80, height: 80)
                                
                                Text("\(num)m")
                            }
                        }
                    }
                    .animation(.default)
                }
                //5분 단위
                else { //selectedTimeUnit == 2
                    HStack(spacing: 10) {
                        ForEach(0..<4) { num in
                            ZStack{
                                RoundedRectangle(cornerRadius: 10.0)
                                .stroke(Color.black)
                                .frame(width: 80, height: 80)
                                
                                Text("\(num * 5)m")
                            }
                        }
                    }
                    .animation(.default)
                }
                
                
                Spacer()
            }
        }
    }
}

struct TimeSelection_Previews: PreviewProvider {
    static var previews: some View {
        TimeSelection()
    }
}

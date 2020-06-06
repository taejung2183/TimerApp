//
//  TimeSelection.swift
//  TimerApp
//
//  Created by atj on 2020/05/16.
//  Copyright © 2020 atj. All rights reserved.
//

import SwiftUI

struct TimeSelection: View {
    
    @State private var selectedTimeUnit = UserDefaults.standard.integer(forKey: "tag")
    
    @Binding var showTimeSelection: Bool
    
    @Binding var isMainTimer: Bool

    @ObservedObject var timeManager: TimeManager
    
    
    var body: some View {
        GeometryReader { g in
            VStack(spacing:15) {
                //Color(#colorLiteral(red: 0.2794816196, green: 0.9357709289, blue: 0.7412140369, alpha: 1)).edgesIgnoringSafeArea(.all)
                
                // MARK: Unit selection
                Picker(selection: self.$selectedTimeUnit, label: Text("")) {
                    Text("Custom").tag(0)
                    Text("1m").tag(1)
                    Text("5m").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, g.size.width/15)
                
                // MARK: Time selection
                // MARK: Custom time
                if self.selectedTimeUnit == 0 {
                    ScrollView {
                        HStack {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10.0)
                                    .stroke(Color.blue)
                                    .frame(width: 80, height: 80)
                                
                                Text("3s")
                            }
                            .onTapGesture(perform: {
                                UserDefaults.standard.set(self.selectedTimeUnit, forKey: "tag")
                                if self.isMainTimer {
                                    self.timeManager.setMainTime(3)
                                    UserDefaults.standard.set(self.timeManager.selectedMainTime, forKey: "mainTime")
                                    self.isMainTimer = false
                                    self.showTimeSelection = false
                                }
                                else {
                                    self.timeManager.setBreakTime(3)
                                    UserDefaults.standard.set(self.timeManager.selectedBreakTime, forKey: "breakTime")
                                    self.showTimeSelection = false
                                }
                            })
                            
                            ZStack{
                                RoundedRectangle(cornerRadius: 10.0)
                                    .stroke(Color.blue)
                                    .frame(width: 80, height: 80)
                                
                                Text("52m")
                            }
                            .onTapGesture(perform: {
                                UserDefaults.standard.set(self.selectedTimeUnit, forKey: "tag")
                                if self.isMainTimer {
                                    self.timeManager.setMainTime(48)
                                    UserDefaults.standard.set(self.timeManager.selectedMainTime, forKey: "mainTime")
                                    self.isMainTimer = false
                                    self.showTimeSelection = false
                                }
                                else {
                                    self.timeManager.setBreakTime(48)
                                    UserDefaults.standard.set(self.timeManager.selectedBreakTime, forKey: "breakTime")
                                    self.showTimeSelection = false
                                }
                            })
                        }
                    }
                }
                // MARK: 1 minute
                else if self.selectedTimeUnit == 1 {
                    ScrollView {
                        ForEach(0 ..< 10) { row in
                            HStack(spacing: 10) {
                                ForEach(1 ..< 5) { col in
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10.0)
                                            .stroke(Color.blue)
                                            .frame(width: 80, height: 80)
                                        
                                        Text("\(col + (row * 4))m")
                                    }
                                    .onTapGesture(perform: {
                                        UserDefaults.standard.set(self.selectedTimeUnit, forKey: "tag")
                                        if self.isMainTimer {
                                            self.timeManager.setMainTime(60 * (col + (row * 4)))
                                            UserDefaults.standard.set(self.timeManager.selectedMainTime, forKey: "mainTime")
                                            self.isMainTimer = false
                                            self.showTimeSelection = false
                                        }
                                        else {
                                            self.timeManager.setBreakTime(60 * (col + (row * 4)))
                                            UserDefaults.standard.set(self.timeManager.selectedBreakTime, forKey: "breakTime")
                                            self.showTimeSelection = false
                                        }
                                    })
                                }
                            }
                        }
                    }
                }
                // MARK: 5 minute
                else { //selectedTimeUnit == 2
                    ScrollView {
                        ForEach(0 ..< 10) { row in
                            HStack(spacing: 10) {
                                ForEach(1 ..< 5) { col in
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10.0)
                                            .stroke(Color.blue)
                                            .frame(width: 80, height: 80)
                                        
                                        Text("\((col + (row * 4)) * 5)m")
                                    }
                                    .onTapGesture(perform: {
                                        UserDefaults.standard.set(self.selectedTimeUnit, forKey: "tag")
                                        if self.isMainTimer {
                                            self.timeManager.setMainTime(60 * (col + (row * 4)) * 5)
                                            UserDefaults.standard.set(self.timeManager.selectedMainTime, forKey: "mainTime")
                                            self.isMainTimer = false
                                            self.showTimeSelection = false
                                        }
                                        else {
                                            self.timeManager.setBreakTime(60 * (col + (row * 4)) * 5)
                                            UserDefaults.standard.set(self.timeManager.selectedBreakTime, forKey: "breakTime")
                                            self.showTimeSelection = false
                                        }
                                    })
                                }
                            }
                        }
                    }
                }
                
                
                Spacer()
            }
        }
    }
}

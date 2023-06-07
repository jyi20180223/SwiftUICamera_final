//
//  CalendarView.swift
//  SwiftUICamera
//
//  Created by 정윤인 on 2023/06/07.
//  Copyright © 2023 Mohammad Azam. All rights reserved.
//

import Foundation
import SwiftUI
struct CalendarView: View {
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack {
            Text("Select a Date")
                .font(.largeTitle)
                .padding()
            
            DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(DefaultDatePickerStyle())
                .padding()
            
            Button("Done", action: {
                // 여기에 선택한 날짜를 사용한 작업을 수행하면 됩니다.
                print("Selected date: \(selectedDate)")
                SharedValue.shared.dateString = "\(selectedDate)"
            })
            .padding()
        }
    }
}

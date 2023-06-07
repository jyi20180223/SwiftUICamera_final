//
//  CalendarView.swift
//  SwiftUICamera
//
//  Created by 정윤인 on 2023/06/07.
//  Copyright © 2023 Mohammad Azam. All rights reserved.
//

import SwiftUI

struct CalendarView: View {
    @State private var selectedDates = [Date]()
    @Binding var datesCheckedIn: [Date]
    @EnvironmentObject var checkInViewModel: CheckInViewModel
    
    var body: some View {
        let calendar = Calendar.current
        let dates = Date.dates(from: calendar.date(from: DateComponents(year: 2023, month: 1, day: 1))!,
                               to: calendar.date(from: DateComponents(year: 2023, month: 12, day: 31))!)
        
        return VStack(alignment: .leading, spacing: 15) {
            ForEach(dates, id: \.self) { date in
                HStack {
                    Button(action: {
                        if let index = selectedDates.firstIndex(of: date) {
                            selectedDates.remove(at: index)
                        } else {
                            selectedDates.append(date)
                        }
                    }) {
                        Text("\(calendar.component(.day, from: date))")
                            .frame(width: 40, height: 40)
                            .background(selectedDates.contains(date) ? Color.red : Color.clear)
                            .foregroundColor(selectedDates.contains(date) ? Color.white : Color.black)
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                }
            }
        }
        .padding()
    }
}

extension Date {
    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates = [Date]()
        var date = fromDate
        
        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        
        return dates
    }
}

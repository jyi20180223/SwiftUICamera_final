//
//  SharedValue.swift
//  SwiftUICamera
//
//  Created by 정윤인 on 2023/06/06.
//  Copyright © 2023 Mohammad Azam. All rights reserved.
//

import Foundation

class SharedValue {
    static let shared = SharedValue()
    
//    public var isLoggedIn : Bool = false
    
    public var contentView : ContentView?
    
    public var dateString : String = ""

    private init() {
        let currentDate = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // 반환할 날짜 형식 지정
        dateString = dateFormatter.string(from: currentDate)
    } // Prevent creating another instance
}

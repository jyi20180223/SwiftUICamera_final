//
//  CheckInViewModel.swift
//  SwiftUICamera
//
//  Created by 정윤인 on 2023/06/08.
//  Copyright © 2023 Mohammad Azam. All rights reserved.
//

import Foundation
import SwiftUI

class CheckInViewModel: ObservableObject {
    @Published var datesCheckedIn: [Date] = []
}

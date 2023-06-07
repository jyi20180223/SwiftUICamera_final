//
//  LoginView.swift
//  SwiftUICamera
//
//  Created by 정윤인 on 2023/06/07.
//  Copyright © 2023 Mohammad Azam. All rights reserved.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var dateString: String = ""

    @State private var isLoginValid: Bool = false
    
//    @EnvironmentObject var contentView: ContentView
//    private var contentView: ContentView;
    
//    init(contentView : ContentView) {
//            self.contentView = contentView
//        }
    

    func setDate(){
        let currentDate = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // 반환할 날짜 형식 지정
        dateString = dateFormatter.string(from: currentDate)

    }

    var body: some View {
        NavigationView {
            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                TextField("Username", text: $username)
                    .padding()
                    .autocapitalization(.none)
                
                SecureField("Password", text: $password)
                    .padding()
                    .autocapitalization(.none)
                
                Button(action: {
                    
                    print("Login Button Pressed!")
                    // 여기서 로그인 처리 로직을 수행하십시오.
                    isLoginValid = true
                    print("isLoginValid: \(isLoginValid)")
                    //                contentView.setLogginTrue()
                    //                ContentView()
//                    SharedValue.shared.isLoggedIn = true
                    //                ContentView.isLoggedIn = true
                    
                })
                {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.blue)
                        .cornerRadius(15.0)
                }
                
                NavigationLink(destination: ContentView(isLoggedIn: true, usrName : username), isActive: $isLoginValid) {
                    EmptyView()
                }
                .hidden()
            }
        }
        .padding()
    }
}

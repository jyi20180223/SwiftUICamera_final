//
//  ContentView.swift
//  SwiftUICamera
//
//  Created by Mohammad Azam on 2/10/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import SwiftUI


//struct LoginView: View {
//    @State private var username: String = ""
//    @State private var password: String = ""
//    @State private var isLoginValid: Bool = false
////    @EnvironmentObject var contentView: ContentView
////    private var contentView: ContentView;
//
////    init(contentView : ContentView) {
////            self.contentView = contentView
////        }
//
//
//    var body: some View {
//
//        VStack {
//            Text("Login")
//                .font(.largeTitle)
//                .fontWeight(.bold)
//
//            TextField("Username", text: $username)
//                .padding()
//                .autocapitalization(.none)
//
//            SecureField("Password", text: $password)
//                .padding()
//                .autocapitalization(.none)
//
//            Button(action: {
//
//                print("Login Button Pressed!")
//                // 여기서 로그인 처리 로직을 수행하십시오.
//                isLoginValid = true
//                print("isLoginValid: \(isLoginValid)")
////                contentView.setLogginTrue()
////                ContentView()
//                SharedValue.shared.isLoggedIn = true
////                ContentView.isLoggedIn = true
//
//            })
//            {
//                Text("Login")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .padding()
//                    .frame(width: 220, height: 60)
//                    .background(Color.blue)
//                    .cornerRadius(15.0)
//            }
//
//            NavigationLink(destination: ContentView(), isActive: $isLoginValid) {
//                                EmptyView()
//                            }
//                            .hidden()
//        }
//        .padding()
//    }
//}


struct ContentView: View {
     var imageViewModel: ImageViewModel = ImageViewModel()
    
    @State public var isLoggedIn = false

    @State private var showingAlert = false
    @State private var resultText = ""

    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    
//    @State private var isShowingCalendar = false
    
    
    @State private var image: UIImage?
    @State private var label: String = ""
    
    @State public var usrName: String = ""
    
//    @State private var dateString: String = SharedValue.shared.dateString
    
    var body: some View {
        if isLoggedIn {
        NavigationView {
            
            
            VStack {
//                Button(action: {
//                                self.isShowingCalendar = true
//                    dateString = SharedValue.shared.dateString
//                            }) {
//                                Text("Show Calendar")
//                                    .font(.headline)
//                                    .foregroundColor(.white)
//                                    .padding()
//                                    .frame(maxWidth: .infinity)
//                                    .background(Color.blue)
//                                    .cornerRadius(15.0)
//                            }
//                            .sheet(isPresented: $isShowingCalendar) {
//                                            CalendarView()
//                                        }
                
                
                Image(uiImage: image ?? UIImage(named: "placeholder")!)
                    .resizable()
                    .frame(width: 300, height: 400)
                            .cornerRadius(10) // 모서리 둥글게
                            .shadow(radius: 10) // 그림자 추가
                            .padding(.bottom, 30) // 아래 버튼과의 간격
                
                
                Button(action: {
                    self.showSheet = true
                }) {
                    HStack {
                        Spacer()
                        Text("Choose Picture")
                            .foregroundColor(.gray)
                        Spacer()
                    }
                }
                .padding()
                .background(Color.white)
                .font(.headline)
                .cornerRadius(10)
                .shadow(radius: 3)
                .frame(width: 300, height: 50)
                    .actionSheet(isPresented: $showSheet) {
                        ActionSheet(title: Text("Select Photo"), message: Text("Choose"), buttons: [
                            .default(Text("Photo Library")) {
                                self.showImagePicker = true
                                self.sourceType = .photoLibrary
                            },
                            .default(Text("Camera")) {
                                self.showImagePicker = true
                                self.sourceType = .camera
                            },
                            .cancel()
                        ])
                }
              
                
                Button(action: {
                            imageViewModel.classifyImage(newImage : self.image)
                            checkSafe(string: imageViewModel.classificationLabel)
                            self.resultText = label
                            self.showingAlert = true
                        }) {
                            HStack {
                                Spacer()
                                Text("Classify")
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                        }
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Classification Result"), message: Text(resultText), dismissButton: .default(Text("Got it!")))
                        }
                .padding()
                .background(Color.white)
                .font(.headline)
                .cornerRadius(10)
                .shadow(radius: 3)
                .frame(width: 300, height: 50)
                
                
                    .actionSheet(isPresented: $showSheet) {
                        ActionSheet(title: Text("Select Photo"), message: Text("Choose"), buttons: [
                            .default(Text("Photo Library")) {
                                self.showImagePicker = true
                                self.sourceType = .photoLibrary
                            },
                            .default(Text("Camera")) {
                                self.showImagePicker = true
                                self.sourceType = .camera
                            },
                            .cancel()
                        ])
                }
                
                
                
            }
                
                
            .navigationBarTitle(usrName)
            
        }.sheet(isPresented: $showImagePicker) {
            
            ImagePicker(image: self.$image, isShown: self.$showImagePicker, sourceType: self.sourceType)
        }
        } else {
            LoginView()
                }

    }
    
//    func setDate(){
//        let currentDate = Date()
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd" // 반환할 날짜 형식 지정
//        dateString = dateFormatter.string(from: currentDate)
//
//    }
    
    func checkSafe(string: String) {
        let tools = ["helmet", "mask", "vest", "shoe"]
        let limit : Double = 0.5
        var results = string.components(separatedBy: "\n")
        var isExist = ["X", "X", "X","X"]
        var newLabel = ""
        
        
        for result in results {
            
            var startIndex = result.index(result.endIndex, offsetBy: -6)
            var endIndex = result.index(result.endIndex, offsetBy: -1)
            var substring = result[startIndex..<endIndex]
            var trimmedStr = substring.trimmingCharacters(in: .whitespaces)
            
            var resultLimit : Double? = Double(trimmedStr)
            
            if (resultLimit != nil){
                if (resultLimit! < limit) {
                    break
                }
            }
            
            print(result)
            
            
            for index in 0..<tools.count {
                if (result.contains(tools[index])) {
                    isExist[index] = "O"
                }
            }
        }
//        for resultIdx in 0..<20 {
//            for index in 0..<tools.count {
//                if (results[resultIdx].contains(tools[index])) {
//                    isExist[index] = "O"
//                }
//            }
//        }
        
//        for result in results {
//            for index in 0..<tools.count {
//                if (result.contains(tools[index])) {
//                    isExist[index] = "O"
//                }
//            }
////            for tool in tools {
////                if (result.contains(tool)) {
////                    newLabel += result + "\n"
////                    continue loop
////                }
////            }
//        }
        for index in 0..<tools.count {
            newLabel += tools[index] + " : " + isExist[index] + "\n"
        }
            
        
        label = newLabel
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
                    .environmentObject(ImageViewModel())
    }
}

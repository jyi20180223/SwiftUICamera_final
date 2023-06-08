//
//  ContentView.swift
//  SwiftUICamera
//
//  Created by Mohammad Azam on 2/10/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import SwiftUI





struct ContentView: View {
     var imageViewModel: ImageViewModel = ImageViewModel()
    
    @State private var isShowingCalendar = false
    @State public var isLoggedIn = false

    @State private var showingAlert = false
    @State private var resultText = ""

    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    

    
    
    @State private var image: UIImage?
    @State private var label: String = ""
    
    @State public var usrName: String = ""
    
    @State private var showingCalendar = false
    @ObservedObject var checkInViewModel = CheckInViewModel()

    
    var body: some View {
        if isLoggedIn {
        NavigationView {
            
            
            VStack {

               
                
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
                
                
                    
                
                
                
            }
            .sheet(isPresented: $showImagePicker, content: {
                ImagePicker(image: self.$image, isShown: self.$showImagePicker, sourceType: self.sourceType)
            })
                
                
            .navigationBarItems(trailing: Button(action: {
                    showingCalendar = true
                }) {
                    Image(systemName: "calendar")
                })
                .sheet(isPresented: $showingCalendar) {
                    CalendarView(datesCheckedIn: $checkInViewModel.datesCheckedIn)
                }
            
            ImagePicker(image: self.$image, isShown: self.$showImagePicker, sourceType: self.sourceType)
        }
        } else {
            LoginView()
                }

    }
    

    
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

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
    
    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    
    
    @State private var image: UIImage?
    @State private var label: String = ""
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Image(uiImage: image ?? UIImage(named: "placeholder")!)
                    .resizable()
                    .frame(width: 300, height: 300)
                
                Button("Choose Picture") {
                    self.showSheet = true
                }.padding()
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
              
                
                Button("Classify") {
                    imageViewModel.classifyImage(newImage : self.image)
                    checkSafe(string: imageViewModel.classificationLabel)
                                }
                                .padding()
                
                
                Text(
                    label
                )
                    .padding()
            }
                
                
            .navigationBarTitle("Safe Look Book")
            
        }.sheet(isPresented: $showImagePicker) {
            
            ImagePicker(image: self.$image, isShown: self.$showImagePicker, sourceType: self.sourceType)
//            ImagePicker(image: self.$imageViewModel.image, isShown: self.$showImagePicker, sourceType: self.sourceType)
//                .environmentObject(self.imageViewModel)
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

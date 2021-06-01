//
//  ContentView.swift
//  RememberNames
//
//  Created by Brandon Knox on 5/29/21.
//

import SwiftUI

struct photoData {
    var imageName: String
    var personName: String
}

struct ContentView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var showingEditScreen = false
    @State private var imageName = ""
    @State private var nameList = [NameWithImage]()
    
    let context = CIContext()
    
    var body: some View {
        return NavigationView {
            VStack {
                Text(imageName)
                    .fontWeight(.bold)
                    .font(.headline)
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                        
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                NavigationLink("Name List", destination: ListView(nameList: $nameList))
            }
            .navigationBarTitle("Remember Me")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            // add prompt to name picture
            .sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
                EditView(imageName: $imageName, nameList: $nameList)
            }
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func saveData() {
        // save code here
        // save image to user folder
        nameList.append(NameWithImage(name: imageName, fileName: "\(imageName).jpg"))
        saveImageFile()
    }
        
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        showingEditScreen = true
    }
    
    func saveImageFile() {
        let filename = getDocumentsDirectory().appendingPathComponent("\(imageName).jpg")
        if let jpegData = inputImage!.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

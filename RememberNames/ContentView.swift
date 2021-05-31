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
//    @State private var imageName = ""
    
    let context = CIContext()
    
    var body: some View {
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    if image != nil {
                        
//                        Text(imageName)
                        image?
                            .resizable()
                            .scaledToFit()
                        // add prompt to name picture
                        // save image to user folder
                        let filename = getDocumentsDirectory().appendingPathComponent("photo")
//                        if let jpegData = inputImage!.jpegData(compressionQuality: 0.8) {
//                            try? jpegData.write(to: filename, options: [.atomicWrite, .completeFileProtection])
//                        }
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
            }
            .navigationBarTitle("Remember Me")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            .sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
//                if self.imageName == "" {
                    EditView()
//                }
            }
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func saveData() {
        // save code here
    }
        
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        showingEditScreen = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  RememberNames
//
//  Created by Brandon Knox on 5/29/21.
//

import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var showingEditScreen = false
    @State private var imageName = ""
    
    let context = CIContext()
    
    var body: some View {
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                        // add prompt to name picture
                        // save image to user folder
//                        if let jpegData = yourUIImage.jpegData(compressionQuality: 0.8) {
//                            try? jpegData.write(to: yourURL, options: [.atomicWrite, .completeFileProtection])
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
                if self.imageName == "" {
                    EditView()
                }
            }
        }
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

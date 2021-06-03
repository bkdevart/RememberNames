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
    @State private var nameList = [NameWithImage]()
    
    var body: some View {
        return NavigationView {
            VStack {
                List(nameList.sorted(), id: \.name) { name in
                    NavigationLink(destination: ImageView(name: name.name, fileName: name.fileName)) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(name.name)
                                    .font(.headline)
                                // put image here
                                Text(name.fileName)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                .onAppear(perform: loadData)
                Button("Add photo", action: {
                        showingImagePicker = true
                })
            }
            .navigationBarTitle("Remember Me")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            // prompt to name picture
            .sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
                EditView(imageName: $imageName, nameList: $nameList)
            }
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
        
    func loadData() {
        let filename = getDocumentsDirectory().appendingPathComponent("ImageNames")

        do {
            let data = try Data(contentsOf: filename)
            nameList = try JSONDecoder().decode([NameWithImage].self, from: data)
        } catch {
            print("Unable to load saved data.")
        }
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
    
    func saveData() {
        // save image to user folder
        nameList.append(NameWithImage(name: imageName, fileName: "\(imageName).jpg"))
        saveImageFile()
        // save JSON with image names
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("ImageNames")
            let data = try JSONEncoder().encode(self.nameList)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

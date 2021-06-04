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
    
    let locationFetcher = LocationFetcher()
    
    var body: some View {
        return NavigationView {
            VStack {
                List(nameList.sorted(), id: \.name) { name in
                    NavigationLink(destination: ImageView(name: name.name, fileName: name.fileName, latitude: name.latitude, longitude: name.longitude)) {
                        ListView(name: name.name, fileName: name.fileName)
                    }
                }
                Button("Add photo", action: {
                    self.locationFetcher.start()
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
            .onAppear(perform: loadData)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
        
    func loadData() {
        if nameList.isEmpty {
            let filename = getDocumentsDirectory().appendingPathComponent("ImageNames")
            
            do {
                let data = try Data(contentsOf: filename)
                nameList = try JSONDecoder().decode([NameWithImage].self, from: data)
            } catch {
                print("Unable to load saved data.")
            }
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
    
    func saveJSONFile() {
        // TODO grab user location and save coordinates into file
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("ImageNames")
            let data = try JSONEncoder().encode(self.nameList)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func saveData() {
        // save image to user folder
        // update with lattitude/longitude
        if let location = self.locationFetcher.lastKnownLocation {
            print("Your location is \(location)")
            nameList.append(NameWithImage(name: imageName, fileName: "\(imageName).jpg",
                                          longitude: location.longitude, latitude: location.latitude))
        } else {
            print("Your location is unknown")
        }
        
        saveImageFile()
        // save JSON with image names
        saveJSONFile()
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

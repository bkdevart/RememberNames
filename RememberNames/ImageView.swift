//
//  DetailView.swift
//  RememberNames
//
//  Created by Brandon Knox on 5/31/21.
//

import SwiftUI

struct ImageView: View {
    private var name = ""
    private var fileName = ""
    @State private var image: Image?
    
    var body: some View {
        Text(name)
//        let imageFile = getDocumentsDirectory().appendingPathComponent("\(self.fileName).jpg")
        // figure out how to read in file from URL
        self.image
    }
    
    init(name: String, fileName: String) {
        self.name = name
        self.fileName = fileName
//        guard let inputImage = Image(uiImage: loadImage(fileName: fileName)) else { return }
//        self.image = Image(uiImage: loadImage(fileName: fileName))
    }
    
//    func getDocumentsDirectory() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        let imagePath = paths[0].appendingPathComponent("\(self.fileName).jpg")
//        let imageData = try Data(contentsOf: imagePath. { }
////        let imageData = try Data(contentsOf: fileURL)
//        return UIImage(data: imageData)
//    }
    
    func loadImage(fileName: String) -> UIImage? {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = paths[0].appendingPathComponent("\(self.fileName).jpg")
//        let fileURL = documentsUrl.appendingPathComponent(fileName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return nil
    }
    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(name: "Bob", fileName: "Bob.jpg")
    }
}

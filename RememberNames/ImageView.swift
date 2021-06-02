//
//  DetailView.swift
//  RememberNames
//
//  Created by Brandon Knox on 5/31/21.
//

import SwiftUI

struct ImageView: View {
    @State private var image: Image?
    private var name = ""
    private var fileName = ""
    
    var body: some View {
        VStack {
            Text(name)
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }
    
    init(name: String, fileName: String) {
        self.name = name
        self.fileName = fileName
    }
    
    func getImagePath() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = paths[0].appendingPathComponent("\(self.fileName)")
        return fileURL
    }
    
    func loadImage() {
        do {
            let data = try Data(contentsOf: getImagePath(), options: .alwaysMapped)
            let sourceImage = UIImage(data: data) // ?? UIImage(systemName: "star")
            if let sourceImage = sourceImage {
                image = Image(uiImage: sourceImage)
            } else {
                image = Image(systemName: "figure.walk")
            }
        } catch {
            print("Image did not load")
        }
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(name: "Bob", fileName: "Bob.jpg")
    }
}

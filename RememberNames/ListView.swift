//
//  ListView.swift
//  RememberNames
//
//  Created by Brandon Knox on 6/2/21.
//

import SwiftUI

struct ListView: View {
    @State private var image: Image?
    private var name = ""
    private var fileName = ""
    
    var body: some View {
        HStack {
            Text(name)
            Spacer()
            image?
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
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
            let sourceImage = UIImage(data: data)
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

//struct ListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListView()
//    }
//}

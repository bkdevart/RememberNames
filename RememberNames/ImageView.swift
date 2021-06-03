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
    let locationFetcher = LocationFetcher()
    
    var body: some View {
        VStack {
            Text(name)
            image?
                .resizable()
                .scaledToFit()
//            MapView()
            Spacer()
            Button("Start Tracking Location") {
                self.locationFetcher.start()
            }
            Button("Read Location") {
                if let location = self.locationFetcher.lastKnownLocation {
                    print("Your location is \(location)")
                } else {
                    print("Your location is unknown")
                }
            }
            
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

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(name: "Bob", fileName: "Bob.jpg")
    }
}

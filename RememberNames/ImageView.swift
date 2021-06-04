//
//  DetailView.swift
//  RememberNames
//
//  Created by Brandon Knox on 5/31/21.
//

import SwiftUI
import MapKit

struct ImageView: View {
    @State private var image: Image?
    private var name = ""
    private var fileName = ""
    @State var centerCoordinate: CLLocationCoordinate2D
    @State var selectedPlace: MKPointAnnotation?
    @State var showingPlaceDetails: Bool
    @State var annotations: [CodableMKPointAnnotation]
    
    var body: some View {
        VStack {
            Text(name)
            image?
                .resizable()
                .scaledToFit()
            Spacer()
            MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, annotations: annotations)
        }
        .onAppear(perform: loadImage)
    }
    
    init(name: String, fileName: String, latitude: Double, longitude: Double) {
        self.name = name
        self.fileName = fileName
        self.centerCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let selectedPlace = CodableMKPointAnnotation()
        selectedPlace.title = self.name
        selectedPlace.subtitle = "Remember me!"
        selectedPlace.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.selectedPlace = selectedPlace
        self.showingPlaceDetails = true
        self.annotations = [selectedPlace]
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
        ImageView(name: "Bob", fileName: "Bob.jpg", latitude: 0.0, longitude: 0.0)
    }
}

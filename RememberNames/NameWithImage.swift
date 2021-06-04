//
//  NameWithImage.swift
//  RememberNames
//
//  Created by Brandon Knox on 5/31/21.
//

import Foundation
import MapKit

struct NameWithImage: Codable, Comparable {
    var name: String
    var fileName: String
    var longitude: Double
    var latitude: Double
    
    static func < (lhs: NameWithImage, rhs: NameWithImage) -> Bool {
        lhs.name < rhs.name
    }
}

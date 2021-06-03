//
//  NameWithImage.swift
//  RememberNames
//
//  Created by Brandon Knox on 5/31/21.
//

import Foundation

struct NameWithImage: Codable, Comparable {
    var name: String
    var fileName: String
    
    static func < (lhs: NameWithImage, rhs: NameWithImage) -> Bool {
        lhs.name < rhs.name
    }
}

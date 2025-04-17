//
//  Face.swift
//  Names and Faces
//
//  Created by Bon Champion on 4/10/25.
//

import Foundation
import UIKit

struct Face: Codable, Identifiable {
    var id: UUID
    var name: String
    var photo: Data
    var latitude: Double
    var longitude: Double
    
    init(id: UUID = UUID(), name: String, photo: Data, latitude: Double, longitude: Double) {
        self.id = id
        self.name = name
        self.photo = photo
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(id: UUID = UUID(), name: String, image: UIImage, latitude: Double, longitude: Double) {
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        // Compress the image data
        if let compressedData = image.jpegData(compressionQuality: 0.7) {
            self.photo = compressedData
        } else {
            self.photo = image.pngData() ?? Data()
        }
    }
    
    #if DEBUG
    static let example = Face(id: UUID(), name: "Bon C", photo: UIImage(named: "bon")!.pngData()!, latitude: 0.0, longitude: 0.0)
    #endif
}

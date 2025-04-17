//
//  ContentView-ViewModel.swift
//  Names and Faces
//
//  Created by Bon Champion on 4/10/25.
//

import CoreImage
import PhotosUI
import Foundation
import SwiftUI

extension ContentView {
    @Observable
    class ViewModel {
        var image: UIImage?
        var selectedItem: PhotosPickerItem?
        var showingEditSheet = false
        var faceStore: FaceStore
        
        init(faceStore: FaceStore) {
            self.faceStore = faceStore
        }
        
        func loadImage() {
            Task {
                guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
                guard let inputImage = UIImage(data: imageData) else { return }
                
                image = inputImage
                showingEditSheet = true
            }
        }
    }
}

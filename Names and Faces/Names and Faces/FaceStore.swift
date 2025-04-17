//
//  FaceStore.swift
//  Names and Faces
//
//  Created by Bon Champion on 4/11/25.
//

import Foundation
import SwiftUI

@Observable
class FaceStore {
    var faces: [Face] = []
    private let savePath = URL.documentsDirectory.appending(path: "SavedFaces")
    var isLoading = false
    
    init() {
        loadFaces()
    }
    
    func loadFaces() {
        isLoading = true
        do {
            let data = try Data(contentsOf: savePath)
            faces = try JSONDecoder().decode([Face].self, from: data)
            print("Successfully loaded \(faces.count) faces from \(savePath.path)")
        } catch {
            print("Error loading faces: \(error.localizedDescription)")
            faces = []
        }
        isLoading = false
    }
    
    func saveFaces() {
        isLoading = true
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(faces)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            print("Successfully saved \(faces.count) faces to \(savePath.path)")
        } catch {
            print("Unable to save data: \(error.localizedDescription)")
            print("Error details: \(error)")
        }
        isLoading = false
    }
    
    func addFace(_ face: Face) {
        faces.append(face)
        saveFaces()
    }
    
    func updateFace(_ face: Face) {
        if let index = faces.firstIndex(where: { $0.id == face.id }) {
            faces[index] = face
            saveFaces()
        }
    }
    
    func updateFaceName(id: UUID, newName: String) {
        if let index = faces.firstIndex(where: { $0.id == id }) {
            faces[index].name = newName
            saveFaces()
        }
    }
    
    func deleteFace(_ face: Face) {
        faces.removeAll { $0.id == face.id }
        saveFaces()
    }
} 
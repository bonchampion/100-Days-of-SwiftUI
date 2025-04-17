//
//  FileManager-Extension.swift
//  Names and Faces
//
//  Created by Bon Champion on 4/10/25.
//

import Foundation

let savePath = URL.documentsDirectory.appending(path: "SavedFaces")

extension FileManager {
    func write(fileName: String, contents: String) {
        let data = Data(contents.utf8)
        let url = URL.documentsDirectory.appending(path: fileName)
        
        do {
            try data.write(to: url, options: [.atomic, .completeFileProtection])
            let input = try String(contentsOf: url, encoding: .utf8)
            print(input)
        } catch {
            print(error.localizedDescription)
        }
    }
}

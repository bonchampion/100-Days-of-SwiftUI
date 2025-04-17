//
//  FileManager-Extension.swift
//  Bucket List
//
//  Created by Bon Champion on 2/27/25.
//

import Foundation

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

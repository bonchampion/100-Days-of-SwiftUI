//
//  ContentView.swift
//  Names and Faces
//
//  Created by Bon Champion on 4/9/25.
//

import CoreImage
import PhotosUI
import SwiftUI

struct ContentView: View {
    @State private var viewModel: ViewModel
    
    init() {
        let store = FaceStore()
        _viewModel = State(initialValue: ViewModel(faceStore: store))
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.faceStore.faces) { face in
                    NavigationLink {
                        EditView(face: face, faceStore: viewModel.faceStore)
                    } label: {
                        HStack {
                            if let image = UIImage(data: face.photo) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            }
                            Text(face.name)
                        }
                    }
                }
            }
            .toolbar {
                PhotosPicker(selection: $viewModel.selectedItem) {
                    Text("Add a face")
                }
                .onChange(of: viewModel.selectedItem, viewModel.loadImage)
            }
            .sheet(isPresented: $viewModel.showingEditSheet) {
                AddFaceView(image: viewModel.image, faceStore: viewModel.faceStore)
            }
        }
    }
    
    
}

#Preview {
    ContentView()
}

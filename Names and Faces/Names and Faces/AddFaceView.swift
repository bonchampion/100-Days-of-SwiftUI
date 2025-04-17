//
//  AddFaceView.swift
//  Names and Faces
//
//  Created by Bon Champion on 4/11/25.
//

import SwiftUI

struct AddFaceView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: AddFaceViewModel
    
    init(image: UIImage?, faceStore: FaceStore) {
        _viewModel = StateObject(wrappedValue: AddFaceViewModel(image: image!, faceStore: faceStore))
    }
    
    var body: some View {
        Form {
            Section("New Face") {
                Image(uiImage: viewModel.image)
                    .resizable()
                    .scaledToFit()
                
                TextField("Name", text: $viewModel.name)
                Button {
                    Task {
                        await viewModel.saveFace()
                        dismiss()
                    }
                } label: {
                    HStack {
                        if viewModel.isLoading {
                            ProgressView()
                                .controlSize(.small)
                                .tint(.white)
                        }
                        Text(viewModel.isLoading ? "Saving..." : "Save")
                    }
                }
                .disabled(viewModel.isSaveDisabled)
            }
            .onAppear {
                viewModel.startLocationFetching()
            }
        }
    }
}

#Preview {
    AddFaceView(image: UIImage(systemName: "person.fill")!, faceStore: FaceStore())
}

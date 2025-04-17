//
//  EditView.swift
//  Names and Faces
//
//  Created by Bon Champion on 4/10/25.
//

import SwiftUI
import MapKit

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: EditFaceViewModel
    
    init(face: Face, faceStore: FaceStore) {
        _viewModel = StateObject(wrappedValue: EditFaceViewModel(face: face, faceStore: faceStore))
    }
    
    var body: some View {
        Form {
            Section {
                Image(uiImage: viewModel.image!)
                    .resizable()
                    .scaledToFit()
            }
            
            Section {
                Map(initialPosition: viewModel.startPosition, interactionModes: []) {
                    Annotation("", coordinate: CLLocationCoordinate2D(latitude: viewModel.face.latitude, longitude: viewModel.face.longitude)) {
                        Text("😊")
                            .font(.title)
                    }
                }
                .frame(height: 200)
            }
            
            Section("Edit Name") {
                TextField("Name", text: $viewModel.name)
                
                Button {
                    Task {
                        await viewModel.saveChanges()
                        dismiss()
                    }
                } label: {
                    HStack {
                        if viewModel.isLoading {
                            ProgressView()
                                .controlSize(.small)
                                .tint(.white)
                        }
                        Text(viewModel.isLoading ? "Saving..." : "Save Changes")
                    }
                }
                .disabled(viewModel.isSaveDisabled)
            }
            
            Section {
                Button(role: .destructive) {
                    viewModel.showingDeleteConfirmation = true
                } label: {
                    HStack {
                        Image(systemName: "trash")
                        Text("Delete Face")
                    }
                }
                .disabled(viewModel.isLoading)
            }
        }
        .navigationTitle("Edit Face")
        .alert("Delete Face", isPresented: $viewModel.showingDeleteConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                Task {
                    await viewModel.deleteFace()
                    dismiss()
                }
            }
        } message: {
            Text("Are you sure you want to delete this face? This action cannot be undone.")
        }
    }
}

#Preview {
    NavigationStack {
        EditView(face: .example, faceStore: FaceStore())
    }
}

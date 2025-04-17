import SwiftUI
import MapKit

@MainActor
class EditFaceViewModel: ObservableObject {
    @Published var name: String
    @Published var showingDeleteConfirmation = false
    @Published var isLoading = false
    
    let face: Face
    let faceStore: FaceStore
    let startPosition: MapCameraPosition
    
    init(face: Face, faceStore: FaceStore) {
        self.face = face
        self.faceStore = faceStore
        self.name = face.name
        self.startPosition = MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: face.latitude, longitude: face.longitude),
                span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
            )
        )
    }
    
    var image: UIImage? {
        UIImage(data: face.photo)
    }
    
    var isSaveDisabled: Bool {
        name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isLoading
    }
    
    func saveChanges() async {
        isLoading = true
        defer { isLoading = false }
        
        faceStore.updateFaceName(id: face.id, newName: name)
    }
    
    func deleteFace() async {
        isLoading = true
        defer { isLoading = false }
        
        faceStore.deleteFace(face)
    }
} 
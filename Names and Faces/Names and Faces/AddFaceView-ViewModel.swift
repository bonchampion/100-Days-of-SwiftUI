import SwiftUI
import CoreLocation

@MainActor
class AddFaceViewModel: ObservableObject {
    @Published var name = ""
    @Published var isLoading = false
    
    let image: UIImage
    let faceStore: FaceStore
    private let locationFetcher = LocationFetcher()
    
    init(image: UIImage, faceStore: FaceStore) {
        self.image = image
        self.faceStore = faceStore
    }
    
    var isSaveDisabled: Bool {
        name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isLoading
    }
    
    func startLocationFetching() {
        locationFetcher.start()
    }
    
    func saveFace() async {
        isLoading = true
        defer { isLoading = false }
        
        var lat = 0.0
        var long = 0.0
        if let location = locationFetcher.lastKnownLocation {
            lat = location.latitude
            long = location.longitude
        }
        
        let newFace = Face(name: name, image: image, latitude: lat, longitude: long)
        faceStore.addFace(newFace)
    }
} 
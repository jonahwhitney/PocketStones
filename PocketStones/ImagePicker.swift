//
//  ImagePickerVIew.swift
//  PocketStones
//
//  Created by Jonah Whitney on 10/23/24.
//

import UIKit
import SwiftUI

// This struct acts as a bridge between SwiftUI and the UIKit's UIImagePickerController.
struct ImagePicker: UIViewControllerRepresentable {
    
    // The Coordinator class handles communication between the UIImagePickerController and SwiftUI.
    // It conforms to both UIImagePickerControllerDelegate and UINavigationControllerDelegate.
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker // Reference to the parent ImagePicker struct
        
        // The initializer for the Coordinator. It takes a reference to the parent
        // ImagePicker struct so it can modify its properties.
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        // This method is called when the user finishes picking a media (in this case, an image).
        // The info parameter contains metadata about the selected image.
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // Check if an image was selected and cast it to UIImage.
            if let image = info[.originalImage] as? UIImage {
                // Convert the UIImage into JPEG data (Data type) and set it to the parent's image binding.
                parent.image = image.jpegData(compressionQuality: 1.0)
            }
            // Dismiss the image picker once an image is selected.
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    // This property allows SwiftUI to control the presentation of the view (e.g., dismiss it).
    @Environment(\.presentationMode) var presentationMode

    // A binding to pass the selected image data back to the parent view. This updates the image in the parent view when the user selects an image.
    @Binding var image: Data?
    
    // Defines whether the source is the camera or the photo library.
    var sourceType: UIImagePickerController.SourceType

    // Creates the Coordinator instance that will manage communication between the view controller and SwiftUI.
    func makeCoordinator() -> Coordinator {
        Coordinator(self) // Pass a reference of self (the ImagePicker struct) to the Coordinator.
    }

    // This method creates the UIImagePickerController, which is a UIKit view controller for picking images from the camera or photo library.
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController() // Create a UIImagePickerController instance.
        picker.delegate = context.coordinator  // Set the coordinator as the delegate to handle events.
        picker.sourceType = sourceType // Set whether the picker will use the camera or the photo library.
        return picker // Return the configured picker.
    }

    // This method is required but isn't used in this case because we don't need to update the UIImagePickerController once it's created.
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}


//
//  EditRockView.swift
//  PocketStones
//
//  Created by Jonah Whitney on 9/16/24.
//
import PhotosUI
import SwiftData
import SwiftUI

struct EditRockView: View {
    // Bindable variable for the rock that is created. Allows the user's input to bind to the new rock object.
    @Bindable var rock: Rock
    // Var for the photo that is selected
    @State private var selectedItem: PhotosPickerItem?
    // State vars for handling camera and photo library actions
    @State private var showImagePicker = false
    @State private var showPhotoLibrary = false
    @State private var useCamera = false
    
    var body: some View {
        // This formats the textField for purchase price so it doesn't display the default value of 0
        let formatter: NumberFormatter = {
            let numFormatter = NumberFormatter()
            numFormatter.zeroSymbol = ""
            return numFormatter
        }()
        
        ZStack {
            // Sets background color
            Color.cyan.opacity(0.1)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Sets the color of the header section's background
                Rectangle()
                    .frame(height: 0)
                    .background(Color.indigo.opacity(0.4))
                
                List {
                    // Used List to create a form because there isn't a good way to override default form styling
                    Section {
                        // If imageData is created then it will be bound to rock's photo property and a UIImage will be created that will display the rock's photo.
                        if let imageData = rock.photo, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                            // This makes the image resize relative to the parent container it is in. In this case, that is the list section that holds the PhotosPicker and the image
                                .containerRelativeFrame(.horizontal, alignment: .center) { size, axis in
                                    size * 0.5
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        
                        // Button to select a photo or use the camera
                        Button {
                            showPhotoPickerActionSheet() // Show options to select photo source
                        } label: {
                            Label("Select Photo", systemImage: "photo")
                        }
                    }
                    
                    // Section header with a string to create space between the sections.
                    Section(header: Text("")) {
                        HStack {
                            Text("Favorite")
                            Spacer()
                            FavoriteButton(isSet: $rock.isFavorite)
                        }
                    }
                    
                    // Section header with a string to create space between the sections.
                    Section(header: Text("")) {
                        TextField("Name", text: $rock.name)
                            .textContentType(.name)
                        TextField("Shape", text: $rock.shape)
                        TextField("Purchase Price (Rounds to nearest $)", value: $rock.purchasePrice, formatter: formatter)
                    }
                    
                    // Section header with a string to create space between the sections.
                    Section(header: Text("Details")) {
                        TextField("Details", text: $rock.details, axis: .vertical)
                    }
                }
                .navigationTitle("Rock Info")
                .navigationBarTitleDisplayMode(.inline)
                .listStyle(PlainListStyle()) // Optional: Removes default list styling
                .background(Color.clear) // Background for the list itself to make it stand out
                .padding() // Padding to ensure the list is centered
                .onChange(of: selectedItem, loadPhoto) // Calls loadPhoto when image is changed
            }
        }
        // Action sheet for selecting the photo source (camera or library)
        .actionSheet(isPresented: $showImagePicker) {
            ActionSheet(
                title: Text("Select Photo"),
                message: Text("Choose your photo source"),
                buttons: [
                    .default(Text("Camera")) {
                        useCamera = true
                        showPhotoLibrary = true
                    },
                    .default(Text("Photo Library")) {
                        useCamera = false
                        showPhotoLibrary = true
                    },
                    .cancel()
                ]
            )
        }
        // Sheet to display either the camera or the photo library based on user choice
        .sheet(isPresented: $showPhotoLibrary) {
            if useCamera {
                ImagePicker(image: $rock.photo, sourceType: .camera)
            } else {
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    Label("Select Photo", systemImage: "photo")
                }
            }
        }
    }
    
    // Function to show the action sheet
    private func showPhotoPickerActionSheet() {
        showImagePicker = true
    }
    
    // Task works asynchronously in the background. It loads the photo when a photo is selected
    func loadPhoto() {
        Task { @MainActor in
            rock.photo = try await selectedItem?.loadTransferable(type: Data.self)
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return EditRockView(rock: previewer.rock)
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}

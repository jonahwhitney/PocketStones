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
    // bindable variable for the rock that is created. allows the user's input to bind to the new rock object.
    @Bindable var rock: Rock
    // var for the photo that is selected
    @State private var selectedItem: PhotosPickerItem?
    
    var body: some View {
        
        // this formats the textField for purchase price so it doesn't display the default value of 0
        let formatter: NumberFormatter = {
            let numFormatter = NumberFormatter()
            numFormatter.zeroSymbol = ""
            return numFormatter
        }()
        
        ZStack {
            // sets background color
            Color.cyan.opacity(0.1)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // sets the color of the header section's background
                Rectangle()
                    .frame(height: 0)
                    .background(Color.indigo.opacity(0.4))
                
                // used List to create a form because there isn't a good way to override default form styling
                List {
                    
                    Section {
                        
                        // if imageData is created then it will be beound to rock's photo property and a UIImage will be created that will display the rocks photo.
                        if let imageData = rock.photo, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                            // this makes the image resize relative to the parent container it is in. In this case that is the list section that holds the PhotosPicker and the image.
                                .containerRelativeFrame(.horizontal, alignment: .center) { size, axis in
                                    size * 0.5
                                }
                                .frame(maxWidth: .infinity, alignment: .center) // Centers the image

                        }

                        PhotosPicker(selection: $selectedItem, matching: .images) {
                            Label("Select Photo", systemImage: "photo")
                        }
                    }
                    
                    Section(header: Text("")) {
                        HStack {
                            Text("Favorite")
                            
                            Spacer()
                            
                            FavoriteButton(isSet: $rock.isFavorite)
                        }
                    }
                    
                    Section(header: Text("")) {
                        TextField("Name", text: $rock.name)
                            .textContentType(.name)
                        
                        TextField("Shape", text: $rock.shape)
                        
                        TextField("Purchase Price (Rounds to nearest $)", value: $rock.purchasePrice, formatter: formatter)
                    }
                    
                    // section header with string so it creates space between the sections.
                    Section(header: Text("Details")) {
                        
                        TextField("Details", text: $rock.details, axis: .vertical)
                    }
                }
                .navigationTitle("Rock Info")
                .navigationBarTitleDisplayMode(.inline)
                .listStyle(PlainListStyle()) // Optional: Removes default list styling
                .background(Color.clear) // Background for the list itself to make it stand out
                .padding() // Padding to ensure the list is centered
                .onChange(of: selectedItem, loadPhoto) // calls loadPhoto when image is changed
            }
        }
    }
    
    func loadPhoto() {
        // task works asychronously in the background. It loads the photo when a photo is seleced.
        Task { @MainActor in
            rock.photo = try await
            selectedItem?.loadTransferable(type: Data.self)
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

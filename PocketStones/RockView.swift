//
//  RockView.swift
//  PocketStones
//
//  Created by Jonah Whitney on 9/25/24.
//
import SwiftData
import SwiftUI

struct RockView: View {
    @Environment(\.modelContext) var modelContext
    @Query var rocks: [Rock]
    
    var body: some View {
        ZStack {
            
            // list that displays rocks stored in database
            List {
                ForEach(rocks) { rock in
                    NavigationLink(value: rock) {
                        HStack {
                            VStack (alignment: .leading) {
                                Text(rock.name)
                                Text(rock.shape)
                                Text("$\(rock.purchasePrice, specifier: "%.2f")")
                            }
                            
                            Spacer()
                            
                            // creates constant for imageDate that is bound to rock.photo, if the imageData is there then it creates a UIImage with the imageData.
                            if let imageData = rock.photo, let uiImage = UIImage(data: imageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                                // this makes the image resize relative to the parent container it is in. In this case that is the HStack containing the elements in the list.
                                    .containerRelativeFrame(.horizontal) { size, axis in
                                        size * 0.2
                                    }
                            }
                        }
                        
                    }
                }
                .onDelete(perform: deleteRock)
            }
            .listStyle(PlainListStyle()) // Optional: Removes default list styling
            .background(Color.clear) // Background for the list itself to make it stand out
            .padding() // Padding to ensure the list is centered
        }
    }
    
    
    // initializes search string as empty, if searchString is empty the list returns all entries. Otherwise it displays entries that match the search parameters. Accepts sortOrder array to apply to query.
    init(searchString: String = "", sortOrder: [SortDescriptor<Rock>] = []) {
        _rocks = Query(filter: #Predicate { rock in
            if searchString.isEmpty {
                true
            } else {
                rock.name.localizedStandardContains(searchString)
                || rock.shape.localizedStandardContains(searchString)
                || rock.details.localizedStandardContains(searchString)
            }
        }, sort: sortOrder)
    }
    
    // delete rock from database
    func deleteRock(at offsets: IndexSet) {
        for offset in offsets {
            let rock = rocks[offset]
            modelContext.delete(rock)
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return ContentView()
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}

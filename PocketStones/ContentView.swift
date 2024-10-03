//
//  ContentView.swift
//  PocketStones
//
//  Created by Jonah Whitney on 9/16/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    @State private var path = NavigationPath()
    
    // var to store the state of sort order
    @State private var sortOrder = [SortDescriptor(\Rock.name)]
    // initiates search text as empty string
    @State private var searchText = ""
    
    var body: some View {
        
        NavigationStack(path: $path) {
            ZStack {
                // sets background color
                Color.cyan.opacity(0.1)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // sets background color to header section
                    Rectangle()
                        .frame(height: 0)
                        .background(Color.indigo.opacity(0.4))
                    
                    // calls in list from RockView, passes in sortOrder for sort
                    RockView(searchString: searchText, sortOrder: sortOrder)
                        .navigationTitle("Pocket Stones")
                        .navigationDestination(for: Rock.self) { rock in
                            EditRockView(rock: rock)
                            
                        }
                        .toolbar {
                            // menu for calling sorting method
                            Menu {
                                // picker that appears on tapping menu button
                                Picker("Sort", selection: $sortOrder) {
                                    // sorts alphabetically
                                    Text("Alphabetical")
                                        .tag([SortDescriptor(\Rock.name)])
                                    
                                    // sorts reverse alphabetically
                                    Text("Reverse Alphabetical")
                                        .tag([SortDescriptor(\Rock.name, order: .reverse)])
                                    
                                    // sorts by purchase price - high to low
                                    Text("Purchase Price (Low to high)")
                                        .tag([SortDescriptor(\Rock.purchasePrice)])
                                    
                                    // sorts by purchase price - low to high
                                    Text("Purchase Price (High to low")
                                        .tag([SortDescriptor(\Rock.purchasePrice, order: .reverse)])
                                }
                            } label: {
                                Image(systemName: "arrow.up.arrow.down")
                                // overrides menu button's default style
                                    .font(.system(size: 16))
                                    .fontWeight(.black)
                                    .foregroundColor(.black)
                            }
                            
                            
                            // button for adding rocks the database
                            Button("Add Rock", systemImage: "plus" ,action: addRock)
                                .buttonStyle(PlainButtonStyle()) // overrides default button styling
                                .fontWeight(.black)
                            
                        }
                        // creates searchbar
                        .searchable(text: $searchText)
                }
            }
        }
    }
    
    // method that creates a new rock, inserts it into the modelContext, and navigates to EditRockView
    func addRock () {
        
        // create new rock
        let rock = Rock(name: "", shape: "", details: "", purchasePrice: 0)
        // insert new rock into the modelContext
        modelContext.insert(rock)
        // navigate to editing screen
        path.append(rock)
        
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

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
    @State private var path = [Rock]()
    
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
                    
                    // calls in list from RockView
                    RockView(searchString: searchText)
                        .navigationTitle("Pocket Stones")
                        .navigationDestination(for: Rock.self) { rock in
                            EditRockView(rock: rock)
                            
                        }
                        .toolbar {
                            
                            Button("Sort", systemImage: "arrow.up.arrow.down" ,action: addRock)
//                                .frame(width: 35, height: 35)
//                                .background(Color.cyan.opacity(0.1))
                                .buttonStyle(PlainButtonStyle()) // overrides default button styling
                                .fontWeight(.black)
//                                .clipShape(Circle())
                            
                            Button("Add Rock", systemImage: "plus" ,action: addRock)
//                                .frame(width: 35, height: 35)
//                                .background(Color.cyan.opacity(0.1))
                                .buttonStyle(PlainButtonStyle()) // overrides default button styling
                                .fontWeight(.black)
//                                .clipShape(Circle())
                            
                        }
                        // creates searchbar
                        .searchable(text: $searchText)
                }
            }
        }
    }
    
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
    ContentView()
}

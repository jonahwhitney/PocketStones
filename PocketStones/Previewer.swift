//
//  Previewer.swift
//  PocketStones
//
//  Created by Jonah Whitney on 10/3/24.
//

import Foundation
import SwiftData

@MainActor
struct Previewer {
    let container: ModelContainer
    let rock: Rock
    
    init() throws {
        // 
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Rock.self, configurations: config)
        
        rock = Rock(name: "Amethyst", shape: "Sphere", details: "", purchasePrice: 80, isFavorite: false)
        
        container.mainContext.insert(rock)
    }
}

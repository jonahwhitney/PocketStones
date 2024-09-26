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
                            VStack {
                                Text(rock.name)
                                Text(rock.shape)
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
    
    
    // initializes search string as empty, if searchString is empty the list returns all entries. Otherwise it displays entries that match the search parameters.
    init(searchString: String = "") {
        _rocks = Query(filter: #Predicate { rock in
            if searchString.isEmpty {
                true
            } else {
                rock.name.localizedStandardContains(searchString)
            }
        })
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
    RockView()
}

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
        .background(Color.red)
    }
    
    init(searchString: String = "") {
        _rocks = Query(filter: #Predicate { rock in
            if searchString.isEmpty {
                true
            } else {
                rock.name.localizedStandardContains(searchString)
            }
        })
    }
    
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

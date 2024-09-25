//
//  PocketStonesApp.swift
//  PocketStones
//
//  Created by Jonah Whitney on 9/16/24.
//

import SwiftData
import SwiftUI

@main
struct PocketStonesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Rock.self)
    }
}

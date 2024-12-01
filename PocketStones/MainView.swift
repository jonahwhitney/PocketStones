//
//  MainView.swift
//  PocketStones
//
//  Created by Jonah Whitney on 10/2/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        
        // Tab bar that allows you to swap from the collection to TotalsView
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Collection")
                }
            
            TotalsView()
                .tabItem {
                    Image(systemName: "chart.bar.xaxis.ascending")
                    Text("Totals")
                }
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

//
//  MainView.swift
//  PocketStones
//
//  Created by Jonah Whitney on 10/2/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
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
    MainView()
}

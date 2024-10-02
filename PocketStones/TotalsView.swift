//
//  TotalsView.swift
//  PocketStones
//
//  Created by Jonah Whitney on 10/2/24.
//

import SwiftUI

struct TotalsView: View {
    var body: some View {
        ZStack {
            // Sets background color
            Color.cyan.opacity(0.1)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // Header section with background color
                Rectangle()
                    .frame(height: 100) // Set a non-zero height
                    .foregroundColor(Color.indigo.opacity(0.4)) // Use foregroundColor
                    .overlay(
                        Text("Totals Overview")
                            .fontWeight(.bold)
                            .foregroundColor(.black) // Set text color
                            .padding(.top, 44) // Adjust padding to position below the notch
                            .padding(.horizontal) // Optional: Add horizontal padding
                    )
                    .edgesIgnoringSafeArea(.all)
                
                // Other content can go here
                Spacer() // Pushes content to the top
            }
            .padding(0) // Remove any default padding if necessary
        }
    }
}

#Preview {
    TotalsView()
}

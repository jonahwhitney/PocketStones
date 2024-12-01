//
//  TotalsView.swift
//  PocketStones
//
//  Created by Jonah Whitney on 10/2/24.
//
import SwiftData
import SwiftUI
import Charts

struct TotalsView: View {
    @Query var rocks: [Rock]
        
    var body: some View {
        ZStack {
            // Sets background color
            Color.cyan.opacity(0.1)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // Header section with background color
                Rectangle()
                    .containerRelativeFrame(.vertical) { size, axis in
                        size * 0.14
                    } // Set a non-zero height
                    .foregroundColor(Color.indigo.opacity(0.4)) // Use foregroundColor
                    .overlay(
                        Text("Totals Overview")
                            .fontWeight(.semibold) // font weight to match navTitle from other views
                            .foregroundColor(.black) // Set text color
                            .padding(.top, 44) // Adjust padding to position below the notch
                            .padding(.horizontal) // Optional: Add horizontal padding
                    )
                    .edgesIgnoringSafeArea(.all)
                
                // Other content can go here
                
                VStack {
                    
                    Text("Total Stones - \(rocks.count)")
                        .font(.title)
                    .fontWeight(.bold)
                    
                    Text("Total Value - $\(calculateValue())")
                        .font(.title)
                        .fontWeight(.bold)
                }
                .shadow(color: .indigo, radius: 7, x: 10, y: 10)
                
                Spacer()
                
                Divider()
                
                Chart {
                    
                    ForEach (rocks) { rock in
                                                
                        PointMark(x: .value("Shape of Rock", rock.shape), y: .value("Value", rock.purchasePrice))
                            .annotation {
                                Text(rock.name)
                            }
                    }
                }
                .padding()
            }
            .padding(0) // Remove any default padding if necessary
        }
    }
    
    // this func calculates the value of all the rocks purchasePrice
    func calculateValue () -> Int {
        
        var rockValue = 0
        
        for rock in rocks {
            rockValue += Int(rock.purchasePrice)
        }
        
        return rockValue
    }
    
}

#Preview {
    TotalsView()
}

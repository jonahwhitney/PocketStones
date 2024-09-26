//
//  EditRockView.swift
//  PocketStones
//
//  Created by Jonah Whitney on 9/16/24.
//

import SwiftUI

struct EditRockView: View {
    
    @Bindable var rock: Rock
    
    var body: some View {
        
        let formatter: NumberFormatter = {
            let numFormatter = NumberFormatter()
            numFormatter.zeroSymbol = ""
            return numFormatter
        }()
        
        ZStack {
            // sets background color
            Color.cyan.opacity(0.1)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Rectangle()
                    .frame(height: 0)
                    .background(Color.indigo.opacity(0.4))
                
                List {
                    Section {
                        TextField("Name", text: $rock.name)
                            .textContentType(.name)
                        
                        TextField("Shape", text: $rock.shape)
                        
                        TextField("Purchase Price", value: $rock.purchasePrice, formatter: formatter)
                    }
                                        
                    Section(header: Text("")) {
                        
                        TextField("Details", text: $rock.details, axis: .vertical)
                    }
                }
                .navigationTitle("Rock Info")
                .navigationBarTitleDisplayMode(.inline)
                .listStyle(PlainListStyle()) // Optional: Removes default list styling
                .background(Color.clear) // Background for the list itself to make it stand out
                .padding() // Padding to ensure the list is centered

            }
        }
    }
}

//#Preview {
//    EditRockView()
//}

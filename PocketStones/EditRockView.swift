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
            VStack {
                Rectangle()
                    .frame(height: 0)
                    .background(Color.indigo.opacity(0.4))
                
                Form {
                    Section {
                        TextField("Name", text: $rock.name)
                            .textContentType(.name)
                        
                        TextField("Shape", text: $rock.shape)
                        
                        TextField("Purchase Price", value: $rock.purchasePrice, formatter: formatter)
                    }
                    
                    Section {
                        
                        TextField("Details", text: $rock.details, axis: .vertical)
                        
                    }
                }
                .navigationTitle("Rock Info")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

//#Preview {
//    EditRockView()
//}

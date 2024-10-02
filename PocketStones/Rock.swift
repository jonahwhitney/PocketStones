//
//  rock.swift
//  PocketStones
//
//  Created by Jonah Whitney on 9/16/24.
//

import Foundation
import SwiftData

@Model
class Rock {
    
    var name: String
    var shape: String
    var details: String
    var purchasePrice: Int
    
    init(name: String, shape: String, details: String, purchasePrice: Int) {
        self.name = name
        self.shape = shape
        self.details = details
        self.purchasePrice = purchasePrice
    }
    
}

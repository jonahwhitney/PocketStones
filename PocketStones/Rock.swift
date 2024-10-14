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
    var purchasePrice: Float
    @Attribute(.externalStorage) var photo: Data?
    var isFavorite: Bool
    
    init(name: String, shape: String, details: String, purchasePrice: Float, isFavorite: Bool) {
        self.name = name
        self.shape = shape
        self.details = details
        self.purchasePrice = purchasePrice
        self.isFavorite = isFavorite
    }
    
}

//
//  ProductsSnapshot.swift
//  For Sale
//
//  Created by Duminica Octavian on 28/05/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation
import Firebase

struct ProductsSnapshot {
    let products: [Product]
    
    init?(snapshot: DataSnapshot) {
        guard let snapDict = snapshot.value as? [String: [String: Any]] else { return nil }
        var products = [Product]()
        
        for snap in snapDict {
            guard let product = Product(valueDict: snap.value) else { continue }
            products.append(product)       
        }
        self.products = products
    }
}

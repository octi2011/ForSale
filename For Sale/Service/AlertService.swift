//
//  AlertService.swift
//  For Sale
//
//  Created by Duminica Octavian on 28/05/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class AlertService {
    private init() {}
    
    static func addProductAlert(in vc: UIViewController, completion: @escaping (Product) -> Void) {
        let alert = UIAlertController(title: "New Product", message: "What's for sale?", preferredStyle: .alert)
        
        alert.addTextField { (titleTF) in
            titleTF.placeholder = "Title"
        }
        
        alert.addTextField { (priceTF) in
            priceTF.placeholder = "Price"
            priceTF.keyboardType = .numberPad
        }
        
        let send = UIAlertAction(title: "Send", style: .default) { (_) in
            guard let title = alert.textFields?.first?.text,
                let price = alert.textFields?.last?.text,
                let cost = Double(price)
                else { return }
            
            let product = Product(title: title, cost: cost)
            completion(product)
        }
        
        alert.addAction(send)
        vc.present(alert, animated: true, completion: nil)
    }
    
    static func subscribeAlert(in vc: ViewController) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let subscribe = UIAlertAction(title: "Subscribe", style: .default) { (_) in
            FIRMessagingService.shared.subscribe(to: .newProducts)
        }
        let unSubscribe = UIAlertAction(title: "Unsubscribe", style: .default) { (_) in
            FIRMessagingService.shared.unsubscribe(from: .newProducts)
        }
        
        alert.addAction(subscribe)
        alert.addAction(unSubscribe)
        
        vc.present(alert, animated: true, completion: nil)
    }
}



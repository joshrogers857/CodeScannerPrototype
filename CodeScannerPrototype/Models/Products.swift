//
//  Products.swift
//  CodeScannerPrototype
//
//  Created by Joshua Rogers on 02/03/2022.
//

import Foundation

struct Products {
    struct Item {
        let name: String
        let ean: String
    }
    
    static let data = [
        Item(
            name: "Coca-Cola 1.5l",
            ean: "5449000670977"
        ),
        Item(
            name: "Cadbury Dairy Milk 200g",
            ean: "7622300735838"
        ),
        Item(
            name: "Heinz Tomato Ketchup 800ml",
            ean: "50457236"
        ),
        Item(
            name: "Morrisons For Farmers Semi Skimmed Milk 2.7l",
            ean: "5010251686460"
        ),
        Item(
            name: "Heinz Beanz Fridge Pack 1kg",
            ean: "50157815"
        )
    ]
}

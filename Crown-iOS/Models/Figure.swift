//
//  Figure.swift
//  Crown
//
//  Created by Andrey Sysoev on 10.03.2023.
//

import Foundation

struct Figure: Equatable, Hashable {
    let name: String
    let width: Int
    let height: Int
    var x: Int
    var y: Int
    
    init(name: String, width: Int, height: Int, x: Int, y: Int) {
        self.name = name
        self.width = width
        self.height = height
        self.x = x
        self.y = y
    }
}

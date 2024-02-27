//
//  DropMenu.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 24/02/2024.
//

import Foundation

struct DropMenu: Identifiable {
    let id = UUID()
    var title: String
}
var drop: [DropMenu] = [
    DropMenu(title: "Piano"), // drop[0].title
    DropMenu(title: "Chess"), // drop[1].title
    DropMenu(title: "Creative Writing"), // drop[2].title
    DropMenu(title: "Reading"), // drop[3].title
    DropMenu(title: "Spanish Speaking"), // drop[4].title
    DropMenu(title: "Sudoku") // drop[5].title
]

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
    DropMenu(title: "Piano"),
    DropMenu(title: "Chess"),
    DropMenu(title: "Creative Writing"),
    DropMenu(title: "Reading"),
    DropMenu(title: "Spanish Speaking"),
    DropMenu(title: "Sudoku")
]

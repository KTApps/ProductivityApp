//
//  DropMenu.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 24/02/2024.
//

import Foundation
import SwiftUI

struct DropMenu: Identifiable {
    let id = UUID()
    var title: String
    var placeholder: Int
    var colour: Color
}
var drop: [DropMenu] = [
    DropMenu(title: "Piano", placeholder: 30, colour: .red), // drop[0].title
    DropMenu(title: "Chess", placeholder: 12, colour: .orange), // drop[1].title
    DropMenu(title: "Creative Writing", placeholder: 5, colour: .yellow), // drop[2].title
    DropMenu(title: "Reading", placeholder: 18, colour: .green), // drop[3].title
    DropMenu(title: "Spanish Speaking", placeholder: 15, colour: .blue), // drop[4].title
    DropMenu(title: "Sudoku", placeholder: 4, colour: .purple) // drop[5].title
]

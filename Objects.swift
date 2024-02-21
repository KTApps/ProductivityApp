//
//  Objects.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 21/02/2024.
//

import SwiftUI

class Objects: ObservableObject {
    @Published var selectedHabit: String?
    
    @Published var habitPositions: [String: CGSize] = [:]
    
    @Published var isHabitStriked: [String: Bool] = [:]
    
    @Published var WeekDayHabits: [String: String] = [:]
}

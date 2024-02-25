//
//  Objects.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 21/02/2024.
//

import SwiftUI

class Objects: ObservableObject {
    @Published var habitIdArray: [String] = []
    @Published var habitIdDict: [String: String] = [:] // Dictionary = [Habit Id : Habit Name]
    @Published var habitDict: [String: String] = [:] // Dictionary = [Habit Id : Habit Time]
    @Published var habitPositions: [String: CGSize] = [:] // Dictionary = [Habit Id : Habit coordinates]
    @Published var isHabitStriked: [String: Bool] = [:] // Dictionary = [Habit Id : Striked/ Not Striked]
    
    @Published var selectedHabit: String? // String that's about to be removed. '?' shows that it could be 'nil'
    
    @Published var WeekDayIndexCounter: Int = 0
    @Published var WeekDay: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    @Published var WeekDayHabits: [String: [String]] = [:] // Dictionary = [Weekday : Array of Habit Id's]
}

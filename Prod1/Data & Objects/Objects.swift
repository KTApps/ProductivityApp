//
//  Objects.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 21/02/2024.
//

import SwiftUI

class Objects: ObservableObject {
    
//    MARK: Authentication
    @Published var secureField: Bool = false
    
//    MARK: CUSTOM COLOURS
    @Published var darkGray: Color = Color(.sRGB, red: 0.2, green: 0.2, blue: 0.2, opacity: 1.0)
    
//    MARK: BlurView
    @Published var IsBlurViewVisible: Bool = false

//    MARK: Habits
    @Published var IsAddHabitVisible = false
    @Published var habitIdArray: [String] = []
    @Published var habitIdDict: [String: String] = [:] // Dictionary = [Habit Id : Habit Name]
    @Published var habitDict: [String: String] = [:] // Dictionary = [Habit Id : Habit Time]
    @Published var habitPositions: [String: CGSize] = [:] // Dictionary = [Habit Id : Habit coordinates]
    @Published var isHabitStriked: [String: Bool] = [:] // Dictionary = [Habit Id : Striked/ Not Striked]
    @Published var habitTickBoxDict: [String: Bool] = [:] // Dictionary = [Habit : Ticked/ Not Ticked]
    @Published var selectedHabit: String? // String that's about to be removed. '?' shows that it could be 'nil'
    
//    MARK: WeekDays
    @Published var WeekDayIndexCounter: Int = 0
    @Published var WeekDay: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
//    MARK: Task DropDown Menu
    @Published var TaskString: String = ""
    @Published var Tasks: [String] = []
    
    func TaskAdder() {
        Tasks.append(TaskString)
    }
    
    @Published var isAddTaskVisible = false
    @Published var IsTaskDropDownVisible = false
    
    @Published var TaskDecimalDict: [String: Double] = [:] // Dictionary = [Task Title: fraction of task completed]
    @Published var TaskPercentageDict: [String: Int] = [:] // Dictionary = [Task Title: percentage of task completed]
    
    func ProgressPercentage() {
        for item in Tasks {
            let decimal: Double = Double(TaskTimerDictionary[item] ?? 0)/20.00 // '20.00' determines how many decimal oints are printed
            let percentage = Int(decimal * 100)
            TaskDecimalDict[item] = decimal
            TaskPercentageDict[item] = percentage
        }
    }
    
    @Published var maxWidth: Double = 340
    @Published var newTimeArray: [String: Int] = [:]
    
    func newTimeCalc() {
        for item in Tasks {
            let newTime = (maxWidth * (TaskDecimalDict[item] ?? 0))
            newTimeArray[item] = Int(newTime)
        }
    }
    
//    MARK: Task Timer
    @Published var IsTimerOn: Bool = false
    @Published var timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect() // Just initializing 'timer' variable
    @Published var TaskTimerDictionary: [String: Int] = [:] // Dictionary = [Task Title : TimerCount for task]
    @Published var TaskName = "Task"
    @Published var TaskTime: Int = 0
    @Published var TimerCount: Int = 0
    
    func TaskTimer() -> Int? {
        for item in Tasks { // Use '.forEach{}' when performing an operation. Use 'ForEach(){}' when presenting a view.
            if (item == TaskName) {
                if TaskTimerDictionary[item] != nil {
                    TaskTimerDictionary[item]? += 1
                } else {
                    TimerCount = 0
                    TimerCount += 1
                    TaskTimerDictionary[item] = TimerCount
                }
                return TaskTimerDictionary[item]
            }
        }
        return nil
    }
    
    func resetTimer() -> Int? {
        for item in Tasks {
            if (item == TaskName) {
                if TaskTimerDictionary[item] == nil {
                    return 0
                } else {
                    return TaskTimerDictionary[item]
                }
            }
        }
        return nil
    }
    
//    MARK: Outer Circle
    @Published var SelectedChartPosition: Int?
    @Published var TaskSectorRange: [String: Range<Int>] = [:]
    
    func ColorReturn(value: String) -> Color {
        if (habitTickBoxDict[value] == true) {
            return .blue
        } else {
            return .gray
        }
    }
    
//    MARK: View Your Progress
    @Published var IsViewYourProgressVisible = false
    
//    MARK: Settings
    @Published var isSettingsVisible = false
}

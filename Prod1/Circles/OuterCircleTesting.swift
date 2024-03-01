//
//  OuterCircle.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 27/02/2024.
//

import SwiftUI
import Charts

struct OuterCircle: View {
    @EnvironmentObject var object: Objects
    
    @State private var selectedCount: Int? // Each sector has a different Int that represent their position. '?' = no sector
    @State private var selectedSector: DropMenu?
    
    var body: some View {
        VStack {
            Chart(drop) { task in
                SectorMark(
                    angle: .value("Time Spent", task.placeholder),
                    innerRadius: 140,
                    outerRadius: selectedSector?.title == task.title ? 190 : 170,
                    angularInset: 1
                )
                .foregroundStyle(task.colour)
                .cornerRadius(5)
            }
            .chartAngleSelection(value: $selectedCount) // when a sector is clicked, 'selectedCount' changes
            if let selectedSector {
                Text(selectedSector.title)
            }
        }
        .onChange(of: selectedCount) { oldValue, newValue in
            if let newValue { // if the value of selected count changed from the oldValue then...
                withAnimation {
                    getSelectedSector(value: newValue) // Takes in Int value of new selected sector
                    print("\(newValue)")
                }
            }
        }
    }
    
    private func getSelectedSector(value: Int) {
        var cumulativeTotal = 0
        let Task = drop.first { task in
            cumulativeTotal += task.placeholder
            if value <= cumulativeTotal {
                selectedSector = task
                return true
            }
            return false
        }
    }
}

#Preview {
    OuterCircle()
}

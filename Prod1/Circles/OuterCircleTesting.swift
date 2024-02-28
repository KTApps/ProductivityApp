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
    
    @State private var selectedCount: Int?
    @State private var selectedSector: DropMenu?
    
    var body: some View {
        VStack {
            Chart(drop) { task in
                SectorMark(
                    angle: .value("Time Spent", task.placeholder),
                    innerRadius: 140,
                    outerRadius: 170,
                    angularInset: 1
                )
                .foregroundStyle(task.colour)
                .cornerRadius(5)
            }
            .chartAngleSelection(value: $selectedCount)
            if let selectedSector {
                Text(selectedSector.title)
            }
        }
        .onChange(of: selectedCount) { oldValue, newValue in
            if let newValue {
                withAnimation {
                    getSelectedWineType(value: newValue)
                }
            }
        }
    }
    
    private func getSelectedWineType(value: Int) {
        var cumulativeTotal = 0
        let wineType = drop.first { wineType in
            cumulativeTotal += wineType.placeholder
            if value <= cumulativeTotal {
                selectedSector = wineType
                return true
            }
            return false
        }
    }
}

#Preview {
    OuterCircle()
}

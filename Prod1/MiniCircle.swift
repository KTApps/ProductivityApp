//
//  MiniCircle.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 17/03/2024.
//

import SwiftUI
import Charts

struct MiniCircle: View {
    @State private var array: [Int] = [1]
    
    var body: some View {
        Chart(array, id:\.self) { element in
            SectorMark(
                angle: .value("Time Spent", 10),
                innerRadius: 15,
                outerRadius: 25
            )
            .foregroundStyle(.gray)
            .cornerRadius(5)
        }
    }
}
#Preview {
    MiniCircle()
}

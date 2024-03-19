//
//  CalendarView.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 18/03/2024.
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        ScrollView {
            CalendarModel(interval: DateInterval(start:.distantPast, end:.distantFuture))
        }
    }
}

struct CalendarModel: UIViewRepresentable {
    
    let interval: DateInterval // DateInterval represents a range of time between 2 dates
    
    func makeUIView(context: Context) -> some UICalendarView {
        let view = UICalendarView() // creates instance of UICalendarView()
        view.calendar = Calendar(identifier: .gregorian) // type of calendar
        view.availableDateRange = interval
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}

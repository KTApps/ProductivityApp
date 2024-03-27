import SwiftUI
import Charts

struct CalendarView: View {
    @State private var selectedDate = Date() // Selected date
    @State private var monthOffset = 0 // Offset to switch between months
    @State private var selectedMonthIndex: Int
    @State private var selectedYear: Int
    @State private var isMonthChangerVisible = false
    @State private var selectedMonth = "" // Selected month name
    
    private let months = Calendar.current.monthSymbols // Array of month names
    private let daysOfWeek = Calendar.current.shortWeekdaySymbols // Array of short weekday names
    
    // Initialize with current month and year by default
    init() {
        let currentDate = Date()
        self._selectedMonthIndex = State(initialValue: Calendar.current.component(.month, from: currentDate) - 1)
        self._selectedYear = State(initialValue: Calendar.current.component(.year, from: currentDate))
        self._selectedMonth = State(initialValue: months[selectedMonthIndex])
    }
    
    func daysInMonthForSection(section: Int, year: Int) -> Int {
        let calendar = Calendar.current
        var components = DateComponents()
        components.month = section + 1
        components.year = year
        let date = calendar.date(from: components)!
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }

    func updateSelectedMonthAndYear() {
        let newDateComponents = DateComponents(year: selectedYear, month: selectedMonthIndex + 1)
        if let newDate = Calendar.current.date(from: newDateComponents) {
            selectedDate = newDate
            selectedMonth = months[selectedMonthIndex] // Update selected month
        }
    }

    func firstWeekdayOfMonth(for year: Int, month: Int) -> Int {
        let calendar = Calendar.current
        let firstDayOfMonthComponents = DateComponents(year: year, month: month, day: 1)
        if let firstDayOfMonth = calendar.date(from: firstDayOfMonthComponents) {
            let weekday = calendar.component(.weekday, from: firstDayOfMonth)
            return (weekday + 6) % 7 // Adjust to start from Sunday
        }
        return 0
    }
    
    func abbreviatedWeekday(for index: Int) -> String {
        let weekdayIndex = (index + Calendar.current.firstWeekday - 1) % 7
        return daysOfWeek[weekdayIndex]
    }

    // Function to calculate the days to display in the calendar grid
    func calculateDaysToDisplay(daysInMonth: Int, firstWeekday: Int) -> [Int?] {
        var daysToDisplay = [Int?]()
        let totalDaysInGrid = 6 * 7 // 6 rows and 7 columns
        
        // Determine the first day of the month
        let firstDayOfMonth = firstWeekday > 0 ? firstWeekday - 1 : 6
        
        // Start displaying days from the first day of the month onwards
        for dayIndex in 0..<totalDaysInGrid {
            if dayIndex < firstDayOfMonth {
                // Display an empty cell for days before the first day of the month
                daysToDisplay.append(nil)
            } else if dayIndex - firstDayOfMonth + 1 <= daysInMonth {
                // Display days from the current month
                daysToDisplay.append(dayIndex - firstDayOfMonth + 1)
            } else {
                // Display nil for days after the current month
                daysToDisplay.append(nil)
            }
        }
        return daysToDisplay
    }
    
    var body: some View {
        let currentMonth = Calendar.current.date(byAdding: .month, value: monthOffset, to: selectedDate)! // calculates new date
        let daysInMonth = daysInMonthForSection(section: selectedMonthIndex, year: selectedYear)
        let firstWeekday = firstWeekdayOfMonth(for: selectedYear, month: selectedMonthIndex + 1)
        let numberOfColumns = 7 // Number of columns in the calendar
        
        return VStack {
            HStack {
                Button {
                    isMonthChangerVisible.toggle()
                } label: {
                    Text(String("\(selectedMonth) \(selectedYear)"))
                        .foregroundColor(.black)
                }
                .sheet(isPresented: $isMonthChangerVisible) {
                    VStack {
                        HStack {
                            Picker(selection: $selectedMonthIndex, label: Text("\(selectedMonth)")) {
                                ForEach(0..<months.count) { index in
                                    Text(months[index]).tag(index)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .onChange(of: selectedMonthIndex) { newValue in
                                selectedMonth = months[newValue]
                            }
                            
                            Picker(selection: $selectedYear, label: Text(String("\(selectedYear)"))) {
                                ForEach(selectedYear - 10..<selectedYear + 10, id: \.self) { year in
                                    Text(String("\(year)"))
                                        .tag(year)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                        }
                        
                        Spacer()
                            .frame(height: 10)
                        
                        Button {
                            isMonthChangerVisible.toggle()
                        } label: {
                            Text("Submit")
                                .font(.title)
                        }
                    }
                    .presentationDetents([.medium])
                }
                
                Spacer()
                
                Button {
                    monthOffset -= 1
                    selectedMonthIndex -= 1
                    if selectedMonthIndex < 0 {
                        selectedMonthIndex = months.count - 1
                        selectedYear -= 1
                    }
                    updateSelectedMonthAndYear()
                } label: {
                    Image(systemName: "chevron.left")
                }

                Button {
                    monthOffset += 1
                    selectedMonthIndex += 1
                    if selectedMonthIndex >= months.count {
                        selectedMonthIndex = 0
                        selectedYear += 1
                    }
                    updateSelectedMonthAndYear()
                } label: {
                    Image(systemName: "chevron.right")
                }
            }
            .padding()
            
            ScrollView {
                VStack {
                    // Display weekday labels row
                    HStack(spacing: 0) {
                        ForEach(0..<numberOfColumns) { column in
                            Text(abbreviatedWeekday(for: column))
                                .frame(width: UIScreen.main.bounds.width / CGFloat(numberOfColumns), height: UIScreen.main.bounds.width / CGFloat(numberOfColumns))
                        }
                    }
                    
                    // Display days in the calendar
                    let daysToDisplay = calculateDaysToDisplay(daysInMonth: daysInMonth, firstWeekday: firstWeekday)
                    ForEach(0..<((daysInMonth + firstWeekday - 1) / numberOfColumns) + 1) { row in
                        HStack(spacing: 0) {
                            ForEach(0..<numberOfColumns) { column in
                                if let day = daysToDisplay[row * numberOfColumns + column] {
                                    CalendarDayCell(day: day)
                                        .frame(width: UIScreen.main.bounds.width / CGFloat(numberOfColumns), height: UIScreen.main.bounds.width / CGFloat(numberOfColumns))
                                } else {
                                    // Display an empty view when day is nil
                                    Color.clear
                                        .frame(width: UIScreen.main.bounds.width / CGFloat(numberOfColumns), height: UIScreen.main.bounds.width / CGFloat(numberOfColumns))
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            // Update selectedDate when the view appears
            let newDateComponents = DateComponents(year: selectedYear, month: selectedMonthIndex + 1)
            if let newDate = Calendar.current.date(from: newDateComponents) {
                selectedDate = newDate
            }
        }
    }
}

struct CalendarDayCell: View {
    let day: Int
    
    var body: some View {
        ZStack {
            Text("\(day)") // Display the day number
                .foregroundColor(.black) // Ensure the text is visible
            
            MiniCircle()
        }
    }
}

struct MiniCircle: View {
    var body: some View {
        Chart([1], id:\.self) { _ in
            SectorMark(
                angle: .value("Time Spent", 10),
                innerRadius: 13,
                outerRadius: 20
            )
            .foregroundStyle(Color(.sRGB, red: 0.2, green: 0.2, blue: 0.2, opacity: 1.0))
            .cornerRadius(2.5)
        }
    }
}

extension Date {
    func startOfMonth() -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components)!
    }
}

struct CalendarViewTest_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}

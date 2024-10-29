//
//  CurrentDay.swift
//  Learning Journey
//
//  Created by Nahed Almutairi on 26/04/1446 AH.
//


import SwiftUI

struct CurrentDay: View {
    @State var learningGoal: String
    @State var duration: String
    
    @State private var currentDate = Date() // تاريخ اليوم الحالي
    @State private var currentWeekStartDate = Date() // بداية الأسبوع الحالي
    @State private var currentWeekDates: [Date] = [] // تواريخ الأسبوع الحالي
    @State private var isPickerPresented = false // التحكم في إظهار قائمة الشهر والسنة
    @State private var isLearned = false // للتحقق من حالة اليوم كـ "تم التعلم"
    @State private var isFrozen = false // للتحقق من حالة اليوم كـ "مجمد"
    @State private var streakCount: Int = UserDefaults.standard.integer(forKey: "streakCount") // عداد السلسلة
    @State private var frozenDays: Int = UserDefaults.standard.integer(forKey: "frozenDays") // عداد الأيام المجمدة
    @State private var lastLogDate: Date? = UserDefaults.standard.object(forKey: "lastLogDate") as? Date // تاريخ آخر تسجيل

    // Computed property for freeze limits based on duration
    private var freezeLimit: Int {
        switch duration {
        case "Week":
            return 2
        case "Month":
            return 6
        case "Year":
            return 60
        default:
            return 6
        }
    }
    
    var body: some View {
        NavigationView{
            VStack (spacing : 15 ){
                // Display Current Date (Day, Date, Year) in Center
                Text(formattedFullDate(date: currentDate))
                    .font(.headline)
                    .foregroundColor(Color.gray.opacity(0.5))
                    .padding(.leading, -155)
                
                // Header for Learning Goal
                HStack {
                    Text("Learning \(learningGoal)")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .bold()
                        .padding(.bottom, -29)
                    
                    Spacer()
                    NavigationLink(destination: Update(learningGoal: learningGoal, duration: duration) { updatedGoal, updatedDuration in
                        self.learningGoal = updatedGoal
                        self.duration = updatedDuration
                        resetProgress()
                    }){
                        Text("🔥")
                            .font(.largeTitle)
                            .frame(width: 50, height: 50)
                            .background(Color.gray.opacity(0.3))
                            .clipShape(Circle())
                            .foregroundColor(.orange)
                    }
                }
                .background(Color.black.ignoresSafeArea())
                .padding(.horizontal)
                .padding(.top, -15)
                
                // Calendar inside rounded rectangle
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color.black.opacity(0.8)))
                    .overlay(
                        VStack {
                            // Month and Year with Dropdown Arrow
                            HStack {
                                Text("\(formattedMonthAndYear(date: currentWeekStartDate))")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .bold()
                                
                                Button(action: {
                                    isPickerPresented.toggle()
                                }) {
                                    Image(systemName: "chevron.down")
                                        .font(.title2)
                                        .foregroundColor(.orange)
                                }
                                .sheet(isPresented: $isPickerPresented) {
                                    MonthYearPicker(selectedDate: $currentWeekStartDate) {
                                        setupCurrentWeek(date: currentWeekStartDate)
                                    }
                                }
                                
                                Spacer()
                                
                                HStack(spacing: 30) {
                                    Button(action: previousWeek) {
                                        Image(systemName: "chevron.left")
                                            .font(.title2)
                                            .foregroundColor(.orange)
                                    }
                                    
                                    Button(action: nextWeek) {
                                        Image(systemName: "chevron.right")
                                            .font(.title2)
                                            .foregroundColor(.orange)
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 10)
                            
                            // Display Week Dates
                            HStack(spacing: 15) {
                                ForEach(currentWeekDates, id: \.self) { date in
                                    VStack(spacing: 5) {
                                        Text(dayOfWeek(date: date))
                                            .font(.callout)
                                            .foregroundColor(isToday(date: date) ? .white : Color.gray.opacity(0.5))
                                        
                                        Text(dayOfMonth(date: date))
                                            .font(.title2)
                                            .foregroundColor(isToday(date: date) ? (isLearned || isFrozen ? .white : .orange) : .white)
                                            .frame(width: isToday(date: date) ? 40 : 28, height: isToday(date: date) ? 40 : 28) 
                                            .background(isToday(date: date) ? (isLearned ? Color.orange : isFrozen ? Color.blue : Color.clear) : Color.clear)
                                            .clipShape(Circle())
                                    }
                                }
                            }
                            .padding(.top, 10)
                            
                            Divider()
                                .background(Color.gray.opacity(0.5))
                                .padding(.horizontal, 10)
                            
                            // Day Streak and Freeze Count
                            HStack {
                                VStack {
                                    HStack(spacing: 4) {
                                        Text("\(streakCount) 🔥")
                                            .font(.title2)
                                            .foregroundColor(.white)
                                            .foregroundColor(.orange)
                                        
                                    }
                                    Text("Day streak")
                                        .font(.headline)
                                        .foregroundColor(Color.gray.opacity(0.5))
                                }
                                
                                Divider()
                                    .frame(height: 40)
                                    .background(Color.gray.opacity(0.5))
                                
                                VStack {
                                    HStack(spacing: 4) {
                                        Text("\(frozenDays) 🧊")
                                            .font(.title2)
                                            .foregroundColor(.white)
                                            .foregroundColor(.blue)
                                    }
                                    Text("Day freezed")
                                        .font(.headline)
                                        .foregroundColor(Color.gray.opacity(0.5))
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 1)
                        }
                    )
                    .frame(height: 200)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                
                Spacer()
                
                // Large Orange/Blue Button and Freeze Button
                Button(action: {
                    if !isLearned && !isFrozen {
                        isLearned = true
                        streakCount += 1
                        lastLogDate = Date()
                                                UserDefaults.standard.set(streakCount, forKey: "streakCount")
                                                UserDefaults.standard.set(lastLogDate, forKey: "lastLogDate")
                    }
                }) {
                    Text(isLearned ? "Learned Today" : isFrozen ? "Day Freezed" : "Log today as Learned")
                        .font(.largeTitle)
                        .foregroundColor(isLearned ? .orange : isFrozen ? .blue : .black)                                    .fontWeight(.bold)
                        .frame(width: 300, height: 300)
                        .background(isLearned ? Color.orange.opacity(0.3) : isFrozen ? Color.blue.opacity(0.3) : Color.orange)
                        .clipShape(Circle())
                }
                .disabled(isLearned || isFrozen)
                .padding(.bottom, 20)
                
                Button(action: {
                    if !isLearned && !isFrozen {
                        isFrozen = true
                        frozenDays += 1
                        UserDefaults.standard.set(frozenDays, forKey: "frozenDays")

                    }
                }) {
                    Text("Freeze day")
                        .font(.headline)
                        .frame(width: 150, height: 40)
                        .foregroundColor(isLearned || isFrozen ? .gray : .blue)
                        .background(isLearned || isFrozen ? Color.gray.opacity(0.3) : Color(red: 0.82, green: 0.91, blue: 1.0))
                        .cornerRadius(10)
                }
                .disabled(isLearned || isFrozen || frozenDays >= freezeLimit)
                
                // Freeze info text
                Text("\(frozenDays) out of \(freezeLimit) freezes used")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top, 5)
                
                Spacer()
            }
            .background(Color.black.ignoresSafeArea())
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .onAppear {
                setupCurrentWeek(date: currentDate)
                checkStreakResetConditions()
            }
        }
    }
    // MARK: - Helper Functions

    private func resetProgress() {
            isLearned = false
            isFrozen = false
            streakCount = 0
            frozenDays = 0
            lastLogDate = nil
            UserDefaults.standard.set(streakCount, forKey: "streakCount")
            UserDefaults.standard.set(frozenDays, forKey: "frozenDays")
            UserDefaults.standard.set(nil, forKey: "lastLogDate")
        }

    private func checkStreakResetConditions() {
            if shouldResetStreak() {
                streakCount = 0
                frozenDays = 0
                UserDefaults.standard.set(streakCount, forKey: "streakCount")
                UserDefaults.standard.set(frozenDays, forKey: "frozenDays")
            }
        }
        
        private func shouldResetStreak() -> Bool {
            guard let lastLogDate = lastLogDate else { return false }
            if Date().timeIntervalSince(lastLogDate) > 32 * 3600 {
                return true
            }
            return false
        }

    private func setupCurrentWeek(date: Date) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .weekday], from: date)
        
        if let startOfWeek = calendar.date(from: components) {
            currentWeekStartDate = calendar.date(byAdding: .day, value: -((components.weekday ?? 1) - 1), to: startOfWeek)!
            updateCurrentWeekDates()
        }
    }
    
    private func updateCurrentWeekDates() {
        let calendar = Calendar.current
        currentWeekDates = (0..<7).compactMap {
            calendar.date(byAdding: .day, value: $0, to: currentWeekStartDate)
        }
    }
    
    private func formattedFullDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMMM yyyy"
        return formatter.string(from: date)
    }
    
    private func formattedMonthAndYear(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
    
    private func dayOfWeek(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: date)
    }
    
    private func dayOfMonth(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
    
    private func isToday(date: Date) -> Bool {
        Calendar.current.isDate(date, inSameDayAs: currentDate)
    }
    
    private func nextWeek() {
        currentWeekStartDate = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: currentWeekStartDate)!
        updateCurrentWeekDates()
    }
    
    private func previousWeek() {
        currentWeekStartDate = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: currentWeekStartDate)!
        updateCurrentWeekDates()
    }
}

// MonthYearPicker: قائمة لاختيار الشهر والسنة
struct MonthYearPicker: View {
    @Binding var selectedDate: Date
    let onDateSelected: () -> Void
    
    private var months: [String] {
        let formatter = DateFormatter()
        return formatter.monthSymbols
    }
    
    private var years: [Int] {
        Array(2020...2030)
    }
    
    var body: some View {
        VStack {
            Text("Select Month and Year")
                .font(.headline)
                .padding()
            
            Picker("Month", selection: Binding(
                get: { Calendar.current.component(.month, from: selectedDate) - 1 },
                set: { selectedDate = Calendar.current.date(bySetting: .month, value: $0 + 1, of: selectedDate) ?? selectedDate }
            )) {
                ForEach(0..<months.count, id: \.self) { index in
                    Text(months[index]).tag(index)
                }
            }
            .pickerStyle(WheelPickerStyle())
            
            Picker("Year", selection: Binding(
                get: { Calendar.current.component(.year, from: selectedDate) },
                set: { selectedDate = Calendar.current.date(bySetting: .year, value: $0, of: selectedDate) ?? selectedDate }
            )) {
                ForEach(years, id: \.self) { year in
                    Text("\(year)").tag(year)
                }
            }
            .pickerStyle(WheelPickerStyle())
            
            Button("Select") {
                onDateSelected()
            }
            .padding()
        }
    }
}

struct CurrentDay_Previews: PreviewProvider {
    static var previews: some View {
        CurrentDay(learningGoal: "Swift", duration: "Month")
            .previewDevice("iPhone 14")
    }
}

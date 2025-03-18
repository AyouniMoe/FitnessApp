//
//  Date+Ext.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 3/11/25.
//

import Foundation


extension Date {
    static var startOfDay: Date {
        let calendar = Calendar.current
        return calendar.startOfDay(for: Date())
    }
    static var startOfWeek: Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()) // Fixed typo
        components.weekday = 2 // Set to Monday (weekday 2)
        return calendar.date(from: components) ?? Date() // Corrected method call
    }


    func fetchMonthStartAndEndDate() -> (Date, Date) {
        let calendar = Calendar.current
        let startDateComponent = calendar.dateComponents([.year, .month], from: calendar.startOfDay(for: self))
        let startDate = calendar.date(from: startDateComponent) ?? self
        
        let endDate = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startDate) ?? self
        return (startDate, endDate)
    }
    func formatWorkoutDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: self)
    }
    
   
    
    func mondayDateFormat() -> String {
        let monday = Date.startOfWeek
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyy"
        return formatter.string(from: monday)
    }
    
    
    func monthAndYearFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        return formatter.string(from: self)
    }
}

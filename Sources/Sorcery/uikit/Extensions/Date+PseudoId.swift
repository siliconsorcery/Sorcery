//
//  Date+PseudoId.swift
//  
//
//  Created by John Cumming on 7/10/21.
//

import Foundation

extension Date {
    
    func isNearlySame(_ other: Date, _ epsilon: TimeInterval = 2.00) -> Bool {
        let delta = self.timeIntervalSince(other)
        return abs(delta) <= epsilon
    }
    
    public func pseudoId() -> String {

        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm, d MMM y"
        let seedDate = formatter.date(from: "00:00 1 Jan 2021")!
        
        let delta = Calendar
            .current
            .dateComponents(
                [.day, .hour, .minute, .second]
                ,from: seedDate
                ,to: self
            )
        
        let days = delta.day ?? 0
        let hour = delta.hour ?? 0
        let minute = delta.minute ?? 0
        let second = delta.second ?? 0
        
        let time: Int = (hour * 60 * 60 + minute * 60 + second) * 46655 / 86400
        
        let sign = (time < 0 || days < 0) ? "-" : ""
        
        let timeBase36 = String("000\(String(abs(time), radix: 36, uppercase: true))".suffix(3))
        
        return "\(sign)\(abs(days))\(timeBase36)"
    }
    
    public static func pseudoId(from: String) -> Date {
        
        let timePart = from.suffix(3)
        let datePart = from.dropLast(3)
        
        let sign = (datePart.prefix(1) == "-") ? -1 : 1
        let daysDelta = Int(datePart) ?? 0
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm, d MMM y"
        let seedDate = formatter.date(from: "00:00 1 Jan 2021")!
        let delta = Calendar
            .current
            .dateComponents(
                [.year, .month, .day, .hour, .minute, .second]
                ,from: seedDate
            )
            
        let years = delta.year ?? 0
        let months = delta.month ?? 0
        var days = delta.day ?? 0
        var hours = delta.hour ?? 0
        var minutes = delta.minute ?? 0
        var seconds = delta.second ?? 0
            
        days += daysDelta
        
        let timeDecode = Int(timePart, radix: 36) ?? 0
        let time = sign * timeDecode * 86400 / 46655
        let deltaHours = time / 60 / 60
        let deltaMinutes = time / 60 - deltaHours * 60
        let deltaSeconds = time - deltaHours * 60 * 60 - deltaMinutes * 60
        
        hours = deltaHours
        minutes = deltaMinutes
        seconds = deltaSeconds
            
        let components = DateComponents(
            year: years
            ,month: months
            ,day: days
            ,hour: hours
            ,minute: minutes
            ,second: seconds
        )
        return Calendar
            .current
            .date(from: components) ?? Date()
    }
}

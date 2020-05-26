//
//  Date+Formatting.swift
//  Core
//
//  Created by John Cumming on 11/17/17.
//  Copyright © 2017 Silicon Sorcery. All rights reserved.
//

import UIKit

extension Date {
    public var timestamp: Int64 {
        return Int64((self.timeIntervalSince1970 * 1_000.0))
    }

    public init(timestamp: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(timestamp) / 1_000.0)
    }
    
    public func relative(
        to now: Date? = nil
        ,showTime: Bool = true
    ) -> String {
        
        let now = now ?? Date()
                
        let this = Calendar
            .current
            .dateComponents(
                [.year, .month, .weekOfYear, .day, .hour, .minute, .second]
                ,from: now
                ,to: self
            )
        
        let year = this.year ?? 0
        let month = this.month ?? 0
        let weekOfYear = this.weekOfYear ?? 0
        let day = this.day ?? 0
        let hour = this.hour ?? 0
        let minute = this.minute ?? 0
        let second = this.second ?? 0
        
        let isPast = (self < now)
        if isPast {
            if year < 0 {
                let years = -year + ((-month % 12) < 6 ? 0 : 1)
                return "\(years) year\(years > 1 ? "s" : "") ago"
            }
            if month < 0 {
                let months = -month + ((-day % 30) < 15 ? 0 : 1)
                return "\(months) month\(months > 1 ? "s" : "") ago"

            }
            if weekOfYear < 0 {
                let weeks = -weekOfYear + ((-day % 7) < 4 ? 0 : 1)
                return "\(weeks) week\(weeks > 1 ? "s" : "") ago"
            }
            if day < 0 {
                let days = -day + ((-hour % 24) < 12 ? 0 : 1)
                return "\(days) day\(days > 1 ? "s" : "") ago"
            }
            
            if showTime == false {
                return relativeDay(to: now)
            } else {
                if hour < 0 {
                    let hours = -hour + ((-minute % 60) < 30 ? 0 : 1)
                    return "\(hours) hour\(hours > 1 ? "s" : "") ago"
                }
                if minute < 0 {
                    let minutes = -minute + ((-second % 60) < 30 ? 0 : 1)
                    return "\(minutes) minute\(minutes > 1 ? "s" : "") ago"
                }
                return "Just now"
            }
            
        } else {
            if year > 0 {
                let years = year + ((month % 12) < 6 ? 0 : 1)
                return "in \(years) year\(years > 1 ? "s" : "")"
            }
            if month > 0 {
                let months = month + ((day % 30) < 15 ? 0 : 1)
                return "in \(months) month\(months > 1 ? "s" : "")"

            }
            if weekOfYear > 0 {
                let weeks = weekOfYear + ((day % 7) < 4 ? 0 : 1)
                return "in \(weeks) week\(weeks > 1 ? "s" : "")"
            }
            if day > 0 {
                let days = day + ((hour % 24) < 12 ? 0 : 1)
                return "in \(days) day\(days > 1 ? "s" : "")"
            }
            
            if showTime == false {
                return relativeDay(to: now)
            } else {
                if hour > 0 {
                    let hours = hour + ((minute % 60) < 30 ? 0 : 1)
                    return "in \(hours) hour\(hours > 1 ? "s" : "")"
                }
                if minute > 0 {
                    let minutes = minute + ((second % 60) < 30 ? 0 : 1)
                    return "in \(minutes) minute\(minutes > 1 ? "s" : "")"
                }
                return "Just now"
            }
        }
    }
    
    public func relativeDay(
        to now: Date = Date()
    ) -> String {
        
        let relativeDays = self.removeTime().days(from: now.removeTime())
        switch relativeDays {
        case -1:
            return "Yesterday"
        case 0:
            return "Today"
        case 1:
            return "Tomorrow"
        default:
            return ""
        }
    }
    
    /// Formats date to a string from given specification
    ///
    /// - Parameters:
    ///   - dateFormat: String - DateFormatter
    ///                 https://docs.oracle.com/javase/7/docs/api/java/text/SimpleDateFormat.html
    ///                 "h:mm:ss" -> "3:08:59"
    ///                 "MMMM d, y h:mm:ss a" -> "November 13, 2017 3:08:59 PM"
    ///                 "yyyy-MM-dd HH:mm:ss" -> "20017-11-17 03:18:23"
    ///                 "M-d-yyyy H:mm a" -> "3/21/20018  3:21 PM"
    ///                 "EEEE" -> "Monday"
    ///                 "d EEEE" -> "8 Monday"
    /// - Returns: String representation of formatted data
    public func toString(formattedBy dateFormat: String  = "MMMM d, y h:mm:ss a") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }

    /// Calculates the duration between given date
    ///
    /// - Parameter date: to calculate with or 'nil' to use now.
    /// - Returns: Duration as a String
    public func durationToString(_ date: Date = Date()) -> String {
        let duration = abs(timeIntervalSince(date))
        return duration.formatted()
    }

    /// Returns an iso8601 string representation of the date
    public var iso8601: String {
        let iso8601DateFromatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale = Locale.current
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
            return formatter
        }()
        return iso8601DateFromatter.string(from: self)
    }

    /// Returns a date created from an iso8601 string
    ///
    /// - Parameter iso8601: date formatted as String
    /// - Returns: new date
    public static func from(iso8601: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        return dateFormatter.date(from: iso8601)
    }

    /// Years between dates
    ///
    /// - Parameter date: date to calculate against
    /// - Returns: int - number of years
    public func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }

    /// Months between dates
    ///
    /// - Parameter date: date to calculate against
    /// - Returns: int - number of months
    public func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }

    /// Weeks between dates
    ///
    /// - Parameter date: date to calculate against
    /// - Returns: int - number of weeks
    public func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfYear], from: date, to: self).weekOfYear ?? 0
    }

    /// Days between dates
    ///
    /// - Parameter date: date to calculate against
    /// - Returns: int - number of days
    public func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }

    /// Hours between dates
    ///
    /// - Parameter date: date to calculate against
    /// - Returns: int - number of hours
    public func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }

    /// Minutes between dates
    ///
    /// - Parameter date: date to calculate against
    /// - Returns: int - number of minutes
    public func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }

    /// Seconds between dates
    ///
    /// - Parameter date: date to calculate against
    /// - Returns: int - number of seconds
    public func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }

    /// Removes the hours, minutes and seconds from the date
    ///
    /// - Returns: new Date
    public func removeTime() -> Date {
        var parts = Calendar.current.dateComponents([.year, .month, .weekOfYear, .day, .hour, .minute, .second, .weekday], from: self)
        parts.hour = 0
        parts.minute = 0
        parts.second = 0
        guard let newDate = Calendar.current.date(from: parts) else { fatalError() }
        return newDate
    }

    /// Round the date up to next snap time point
    ///
    /// - Parameters:
    ///   - plusHour: round to hours
    ///   - roundedMinutes: round to minutes
    ///   - reversed: previous time point
    /// - Returns: new rounded date
    public func bumpTo(
        plusHour: Int = 0
        ,roundedMinutes: Int = 15
        ,reversed: Bool = false
    ) -> Date {
        let reversed = reversed ? -1 : 1
        var parts = Calendar.current.dateComponents([.year, .month, .weekOfYear, .day, .hour, .minute, .second, .weekday], from: self)
        if (plusHour != 0) {
            parts.hour = parts.hour! + plusHour * reversed
            parts.minute = 0
            parts.second = 0
        } else {
            let bump = roundedMinutes - parts.minute! % roundedMinutes * reversed
            parts.minute = parts.minute! + bump * reversed
            parts.second = 0
        }
        guard let newDate = Calendar.current.date(from: parts) else { fatalError() }
        return newDate
    }

    /// Create a rounded date great than self
    ///
    /// - Parameters:
    ///   - plusHours: If hour > '0', Adds hour to now and sets minutes & seconds to '0'. Defaults to '0'
    ///   - roundingMinutes: If hour = '0', Rounds time to the next roundingMinutes.
    ///   - miniumMinutes: Ensures there is at least miniumMinutes before new date, else adds more time
    /// - Returns: New date
    /// - Examples:
    ///     12:35.nowRounded() -> 12:45
    ///     12:42.nowRounded() -> 13:00 // Since 12:42 is only 3 minutes from 12:45 therefore is too soon
    ///     12:10.nowRounded(plusHours: 1) -> 13:00
    ///     12:59.nowRounded(plusHours: 1) -> 14:00 // Since now was only 1 minute from top to the hour
    ///     12:04.nowRounded(roundingMinutes: 30) -> 12:30
    ///     12:16.nowRounded(miniumMinutes: 30) > Assets: miniumMinutes can't be larger roundingMinutes
    public func rounded(plusHours: Int = 0, roundingMinutes: Int = 15, miniumMinutes: Int = 5) -> Date {
        let now = self
        var parts = Calendar.current.dateComponents([.year, .month, .weekOfYear, .day, .hour, .minute, .second, .weekday], from: now)
        if (plusHours != 0) {
            parts.hour = parts.hour! + plusHours
            parts.minute = 0
            parts.second = 0
        } else {
            let plusMinutes = roundingMinutes - (parts.minute! % roundingMinutes)
            parts.minute = parts.minute! + plusMinutes
            parts.second = 0
        }
        guard let newDate = Calendar.current.date(from: parts) else { fatalError() }
        if (newDate.minutes(from: now) < miniumMinutes) {
            if (plusHours != 0) {
                assert(miniumMinutes <= 60, "miniumMinutes can't be larger than 60 minutes")
                parts.hour = parts.hour! + 1
            } else {
                assert(miniumMinutes <= roundingMinutes, "miniumMinutes can't be larger roundingMinutes")
                parts.minute = parts.minute! + roundingMinutes
            }
            guard let finalDate = Calendar.current.date(from: parts) else { fatalError() }
            return finalDate
        }
        return newDate
    }

    /// Advances the time components to given time
    ///
    /// - Parameters:
    ///   - hour: int hours
    ///   - minute: int minutes
    /// - Returns: new Date
    public func advanceTo(hour: Int = 0, minute: Int = 0) -> Date {
        var nextDateComponents = Calendar.current.dateComponents([.year, .month, .weekOfYear, .day, .hour, .minute, .second, .weekday], from: self)

        if nextDateComponents.hour! > hour {
            nextDateComponents.day! += 1
        }
        if nextDateComponents.hour! == hour && nextDateComponents.minute! > minute {
            nextDateComponents.day! += 1
        }

        nextDateComponents.hour = hour
        nextDateComponents.minute = minute
        nextDateComponents.second = 0

        guard let nextDate = Calendar.current.date(from: nextDateComponents) else { fatalError() }

        return nextDate
    }

    /// Advances date by given amounts
    ///
    /// - Parameters:
    ///   - days: int days
    ///   - hours: int hours
    ///   - minutes: int minutes
    ///   - seconds: int seconds
    /// - Returns: new date
    public func advanceBy(
        days: Int = 0,
        hours: Int = 0,
        minutes: Int = 0,
        seconds: Int = 0
    ) -> Date {
        var nextDateComponents = Calendar.current.dateComponents([.year, .month, .weekOfYear, .day, .hour, .minute, .second, .weekday], from: self)

        nextDateComponents.day! += days
        nextDateComponents.hour! += hours
        nextDateComponents.minute! += minutes
        nextDateComponents.second! += seconds

        guard let nextDate = Calendar.current.date(from: nextDateComponents) else { fatalError() }

        return nextDate
    }

    /// Returns 's' is int is greater than 1
    ///
    /// - Parameter number: int to test
    /// - Returns: String with _plural postscript
    private func _plural(_ number: Int) -> String {
        return number > 1 ? "s" : ""
    }
}

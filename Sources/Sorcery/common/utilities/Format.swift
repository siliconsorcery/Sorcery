//
//  File.swift
//  
//
//  Created by John Cumming on 6/17/21.
//

import Foundation

public enum Format {
    
    static func dates(
        _ startDate: Date?
        ,isAllDay isStartAllDay: Bool = false
        ,endDate: Date? = nil
        ,isEndAllDay: Bool = false
        ,relativeTo: Date? = nil
    ) -> String {
        
        let locale = Locale.current.identifier
        switch locale {
            
        case "en_US":
            return en_USdates(
                startDate
                ,isStartAllDay
                ,endDate
                ,isEndAllDay
                ,relativeTo
            )
            
        default:
            return localizedDates(
                startDate
                ,isAllDay: isStartAllDay
                ,endDate: endDate
                ,isEndAllDay: isEndAllDay
            )
        }
    }
    
    static func time(_ startDate: Date?) -> String {
        return en_UStime(startDate)
    }
    
    static func day(_ startDate: Date?) -> String {
        return en_USday(startDate)
    }
    
    // MARK: - Localized

    static func localizedDates(
        _ startDate: Date?
        ,isAllDay isStartAllDay: Bool = false
        ,endDate: Date? = nil
        ,isEndAllDay: Bool = false
    ) -> String {
        
        var startDateString = ""
        var endDateString = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        if let startDate = startDate {
            dateFormatter.timeStyle = (isStartAllDay) ? .none : .short
            dateFormatter.doesRelativeDateFormatting = true
            startDateString = dateFormatter.string(from: startDate)
        }
        
        if let endDate = endDate {
            dateFormatter.timeStyle = (isEndAllDay) ? .none : .short
            dateFormatter.doesRelativeDateFormatting = true
            endDateString = dateFormatter.string(from: endDate)
        }
        
        if startDateString.isEmpty {
            if endDateString.isEmpty {
                return ""
            }
            return "- \(endDateString)"
        } else {
            if endDateString.isEmpty {
                return startDateString
            }
            return "\(endDateString) - \(endDateString)"
        }
    }
    
    // MARK: - en_US
        
    // https://unicode.org/reports/tr35/tr35-dates.html#Date_Field_Symbol_Table
    
    static func en_USdates(
        _ startDate: Date?
        ,_ isStartAllDay: Bool?
        ,_ endDate: Date?
        ,_ isEndAllDay: Bool?
        ,_ relativeTo: Date?
    ) -> String {
                
        if let startDate = startDate {
            let calendar = Foundation.Calendar.current

            let relativeDate = relativeTo ?? Date()
            
            let todayComponents = calendar.dateComponents([.year, .month, .day], from: relativeDate)
            let startOfTodayDate = calendar.date(from: todayComponents)!

            let startComponents = calendar.dateComponents([.year, .month, .day], from: startDate)
            let startOfStartDate = calendar.date(from: startComponents)!

            let deltaStartComponents = Foundation.Calendar.current.dateComponents([.day], from: startOfTodayDate, to: startOfStartDate)

            var info = ""
            let startDayString = startDate.toString(formattedBy: "EEEE") // Wednesday
            let startDateString: String = {
                if startComponents.year == todayComponents.year {
                    return startDate.toString(formattedBy: "EE MMM d") // Wed Oct 3
                } else {
                    return startDate.toString(formattedBy: "EE MMM d yyyy") // Wed Oct 3 2022
                }
            }()
            let startTimeString = startDate.toString(formattedBy: "h:mm a") // 1:00 PM

            let hasStartTime = !(isStartAllDay ?? true)
            
            if let endDate = endDate {
                // Start and End Dates
                let endDateString = endDate.toString(formattedBy: "EE M/d/yyyy")
                let endTimeString = endDate.toString(formattedBy: "h:mm a")
                let hasEndTime = (endTimeString != "12:00 AM")

                // Start Date
                if let deltaDay = deltaStartComponents.day {
                    switch deltaDay {
                    case 0:
                        break

                    case 1...6:
                        info = "\(startDayString)"
                    default:
                        info = "\(startDateString)"
                    }
                }

                // Start Time
                if hasStartTime {
                    info = info.isEmpty ? "\(startTimeString)" : "\(info) \(startTimeString)"
                }

                // Seperator
                info = info.isEmpty ? "-" : "\(info) -"

                // End Date
                if startDateString != endDateString {
                    // Surpress the display of the endDate if it's the same as the startDate
                    info = "\(info) \(endDateString)"
                }

                // End Time
                if hasEndTime {
                    // Surpress the display of midnight
                    info = "\(info) \(endTimeString)"
                }

                // Duration
                var duration = endDate.timeIntervalSince(startDate) / 3_600
                if abs(duration) < 48.0 {
                    let durationString = String(format: "%.0f", duration)
                    info = "\(info) (\(durationString) hrs)"
                } else {
                    duration /= 24.0
                    let durationString = String(format: "%.0f", duration)
                    info = "\(info) (\(durationString) days)"
                }
                
            } else {
                // Just a Start Date
                if let deltaDay = deltaStartComponents.day {
                    switch deltaDay {
                    case 1:
                        info = "Tomorrow"
                    case 0:
                        info = "Today"
                    case -1:
                        info = "Yesterday"
                    default:
                        info = "\(startDateString)"
                    }
                    info = hasStartTime ? "\(info) \(startTimeString)" : "\(info)"
                }
            }
            return info
        }
        return ""
    }

    static func en_UStime(_ startDate: Date?) -> String {
        if let startDate = startDate {
            var info = ""
            let startTimeString = startDate.toString(formattedBy: "h:mm a")
            if startTimeString != "12:00 AM" {
                // Surpress the display of midnight
                info = "\(info)\(startTimeString)"
            }
            return info
        }
        return ""
    }

    static func en_USday(_ startDate: Date?) -> String {
        
        if let startDate = startDate {
            let calendar = Foundation.Calendar.current
            let todayComponents = calendar.dateComponents([.year, .month, .day], from: Date())
            let startOfTodayDate = calendar.date(from: todayComponents)!
            let startComponents = calendar.dateComponents([.year, .month, .day], from: startDate)
            let startOfStartDate = calendar.date(from: startComponents)!
            let deltaStartComponents = Foundation.Calendar.current.dateComponents([.year, .month, .day], from: startOfTodayDate, to: startOfStartDate)

            var relativeString = ""
            switch deltaStartComponents.day! {
            case -1:
                relativeString = " - Yesterday"
            case 0:
                relativeString = " - Today"
            case 1:
                relativeString = " - Tomorrow"
            default:
                break
            }
            let dateDayString = startDate.toString(formattedBy: "d EEEE")
            return "\(dateDayString)\(relativeString)"
        }
        return ""
    }
    
}

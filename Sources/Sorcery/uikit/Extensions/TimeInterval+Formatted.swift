//
//  TimeInterval.swift
//  Core
//
//  Created by John Cumming on 3/3/18.
//  Copyright © 2018 Silicon Sorcery. All rights reserved.
//

import Foundation

extension TimeInterval {
    /**
     Round to the nearest time block
     
     Blocks are minutes, hours, days, weeks, months
     */
    public func formatted() -> String {
        let minute: Double = 60
        let hour: Double = 60 * 60
        let day: Double = hour * 24
        let week: Double = day * 7
        let year: Double = day * 365.25

        let ago = (self < 0.0) ? " ago" : ""
        let duration = abs(self)

        if duration < minute * 60 {
            let result = duration / minute
            let units = (abs(1.0 - result) < 0.0001) ? "min" : "mins"
            return String(format: "%.2f \(units)\(ago)", result)
            
        } else if duration < hour * 36 {
            let result = duration / hour
            let units = (abs(1.0 - result) < 0.0001) ? "hour" : "hours"
            return String(format: "%.2f \(units)\(ago)", result)
            
        } else if duration < day * 14 {
            let result = duration / day
            let units = (abs(1.0 - result) < 0.0001) ? "day" : "days"
            return String(format: "%.2f \(units)\(ago)", result)
            
        } else if duration < week * 52 {
            let result = duration / week
            let units = (abs(1.0 - result) < 0.0001) ? "week" : "weeks"
            return String(format: "%.2f \(units)\(ago)", result)
            
        } else {
            let result = duration / year
            let units = (abs(1.0 - result) < 0.0001) ? "year" : "years"
            return String(format: "%.2f \(units)\(ago)", result)        }
    }
}

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
    func formatted() -> String {
        let minute: Double = 60
        let hour: Double = 60 * 60
        let day: Double = hour * 24
        let week: Double = day * 7
        let year: Double = day * 365.25

        let sign = (self < 0.0) ? "ago" : ""
        let duration = abs(self)

        if duration < minute * 60 {
            return String(format: "%.2f minutes \(sign)", duration / minute)
        } else if duration < hour * 36 {
            return String(format: "%.2f hours \(sign)", duration / hour)
        } else if duration < day * 14 {
            return String(format: "%.2f days \(sign)", duration / day)
        } else if duration < week * 52 {
            return String(format: "%.2f weeks \(sign)", duration / week)
        } else {
            return String(format: "%.2f years \(sign)", duration / year)
        }
    }
}

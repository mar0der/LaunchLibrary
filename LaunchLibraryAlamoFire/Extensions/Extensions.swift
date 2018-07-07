//
//  Extensions.swift
//  LaunchLibraryAlamoFire
//
//  Created by petar on 6/24/18.
//  Copyright © 2018 petar. All rights reserved.
//

import Foundation

extension Date {
    static func llDate(dateString:String) -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy HH:mm:ss Z"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let returnDate = dateFormatter.date(from:dateString)
        return returnDate
    }
    
    static func llDateToString(_ date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
        return dateFormatter.string(from: date)
    }
    
    static func getCurrent(with format:String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: Date())
    }
    
    static func tMinusCounter(to date:Date?) -> String{
        guard let date = date else {return "Unknown launch date"}
        let calendar = Calendar.current
        let today = Date()
        let diff = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date as Date, to: today)
        let secondSuffix = (diff.second == -1) ? "second" : "seconds"
        let secondsString = addLeadingZero(component: diff.second!)
        let minutesSuffix = (diff.minute == -1) ? "minute" : "minutes"
        let minutesString = addLeadingZero(component: diff.minute!)
        let hoursSuffix = (diff.hour == -1) ? "hour" : "hours"
        let hoursString = addLeadingZero(component: diff.hour!)
        let daysSuffix = (diff.day == -1) ? "day" : "days"
        let daysString = addLeadingZero(component: diff.day!)
        if diff.day == 0 && diff.hour == 0 && diff.minute == 0 && diff.second == 0{
            return "Liftoff"
        }
        return "T -\(daysString) \(daysSuffix), \(hoursString) \(hoursSuffix), \(minutesString) \(minutesSuffix), \(secondsString) \(secondSuffix)"
    }
    
    private static func addLeadingZero(component: Int) -> String {
        var componentString = abs(component).description
        if component > -10 && component <= 0 {
            componentString = "0" + componentString
        }
        return componentString
    }
}


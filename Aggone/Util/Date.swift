//
//  Date.swift
//  Aggone
//
//  Created by tiexiong on 3/21/19.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import Foundation

extension Date {
    static func from(year: Int, month: Int, day: Int)->Date {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        let calendar = Calendar.current
        return calendar.date(from: dateComponents)!
    }
}

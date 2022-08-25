//
//  String+Extensions.swift
//  WeatherAppPartB
//
//  Created by Mohamed Shazni on 2022-05-22.
//

import Foundation

extension Int {
    /// Converts OpenWeatherAPI Unix Date to Date
    ///  - Returns: Optional Date conversion
    func unixToDate() -> String? {
        return Date(timeIntervalSince1970: TimeInterval(self)).formatted(date: .long, time: .omitted)
    }
}


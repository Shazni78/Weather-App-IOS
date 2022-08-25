//
//  OCWeatherModel.swift
//  WeatherAppPartB
//
//  Created by Mohamed Shazni on 2022-05-22.
//

import Foundation
import SwiftUI

struct OCWeatherModel {
    let forecast: [OCWeatherDisplay]
    let hourlyForecasts: [OCWeatherDisplayHourly]
    let current: OCWeatherDisplayHourly
}

struct OCWeatherDisplay: Identifiable {
    let id = UUID()
    let dt: String
    let temp: String
    let pressure: Int
    let humidity: Int
    let clouds: Int
    let wind_speed: String
    let weather: Weather
    let icon: String
}

struct OCWeatherDisplayHourly: Identifiable {
    let id = UUID()
    let dt: String
    let temp: String
    let weather: Weather
    let icon: String
    let hour: Int
}



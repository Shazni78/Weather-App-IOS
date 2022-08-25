//
//  OneCallWeatherManager.swift
//  WeatherAppPartB
//
//  Created by Mohamed Shazni on 2022-05-22.
//

import Foundation

class OneCallWeatherManager: ObservableObject {
    
    let oneCallBaseURL: String = "https://api.openweathermap.org/data/2.5/onecall?exclude=minutely&appid=\(API.key)"
    
    
    // Lat and lon of Galle
    private let lat = 6.0329
    private let lon = 80.2168
    
    @Published var weather: OCWeatherModel?
    private var unit: WeatherUnit = .metric
    
    
    func getFiveDayForecast(unit: WeatherUnit) async {
        self.unit = unit
        let url = "\(oneCallBaseURL)&lat=\(lat)&lon=\(lon)&units=\(unit.rawValue)"
        await requestForecast(url: url)
    }
    
    
    func requestForecast(url: String) async {
        guard let url = URL(string: url) else { return }
        do {
            // Define a session for URL
            let (data, _) = try await URLSession.shared.data(from: url)
            // JSON  response to swift object
            let weather =  try JSONDecoder().decode(OneCallWeather.self, from: data)
            DispatchQueue.main.async {
                let forecasts = weather.daily.map { daily in
                    OCWeatherDisplay(dt: daily.dt.unixToDate()!,
                                     temp: self.unit == .metric ? "\(daily.temp.day)°C" : "\(daily.temp.day)°F",
                                     pressure: daily.pressure,
                                     humidity: daily.humidity,
                                     clouds: daily.clouds,
                                     wind_speed: self.unit == .metric ? "\(daily.wind_speed) m/s" : "\(daily.wind_speed) mi/h",
                                     weather: daily.weather.first!,
                                     icon: self.getIcon(id: daily.weather.first!.id))
                }
                
                let first = weather.hourly.first!
                let current = OCWeatherDisplayHourly(dt: first.dt.unixToDate(date: .complete, time: .shortened)!,
                                                     temp: self.unit == .metric ? "\(first.temp)°C" : "\(first.temp)°F",
                                                     weather: first.weather.first!,
                                                     icon: self.getIcon(id: first.weather.first!.id),
                                                     hour: first.dt.unixToDate()!.get(.hour))
                
                
                var hourly = weather.hourly.map { hourly in
                    OCWeatherDisplayHourly(dt: hourly.dt.unixToDate(date: .omitted, time: .shortened)!,
                                           temp: self.unit == .metric ? "\(hourly.temp)°C" : "\(hourly.temp)°F",
                                           weather: hourly.weather.first!,
                                           icon: self.getIcon(id: hourly.weather.first!.id),
                                           hour: hourly.dt.unixToDate()!.get(.hour))
                }
                
                //hourly 
                hourly = hourly.filter({ item in
                    return item.hour % 3 == 0
                })
                
                self.weather = OCWeatherModel(forecast: forecasts,
                                              hourlyForecasts: hourly,
                                              current: current)
            }
            print("OneCallOutput: ",weather)
        } catch {
            print("OneCallError: ",error.localizedDescription)
        }
    }
    
    func getIcon(id: Int) -> String {
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}


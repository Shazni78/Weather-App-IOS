//
//  IntervalWeatherView.swift
//  WeatherAppPartB
//
//  Created by Mohamed Shazni on 2022-05-21.
//

import SwiftUI

struct IntervalWeatherView: View {
    
    @State private var unit: WeatherUnit = .metric
    @StateObject private var manager = OneCallWeatherManager()
    
    var body: some View {
        VStack {
            if let data = manager.weather {
                if let current = data.current {
                    Text("\(current.dt)")
                    HStack {
                        Image(systemName: current.icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                        Text(current.temp)
                            .font(.system(size: 60, weight: .black, design: .rounded))
                            .foregroundColor(.yellow)
                    }
                    Text("Drizzly")
                }
                List (data.hourlyForecasts) { item in
                    HStack(spacing: 20) {
                        Image(systemName: item.icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .foregroundColor(.cyan)
                        VStack (alignment: .leading) {
                            Text(item.weather.description)
                            Text(item.dt)
                        }
                        Spacer()
                        Text("\(item.temp)")
                    }
                }
                .listStyle(PlainListStyle())
            } else {
                Spacer()
            }
        }
        .onAppear {
            Task {
                await manager.getFiveDayForecast(unit: self.unit)
            }
        }
    }
}

struct IntervalWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        IntervalWeatherView()
    }
}


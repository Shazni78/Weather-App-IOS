//
//  ContentView.swift
//  WeatherAppPartB
//
//  Created by Mohamed Shazni on 2022-05-21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            SearchView()
                .tabItem {
                    Label("Current", systemImage: "magnifyingglass")
                }
            ForecastView()
                .tabItem {
                    Label("Forecast", systemImage: "goforward")
                }
            IntervalWeatherView()
                .tabItem {
                    Label("Intervals", systemImage: "deskclock")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

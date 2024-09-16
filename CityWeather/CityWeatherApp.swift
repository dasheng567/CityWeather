//
//  CityWeatherApp.swift
//  CityWeather
//
//  Created by Chen Big on 9/16/24.
//

import SwiftUI

@main
struct CityWeatherApp: App {

    var body: some Scene {
        WindowGroup {
            let viewModel = WeatherViewModel()
            WeatherView(viewModel: viewModel)
        }
    }
}

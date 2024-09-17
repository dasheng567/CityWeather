//
//  Coordinator.swift
//  CityWeather
//
//  Created by Chen Big on 9/16/24.
//

import UIKit
import SwiftUI

class WeatherCoordinator: ObservableObject {

    // Display WeatherView as home page of the project
    func start() -> some View {
        let viewModel = WeatherViewModel(coordinator: self)
        return WeatherView(viewModel: viewModel)
            .navigationViewStyle(StackNavigationViewStyle())
    }

    // Navigate to WeatherDetail page
    func showWeatherDetail(weatherDetailsDataModel: WeatherDetailsDataModel) -> some View {
        return WeatherDetailView(weatherDetailsDataModel: weatherDetailsDataModel)
    }
}

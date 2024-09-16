//
//  WeatherViewModel.swift
//  CityWeather
//
//  Created by Chen Big on 9/16/24.
//

import Foundation
import Combine

final class WeatherViewModel: ObservableObject {
    @Published var cityName = ""
    @Published private(set) var weatherDetailsDataModel: WeatherDetailsDataModel?
    @Published private(set) var errorMessage: String?

    private let weatherService: NetworkServices
    let coordinator: WeatherCoordinator

    // Set Dependency Injection on initializer
    init(weatherService: NetworkServices = WeatherService.shared as NetworkServices,
         coordinator: WeatherCoordinator = WeatherCoordinator()) {
        self.weatherService = weatherService
        self.coordinator = coordinator
    }

    // Fetch weather data by city name
    func fetchCityWeather() {
        weatherService.fetchWeather(withCity: cityName) { [weak self] result in
            switch result {
            case .success(let weatherResponse):
                self?.weatherDetailsDataModel = WeatherDetailsDataModel(weather: weatherResponse)
                self?.errorMessage = nil
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
        }
    }

    // Fetch weather data by location information
    func fetchLocationWeather(lat: Double, lon: Double) {
        weatherService.fetchWeather(withLatitude: lat, withLongitude: lon) { [weak self] result in
            switch result {
            case .success(let weatherResponse):
                self?.weatherDetailsDataModel = WeatherDetailsDataModel(weather: weatherResponse)
                DispatchQueue.main.async {
                    self?.cityName = weatherResponse.name ?? "Error Location"
                }
                self?.errorMessage = nil
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
        }
    }
}

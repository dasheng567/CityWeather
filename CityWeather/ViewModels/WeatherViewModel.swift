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

    private let userDefault: UserDefaults
    private let weatherService: NetworkServices
    private let locationManager: LocationManager
    let coordinator: WeatherCoordinator

    // Set Dependency Injection on initializer
    init(userDefault: UserDefaults = UserDefaults.standard,
         weatherService: NetworkServices = WeatherService.shared as NetworkServices,
         locationManager: LocationManager = LocationManager.shared,
         coordinator: WeatherCoordinator = WeatherCoordinator()) {
        self.userDefault = userDefault
        self.weatherService = weatherService
        self.locationManager = locationManager
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

    // Setup the default city weather when lanching the device
    func setupDefaultWeather() {
        if let status = locationManager.permissionStatus {
            switch status {
            // Display user's city weather if location permission allowed
            case .authorizedAlways, .authorizedWhenInUse:
                if let location = locationManager.location {
                    fetchLocationWeather(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
                }
            // Request for user's permission of location
            case .notDetermined:
                locationManager.requestLocation()
            // Display the last searched city weather if location permission is not allowed by user, or due to location restriction
            case .denied, .restricted:
                if let lastCity = loadLastSearchedCity() {
                    cityName = lastCity
                    fetchCityWeather()
                }
            @unknown default:
                break
            }
        }
    }

    // Save searched city into Local storage
    func saveLastSearchedCity() {
        UserDefaults.standard.set(cityName, forKey: "LastSearchedCity")
    }

    // Try to get last searched city from Local storage
    private func loadLastSearchedCity() -> String? {
        return UserDefaults.standard.string(forKey: "LastSearchedCity")
    }
}

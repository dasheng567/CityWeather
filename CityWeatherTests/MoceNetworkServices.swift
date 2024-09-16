//
//  MoceNetworkServices.swift
//  CityWeatherTests
//
//  Created by Chen Big on 9/16/24.
//

import Foundation
@testable import CityWeather

class MockNetworkService: NetworkServices {
    // Boolean value to determine if testing error service
    var shouldReturnError = false
    let weatherData = MockWeatherData().weatherData

    func fetchWeather(withCity city: String, completion: @escaping (Result<WeatherResponse, any Error>) -> Void) {
        // Mock service error
        if shouldReturnError {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock error"])))
        } else {
            let weatherData = weatherData.data(using: .utf8)!
            let weather = try? JSONDecoder().decode(WeatherResponse.self, from: weatherData)
            completion(.success(weather!))
        }
    }

    func fetchWeather(withLatitude lat: Double, withLongitude lon: Double, completion: @escaping (Result<WeatherResponse, any Error>) -> Void) {
        // Mock service error
        if shouldReturnError {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock error"])))
        } else {
            let weatherData = weatherData.data(using: .utf8)!
            let weather = try? JSONDecoder().decode(WeatherResponse.self, from: weatherData)
            completion(.success(weather!))
        }
    }
}

struct MockWeatherData {
    let weatherData = """
    {
      "coord": {
        "lon": -0.13,
        "lat": 51.51
      },
      "weather": [
        {
          "id": 300,
          "main": "Drizzle",
          "description": "light intensity drizzle",
          "icon": "09d"
        }
      ],
      "base": "stations",
      "main": {
        "temp": 280.32,
        "pressure": 1012,
        "feels_like": 280.15,
        "humidity": 81,
        "temp_min": 279.15,
        "temp_max": 281.15
      },
      "visibility": 10000,
      "wind": {
        "speed": 4.1,
        "deg": 80
      },
      "clouds": {
        "all": 90
      },
      "dt": 1485789600,
      "sys": {
        "type": 1,
        "id": 5091,
        "message": 0.0103,
        "country": "GB",
        "sunrise": 1485762037,
        "sunset": 1485794875
      },
      "id": 2643743,
      "name": "London",
      "cod": 200
    }
    """
}

//
//  WeatherResponse.swift
//  CityWeather
//
//  Created by Chen Big on 9/16/24.
//

// Weather response from API with needed attributes
struct WeatherResponse: Codable {
    let weather: [Weather]?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let name: String?
    let cod: Int?

    struct Weather: Codable {
        let main: String?
        let description: String?
        let icon: String?
    }

    struct Main: Codable {
        let temp: Double?
        let feelsLike: Double?
        let tempMin: Double?
        let tempMax: Double?
        let humidity: Int?

        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case humidity
        }
    }

    struct Wind: Codable {
        let speed: Double?
    }
}

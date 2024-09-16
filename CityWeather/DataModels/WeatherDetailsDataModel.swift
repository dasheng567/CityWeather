//
//  WeatherDetailsDataModel.swift
//  CityWeather
//
//  Created by Chen Big on 9/16/24.
//

struct WeatherDetailsDataModel {
    let cityName: String
    let weather: String
    let weatherDescription: String
    let weatherIcon: String
    let temperature: String
    let feelsLike: String
    let temperatureMin: String
    let temperatureMax: String
    let humidity: String
    let visibility: String
    let windSpeed: String

    init?(weather: WeatherResponse) {
        guard let icon = weather.weather?.first?.icon else { return nil }
        self.cityName = weather.name ?? "N/A"
        self.weather = weather.weather?.first?.main ?? "N/A"
        self.weatherDescription = weather.weather?.first?.description ?? "N/A"
        self.weatherIcon = Constants.URLs.iconBaseURL + icon + Constants.URLs.iconURLSuffix
        if let temperature = weather.main?.temp {
            self.temperature = String(temperature)
        } else {
            self.temperature = "N/A"
        }
        if let feelsLike = weather.main?.feelsLike {
            self.feelsLike = String(feelsLike)
        } else {
            self.feelsLike = "N/A"
        }
        if let temperatureMin = weather.main?.tempMin {
            self.temperatureMin = String(temperatureMin)
        } else {
            self.temperatureMin = "N/A"
        }
        if let temperatureMax = weather.main?.tempMax {
            self.temperatureMax = String(temperatureMax)
        } else {
            self.temperatureMax = "N/A"
        }
        if let humidity = weather.main?.humidity {
            self.humidity = String(humidity)
        } else {
            self.humidity = "N/A"
        }
        if let visibility = weather.visibility {
            self.visibility = String(visibility)
        } else {
            self.visibility = "N/A"
        }
        if let windSpeed = weather.wind?.speed {
            self.windSpeed = String(windSpeed)
        } else {
            self.windSpeed = "N/A"
        }
    }
}

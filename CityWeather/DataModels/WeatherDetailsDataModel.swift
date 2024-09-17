//
//  WeatherDetailsDataModel.swift
//  CityWeather
//
//  Created by Chen Big on 9/16/24.
//

struct WeatherDetailsDataModel {
    let cityName: (String, String)
    let weather: String
    let weatherDescription: (String, String)
    let weatherIcon: String
    let temperature: (String, String)
    let feelsLike: (String, String)
    let temperatureMin: (String, String)
    let temperatureMax: (String, String)
    let humidity: (String, String)
    let visibility: (String, String)
    let windSpeed: (String, String)

    init?(weather: WeatherResponse) {
        guard let icon = weather.weather?.first?.icon else { return nil }
        self.cityName = ("City Name", weather.name ?? "N/A")
        self.weather = weather.weather?.first?.main ?? "N/A"
        self.weatherDescription = ("Weather Description", weather.weather?.first?.description ?? "N/A")
        self.weatherIcon = Constants.URLs.iconBaseURL + icon + Constants.URLs.iconURLSuffix
        if let temperature = weather.main?.temp {
            self.temperature = ("Temperature", String(temperature) + "°C")
        } else {
            self.temperature = ("Temperature", "N/A")
        }
        if let feelsLike = weather.main?.feelsLike {
            self.feelsLike = ("Feels Like", String(feelsLike) + "°C")
        } else {
            self.feelsLike = ("Feels Like", "N/A")
        }
        if let temperatureMin = weather.main?.tempMin {
            self.temperatureMin = ("Minimum Temperature", String(temperatureMin) + "°C")
        } else {
            self.temperatureMin = ("Minimum Temperature", "N/A")
        }
        if let temperatureMax = weather.main?.tempMax {
            self.temperatureMax = ("Maximum Temperature", String(temperatureMax) + "°C")
        } else {
            self.temperatureMax = ("Maximum Temperature", "N/A")
        }
        if let humidity = weather.main?.humidity {
            self.humidity = ("Humidity", String(humidity) + "%")
        } else {
            self.humidity = ("Humidity", "N/A")
        }
        if let visibility = weather.visibility {
            self.visibility = ("Visibility", String(visibility/1000) + "km")
        } else {
            self.visibility = ("Visibility", "N/A")
        }
        if let windSpeed = weather.wind?.speed {
            self.windSpeed = ("Wind Speed", String(windSpeed) + "m/s")
        } else {
            self.windSpeed = ("Wind Speed", "N/A")
        }
    }
}

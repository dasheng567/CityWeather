//
//  NetwrokServices.swift
//  CityWeather
//
//  Created by Chen Big on 9/16/24.
//

import Foundation

// Add protocol to make services call able to be mocked and tested
protocol NetworkServices {
    func fetchWeather(withCity city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void)
    func fetchWeather(withLatitude lat: Double, withLongitude lon: Double, completion: @escaping (Result<WeatherResponse, Error>) -> Void)
}

class WeatherService: NetworkServices {
    // Use Singleton pattern, to make the weather service have only one instance, and provide a global point of access to it
    static let shared = WeatherService()

    private init() { }

    func fetchWeather(withLatitude lat: Double, withLongitude lon: Double, completion: @escaping (Result<WeatherResponse, any Error>) -> Void) {

        // To avoid the Xcode type check failure, make separate short URL strings
        let latURL = Constants.URLs.lat + String(lat)
        let lonURL = Constants.URLs.lon + String(lon)
        let appKeyURL = Constants.URLs.appId + Constants.URLs.APIKey

        guard let url = URL(string: Constants.URLs.baseWeatherURL + latURL + lonURL + appKeyURL) else { return } // Given more time, I would implement configurations/localizable to avoid this long strings here

        // Setup request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept") // To make the Accept Header as Json type

        // Call fetch task in background thread
        DispatchQueue.global().async {
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                if let error {
                    completion(.failure(error))
                    return
                }

                if let data {
                    do {
                        let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                        completion(.success(weatherResponse))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }

            task.resume()
        }
    }

    func fetchWeather(withCity city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        guard let url = URL(string: Constants.URLs.baseWeatherURL + Constants.URLs.city + city + Constants.URLs.appId + Constants.URLs.APIKey) else { return } // Given more time, I would implement configurations/localizable to avoid this long strings here

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept") // To make the Accept Header as Json type

        // Call fetch task in background thread
        DispatchQueue.global().async {
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                if let error {
                    // Need to exexute the completion handler on the main queue
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
                if let data {
                    do {
                        let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                        // Need to exexute the completion handler on the main queue
                        DispatchQueue.main.async {
                            completion(.success(weatherResponse))
                        }
                    } catch {
                        // Need to exexute the completion handler on the main queue
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                }
            }

            task.resume()
        }
    }
}

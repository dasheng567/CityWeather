//
//  WeatherViewModelTests.swift
//  CityWeatherTests
//
//  Created by Chen Big on 9/16/24.
//

import XCTest
@testable import CityWeather


// Given more time, I will create mock location manager, mock UserDefault, to add more unit tests for setupDefaultWeather flow, and saveLastSearchedCity flow
class WeatherViewModelTests: XCTestCase {
    func testCityWeatherFetchSuccess() {
        // Given
        let mockService = MockNetworkService()
        let viewModel = WeatherViewModel(weatherService: mockService)

        // When
        viewModel.cityName = "London"
        viewModel.fetchCityWeather()

        // Then
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.weatherDetailsDataModel?.weather, "Drizzle")
        XCTAssertEqual(viewModel.weatherDetailsDataModel?.cityName.1, "London")
        XCTAssertEqual(viewModel.weatherDetailsDataModel?.weatherDescription.1, "light intensity drizzle")
        XCTAssertEqual(viewModel.weatherDetailsDataModel?.humidity.1, "81%")
        XCTAssertEqual(viewModel.weatherDetailsDataModel?.temperature.1, "280.32°C")
        XCTAssertEqual(viewModel.weatherDetailsDataModel?.feelsLike.1, "280.15°C")
        XCTAssertEqual(viewModel.weatherDetailsDataModel?.temperatureMax.1, "281.15°C")
        XCTAssertEqual(viewModel.weatherDetailsDataModel?.temperatureMin.1, "279.15°C")
        XCTAssertEqual(viewModel.weatherDetailsDataModel?.windSpeed.1, "4.1m/s")
        XCTAssertEqual(viewModel.weatherDetailsDataModel?.visibility.1, "10km")
    }

    func testLocationWeatherFetchSuccess() {
        // Given
        let mockService = MockNetworkService()
        let viewModel = WeatherViewModel(weatherService: mockService)

        // When
        viewModel.fetchLocationWeather(lat: 0.0, lon: 0.0)

        // Then
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.weatherDetailsDataModel?.weather, "Drizzle")
        XCTAssertEqual(viewModel.weatherDetailsDataModel?.cityName.1, "London")
        XCTAssertEqual(viewModel.weatherDetailsDataModel?.weatherDescription.1, "light intensity drizzle")
        XCTAssertEqual(viewModel.weatherDetailsDataModel?.humidity.1, "81%")
        XCTAssertEqual(viewModel.weatherDetailsDataModel?.temperature.1, "280.32°C")
        XCTAssertEqual(viewModel.weatherDetailsDataModel?.feelsLike.1, "280.15°C")
        XCTAssertEqual(viewModel.weatherDetailsDataModel?.temperatureMax.1, "281.15°C")
        XCTAssertEqual(viewModel.weatherDetailsDataModel?.temperatureMin.1, "279.15°C")
        XCTAssertEqual(viewModel.weatherDetailsDataModel?.windSpeed.1, "4.1m/s")
        XCTAssertEqual(viewModel.weatherDetailsDataModel?.visibility.1, "10km")
    }

    func testCityWeatherFetchFailure() {
        // Given
        let mockService = MockNetworkService()
        let viewModel = WeatherViewModel(weatherService: mockService)

        // When
        mockService.shouldReturnError = true
        viewModel.cityName = "Unknown"
        viewModel.fetchCityWeather()

        // Then
        XCTAssertEqual(viewModel.errorMessage, "Mock error")
    }

    func testLocationWeatherFetchFailure() {
        // Given
        let mockService = MockNetworkService()
        let viewModel = WeatherViewModel(weatherService: mockService)

        // When
        mockService.shouldReturnError = true
        viewModel.fetchLocationWeather(lat: 0.0, lon: 0.0)

        // Then
        XCTAssertEqual(viewModel.errorMessage, "Mock error")
    }
}

//
//  WeatherDetailsView.swift
//  CityWeather
//
//  Created by Chen Big on 9/16/24.
//

import SwiftUI

struct WeatherDetailView: View {
    let weatherDetailsDataModel: WeatherDetailsDataModel

    var body: some View {
        VStack {
            Text("Weather details for \(weatherDetailsDataModel.cityName.1)")
                .font(.title)
                .padding()
                .accessibilityLabel("City Name")

            Spacer()

            // Display the icon using AsyncImage, which has cache feature itself
            AsyncImage(url: URL(string: weatherDetailsDataModel.weatherIcon)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()          // Add progress indicator
            }

            Spacer()

            List {
                WeatherDetailsListView(weatherDetailsItem: weatherDetailsDataModel.cityName)
                WeatherDetailsListView(weatherDetailsItem: weatherDetailsDataModel.weatherDescription)
                WeatherDetailsListView(weatherDetailsItem: weatherDetailsDataModel.humidity)
                WeatherDetailsListView(weatherDetailsItem: weatherDetailsDataModel.temperature)
                WeatherDetailsListView(weatherDetailsItem: weatherDetailsDataModel.feelsLike)
                WeatherDetailsListView(weatherDetailsItem: weatherDetailsDataModel.temperatureMax)
                WeatherDetailsListView(weatherDetailsItem: weatherDetailsDataModel.temperatureMin)
                WeatherDetailsListView(weatherDetailsItem: weatherDetailsDataModel.windSpeed)
                WeatherDetailsListView(weatherDetailsItem: weatherDetailsDataModel.visibility)
            }
        }
        .navigationTitle(weatherDetailsDataModel.cityName.1)
    }
}

struct WeatherDetailsListView: View {
    let weatherDetailsItem: (String, String)
    var body: some View {
        HStack {
            Text(weatherDetailsItem.0)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(weatherDetailsItem.1)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

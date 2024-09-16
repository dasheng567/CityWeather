//
//  WeatherView.swift
//  CityWeather
//
//  Created by Chen Big on 9/16/24.
//

import SwiftUI

struct WeatherView: View {
    // Subscribe to view model to make data parsing smoothly
    @ObservedObject var viewModel: WeatherViewModel

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter city name", text: $viewModel.cityName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .accessibilityLabel("City name")

                Button("Search") {
                    viewModel.fetchCityWeather()
                }
                .padding()
                .accessibilityLabel("Search button")

                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .accessibilityLabel("Error message")
                } else {
                    Text(viewModel.weatherDetailsDataModel?.weather ?? "")
                        .font(.largeTitle)
                        .padding()
                        .accessibilityLabel("Main Weather")
                }
            }
            .navigationTitle("City Weather Search")
        }
    }
}


#Preview {
    WeatherView(viewModel: WeatherViewModel())
}

# City Weather App

The City Weather App is a SwiftUI-based weather application that allows users to search for the weather details of any city. The app provides current weather information and weather details for searched cities. Additionally, it supports location-based weather retrieval and offers a seamless user experience by saving previous search results for future reference.

## Features

- **City Search**: Users can search for any city worldwide to get current weather information and detailed weather stats.
- **Location-based Weather**: Users will be prompted to grant location permission.
  - **If permission is granted**, the app will display the current weather for the user's location by default.
  - **If permission is denied**, the app will automatically show the weather for the last searched city by default.
- **Weather Details**: Each search provides real-time weather data, including weather type, description, and the icon.
- **Persistent Data**: The app stores the last searched city to ensure users always have access to their latest search data.
- **User-friendly Interface**: Clean, minimal, and responsive design, suitable for all iPhone sizes and orientations.

## Architecture

This app is built using the **MVVM-C architecture**, which ensures a separation of concerns and promotes modular, testable code. The app includes:
- **ViewModel**: Manages the business logic, binds data to the views, and handles network requests.
- **Coordinator**: Handles navigation and flow control between screens.
- **Dependency Injection**: Ensures testability and flexibility of the app components.

## Technologies Used

- **SwiftUI** for UI rendering and layout.
- **MVVM-C Architecture** for clean and maintainable code.
- **CoreLocation** for handling location services and permissions.
- **Combine** for reactive data binding.
- **Unit Testing** for ensuring code reliability and quality.

## Requirements

- **Xcode 15.4** or higher.
- **iOS 17.5** or higher.
- **macOS Sonoma 14.6.1** or higher for development.

## Installation

1. Clone the repository.
2. Open the project in Xcode.
3. Build and run the project on your device or simulator.

## Demo
[CityWeather-AllowedLocation](https://drive.google.com/file/d/1FgQW4r5fILSJplbgpQpBsl9UAYL0uZ4k/view?usp=drive_link)

[CityWeather-DeniedLocation](https://drive.google.com/file/d/1musipBQEhAimKNGF1zz9wdNBYdh5-cCt/view?usp=drive_link)

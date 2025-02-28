# my-weather-app

# Weather Forecast App

## Overview

This is a SwiftUI-based Weather Forecast App that provides weather details using an external API. The app features:

- Real-time weather updates
- Forecast for upcoming days
- Beautiful, intuitive UI
- Location support
## Weather API key: http://api.weatherapi.com/v1/forecast.json?key=b94801885e204d72aab141008252702&q=Mumbai&days=7&aqi=no&alerts=no

## Setup Instructions

### Prerequisites

- macOS with Xcode installed (Latest version recommended)
- An API key from [WeatherAPI](https://www.weatherapi.com/)

### Installation Steps

   ```
Directly download and use the .zip file of project for simple and easy integration.

1. **Open Project in Xcode:**

   - Open `my weather app.xcodeproj` in Xcode.

2. **Install Dependencies:**

   - This project uses `Alamofire` for networking. Install dependencies via Swift Package Manager (SPM) if not already added.
   - for network calls to be made go to project info and add new row "App Transport Security Settings" then click on the '+' sign shown
      just on the side of "App Transport Security Settings" search 'allow arbitary loads' select it and select value YES.

   - Also check if there is only "Alamofire" in 'Link Binary with libraries' inside 'Build phases' in the project,remove any other linked binaries if present.
  
3. **Run the App:**

   - Select an iOS Simulator or connected device.
   - Press `Cmd + R` or click the **Run** button in Xcode.

## Implementation Details

- **Networking:** Uses `Alamofire` to fetch weather data.
- **Data Model:** The `WeatherModel.swift` handles JSON parsing.
- **UI:** `ContentView.swift` and `WeatherDetailView.swift` display weather details with animations and gradients.
- **State Management:** Uses `@State`, `@Binding`, and `@ObservedObject`.

## Design Decisions

- **SwiftUI for modern UI components.**
- **Dark mode support with background color adaptation.**
- **Navigation with **``**.**

## Future Enhancements

- Add hourly forecast view.
- Improve animations and transitions.
- Implement offline caching.

## Contribution

Feel free to fork, improve, and submit a PR!

## License

MIT License. See `LICENSE` for details.


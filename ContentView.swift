//
//  ContentView.swift
//  WeatherApp
//
//  Created by Dawid Nowacki on 06/02/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var viewModel = WeatherViewModel()
    
    // Default coordinates for Aarhus
    private let defaultLatitude = 56.1629
    private let defaultLongitude = 10.2039
    
    var body: some View {
        NavigationView {
            ZStack {
                // Dynamic Background
                WeatherBackground(weather: viewModel.title, isNight: isNightTime())
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    if locationManager.locationDenied {
                        // Weather for Aarhus
                        Text("Location access denied.")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding([.leading, .trailing], 20)  // Horizontal padding
                            .padding([.top, .bottom], 16)  // Vertical padding
                            .frame(maxWidth: .infinity)  // Make the text take the full available width
                            .background(Color.black.opacity(0.6))  // Optional background for readability
                            .cornerRadius(10)
                                
                                Text("Showing default weather for Aarhus.")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .padding([.leading, .trailing], 20)  // Horizontal padding
                                    .padding([.top, .bottom], 16)  // Vertical padding
                                    .frame(maxWidth: .infinity)  // Make the text take the full available width
                                    .background(Color.black.opacity(0.6))  // Optional background for readability
                                    .cornerRadius(10)
                    }
                    
                    Text(viewModel.timezone)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text(viewModel.temp) // Show the formatted temperature
                        .font(.system(size: 64, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text(viewModel.title)
                        .font(.system(size: 28, weight: .medium))
                        .foregroundColor(.white)
                    
                    Text(viewModel.descriptionText.capitalized)
                        .font(.system(size: 20, weight: .light))
                        .foregroundColor(.white)
                    
                    // Show current location in the console if available
                    if let location = locationManager.userLocation {
                        Text("Current location: \(location.latitude), \(location.longitude)")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                .padding()
            }
            .onAppear {
                // Fetch weather for the user's location as soon as the app appears
                if let location = locationManager.userLocation {
                    viewModel.fetchWeather(for: location.latitude, longitude: location.longitude)
                } else {
                    // If location is unavailable, fetch default weather
                    viewModel.fetchWeather(for: defaultLatitude, longitude: defaultLongitude)
                }
            }
            .onChange(of: locationManager.userLocation) { newLocation in
                if let location = newLocation {
                    // Fetch weather whenever location changes (including simulated location)
                    viewModel.fetchWeather(for: location.latitude, longitude: location.longitude)
                }
            }
            .navigationTitle("Weather App")
        }
    }
    
    // Helper to determine if it's night based on current time
    private func isNightTime() -> Bool {
        let hour = Calendar.current.component(.hour, from: Date())
        return hour < 6 || hour >= 18
    }
}

// Dynamic Background View
struct WeatherBackground: View {
    let weather: String
    let isNight: Bool
    
    var body: some View {
        Group {
            if isNight {
                if weather.lowercased().contains("clear") {
                    // Night with clear sky
                    Image("stars_background")
                        .resizable()
                        .scaledToFill()
                } else {
                    // Cloudy or snowy night
                    Image("night_cloudy_background")
                        .resizable()
                        .scaledToFill()
                }
            } else {
                if weather.lowercased().contains("clear") {
                    // Day with clear sky
                    Image("sunny_background")
                        .resizable()
                        .scaledToFill()
                } else if weather.lowercased().contains("cloud") {
                    // Cloudy day
                    Image("cloudy_background")
                        .resizable()
                        .scaledToFill()
                } else if weather.lowercased().contains("snow") {
                    // Snowy weather
                    Image("snow_background")
                        .resizable()
                        .scaledToFill()
                } else {
                    // Default for day
                    Image("default_day_background")
                        .resizable()
                        .scaledToFill()
                }
            }
        }
    }
}

// Preview
#Preview {
    ContentView()
}

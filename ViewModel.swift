//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Dawid Nowacki on 06/02/2024.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var descriptionText: String = ""
    @Published var temp: String = ""
    @Published var timezone: String = ""
    
    private var apiKey: String {
        ProcessInfo.processInfo.environment["API_KEY"] ?? ""
    }
    
    func fetchWeather(for latitude: Double, longitude: Double) {
        // Debugging: Print the full URL to verify it's correctly formatted
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&units=metric&appid=\(apiKey)"
        print("API URL: \(urlString)") // Debug print URL
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error during API call: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data returned from API")
                return
            }

            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(CurrentWeatherModel.self, from: data)
                
                // Debugging: Print the entire model response
                print("API Response: \(model)")
                print("Temperature: \(model.main.temp)") // Debug print temperature
                
                DispatchQueue.main.async {
                    self.title = model.weather.first?.main ?? "No title"
                    self.descriptionText = model.weather.first?.description ?? "No description"
                    
                    // Format temperature to an integer (rounded to the nearest whole number)
                    let roundedTemp = Int(model.main.temp.rounded())
                    self.temp = "\(roundedTemp)°"
                    self.timezone = model.name
                }
            } catch {
                print("Decoding failed: \(error)")
            }
        }
        task.resume()
    }
}

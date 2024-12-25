//
//  Model.swift
//  WeatherApp
//
//  Created by Dawid Nowacki on 06/02/2024.
//

import Foundation

struct CurrentWeatherModel: Codable {
    let weather: [WeatherDetails]
    let main: MainWeather
    let name: String
}

struct WeatherDetails: Codable {
    let main: String
    let description: String
}

struct MainWeather: Codable {
    let temp: Double
}

//
//  WeatherData.swift
//  Weather
//
//  Created by Şükrü Şimşek on 14.10.2023.
//

import Foundation

struct WeatherData: Codable {
    let main: Main
    let name: String
    let weather: [Weather]
}
struct Main: Codable {
    let temp: Double
}
struct Weather: Codable {
    let description: String
    let id: Int
}


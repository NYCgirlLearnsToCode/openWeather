//
//  NYWeather.swift
//  openWeather
//
//  Created by Lisa J on 7/24/24.
//

import Foundation

enum JSONError: Error {
    case decodingError(Error)
}

struct NYWeather: Codable {
    let weather: [WeatherWrapper]
    let main: MainWrapper
    let name: String
    
    static func getWeather(from data: Data) throws -> NYWeather {
        do {
            let weatherAttributes = try JSONDecoder().decode(NYWeather.self, from: data)
            return weatherAttributes
        } catch {
            throw JSONError.decodingError(error)
        }
    }
}

struct WeatherWrapper: Codable {
    let main: String
}

struct MainWrapper: Codable {
    let temp: CGFloat
    let feelsLike: CGFloat
    let minTemp: CGFloat
    let maxTemp: CGFloat
    let pressure: Int
    let humidity: Int
    
    private enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
        case pressure
        case humidity
    }
}

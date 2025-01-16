//
//  Model.swift

import Foundation

struct WeatherResponse: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
    let rain: Rain?
}

// Координаты
struct Coord: Codable {
    let lon: Double
    let lat: Double
}

// Погода (массив)
struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

// Основные данные (температура, давление, влажность)
struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
    let seaLevel: Int?
    let grndLevel: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

// Данные о ветре
struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double?
}

// Облачность
struct Clouds: Codable {
    let all: Int
}

// Система (страна, рассвет, закат)
struct Sys: Codable {
    let type: Int?
    let id: Int?
    let country: String
    let sunrise: Int
    let sunset: Int
}

// Дождь
struct Rain: Codable {
    let oneHour: Double?

    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
    }
}
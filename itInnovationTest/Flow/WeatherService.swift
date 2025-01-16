//
//  WeatherService.swift

import Foundation

class WeatherService {
    private let apiKey = "dea03e5c5bd3208545c0a5a99c58241e"

    func fetchWeather(lat: Double, lon: Double, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Некорректный URL", code: -1, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Нет данных", code: -2, userInfo: nil)))
                return
            }
            
            do {
                let weatherData = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(.success(weatherData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

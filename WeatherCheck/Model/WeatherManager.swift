//
//  WeatherManager.swift
//  WeatherCheck
//
//  Created by Евгений Лянкэ on 12.02.2022.
//

import Foundation
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager:WeatherManager,weather:WeatherModel)
    func didFailWithError(error:Error)
}
struct WeatherManager {
    let mainURL = "https://api.openweathermap.org/data/2.5/weather?appid=b4f9767154c5671a5cdaf230c9d62500&units=metric&"
    var delegate:WeatherManagerDelegate?
    func fetchWeather(cityName: String) {
        let urlString = "\(mainURL)q=\(cityName)"
        performRequest(with: urlString)
    }
    func fetchWeather(latitude:Double,longitude:Double) {
        let urlString = "\(mainURL)lat=\(latitude)&lon=\(longitude)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString:String) {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let  task = session.dataTask(with: url) { data, urlResponse, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let  safeData = data {
                    if let weather = parseJson(safeData){
                        delegate?.didUpdateWeather(self,weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJson(_ weatherData:Data)->WeatherModel?  {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let city = decodedData.name
            return  WeatherModel(conditionId: id, cityName: city, temperature: temp)
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}

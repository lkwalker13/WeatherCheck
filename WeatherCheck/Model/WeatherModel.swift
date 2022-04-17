//
//  WeatherModel.swift
//  WeatherCheck
//
//  Created by Евгений Лянкэ on 28.03.2022.
//

import Foundation


struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    var conditionName: String{
        switch conditionId {
        case 200...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
             return "cloud.fog.fill"
        case 701...781:
             return "cloud.fog.fill"
        case 801...804:
             return "cloud.sun.fill"
        default:
             return "sun.max.fill"
        }
    }
    var strTemperature:String {
        return String(format: "%.1f", temperature)
    }
    
}

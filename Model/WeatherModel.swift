//
//  WeatherModel.swift
//  Clima
//
//  Created by Ivan Ivanov on 2/15/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatcherModel {
    let conditionID: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String{
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionID {
        case 200...332:
            return "cloud.bolt"
        case 300...321:
            return "cloud.dizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    
}

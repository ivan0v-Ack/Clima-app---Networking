//
//  WatherManager.swift
//  Clima
//
//  Created by Ivan Ivanov on 2/15/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weather: WeatcherModel)
    func didFailWithError(_ error: Error)
}

struct WeatherManager {
    
    let baseUrl = "https://api.openweathermap.org/data/2.5/weather?&appid=e638b3a933d35a5efb47759be11e2c70&units=metric"
    
    var delegate : WeatherManagerDelegate? = nil
    
    func fetchData (_ city: String){
        let urlString = "\(baseUrl)&q=\(city)"
        performRequest(urlString)
   }
    
    func fetchData (latitude:CLLocationDegrees, longitude:CLLocationDegrees){
        let urlString = "\(baseUrl)&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString)
    }
    // MARK: - PerformRequest
    func performRequest(_ urlString: String){
        
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let e = error{
                    self.delegate?.didFailWithError(e)
                    return
                }
                
                if let safeData = data {
                    
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather)
                    }
               }
            }
            task.resume()
        }
    }
    // MARK: - Parse Data
    func parseJSON(_ data: Data) -> WeatcherModel?{
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(WeatherData.self, from: data)
            
            let weatherID = decodeData.weather[0].id
            let temp = decodeData.main.temp
            let cityName = decodeData.name
            
            let weather = WeatcherModel(conditionID: weatherID, cityName: cityName, temperature: temp)
            return weather
            
        }catch{
            delegate?.didFailWithError(error)
            return nil
        }
    }
 }



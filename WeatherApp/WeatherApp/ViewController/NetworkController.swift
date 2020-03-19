//
//  NetworkController.swift
//  WeatherApp
//
//  Created by Islam on 3/18/20.
//  Copyright © 2020 Islam. All rights reserved.
//

import Foundation
import Alamofire

class NetworkController {
    static let shared = NetworkController()
    func fetchWeather(_ answer: @escaping (Weather)->()) {
    AF.request("https://api.openweathermap.org/data/2.5/weather?q=Bishkek&units=metric&appid=df1d71cb282feeb33e9a29e4c0c2be8d").validate().responseDecodable(of: Weather.self) { (response) in
            guard let weather = response.value else { return }
            DispatchQueue.main.async {
                //let temp: Int = Int(weather.main.temp)
                answer(weather)
            }
        }
    }

     func configureSnapshot(_ answer: @escaping (listWeather)->()) {
        AF.request("https://api.openweathermap.org/data/2.5/forecast?q=Bishkek&units=metric&appid=df1d71cb282feeb33e9a29e4c0c2be8d").validate().responseDecodable(of: listWeather.self) { (response) in
                guard let listWeather = response.value else { return print() }
                DispatchQueue.main.async {
                    answer(listWeather)
                }
                
            }
        }
}

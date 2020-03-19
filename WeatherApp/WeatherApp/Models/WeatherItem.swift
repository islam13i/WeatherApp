//
//  WeatherItem.swift
//  WeatherApp
//
//  Created by Islam on 3/18/20.
//  Copyright © 2020 Islam. All rights reserved.
//

import Foundation
import UIKit
class WeatherItem:Codable {
    
    var weather:[WeatherDetails]
    var main:MainDetails
    var dt_txt: String
}

extension WeatherItem {
    var image: UIImage? {
        switch weather[0].main {
                      case "Thunderstorm", "Rain", "Drizzle":
                          return UIImage(named: "rain")
                      case "Snow":
                          return UIImage(named: "snow")
                      case "Mist", "Smoke", "Haze", "Fog", "Ash", "Sand", "Squall", "Clouds":
                          return UIImage(named: "cloud")
                      case "Clear":
                          return UIImage(named: "sun")
                      default:
                          return UIImage(named: "sun")
                      }
    }
    var temperature: Int{
        return Int(main.temp)
    }
    func formattedDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from:dt_txt)!
        dateFormatter.dateFormat = "MM-dd HH:mm"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}


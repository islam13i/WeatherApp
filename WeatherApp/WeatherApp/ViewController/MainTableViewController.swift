//
//  ViewController.swift
//  WeatherApp
//
//  Created by Islam on 3/14/20.
//  Copyright © 2020 Islam. All rights reserved.
//

import UIKit
import Alamofire
class MainTableViewController: UIViewController {
    @IBOutlet var background: UIView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherDescLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchWeather()
    }
    private func setWeatherValues(weather: String, description: String, temp: String){
        self.tempLabel.text = temp + "º"
        self.weatherDescLabel.text = description
       
        switch weather {
        case "Thunderstorm", "Rain", "Drizzle":
            weatherImageView.image = UIImage(named: "rain")
        case "Snow":
            weatherImageView.image = UIImage(named: "snow")
        case "Mist", "Smoke", "Haze", "Fog", "Ash", "Sand", "Squall", "Clouds":
            weatherImageView.image = UIImage(named: "cloud")
        case "Clear":
            weatherImageView.image = UIImage(named: "sun")
        default:
            weatherImageView.image = UIImage(named: "sun")
        }
        if description.hasSuffix("few clouds") {
            weatherImageView.image = UIImage(named: "cloudDay")
        }
        let formatter = DateFormatter()
               formatter.dateFormat = "HH"
               let dateString = formatter.string(from: Date())
               if Int(dateString)! >= 20 || Int(dateString)! <= 6 {
                    if description.hasSuffix("few clouds") {
                        weatherImageView.image = UIImage(named: "cloudNight")
                    }
                    if weather == "Clear" {
                        weatherImageView.image = UIImage(named: "night")
                    }
                    background.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    tempLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    weatherDescLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    cityLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
               }else{
                    background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                tempLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                weatherDescLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cityLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
               }
    }

}
// MARK: - Alamofire
extension MainTableViewController {
  func fetchWeather() {
    AF.request("https://api.openweathermap.org/data/2.5/weather?q=Bishkek&units=metric&appid=df1d71cb282feeb33e9a29e4c0c2be8d").validate().responseDecodable(of: Weather.self) { (response) in
            guard let weather = response.value else { return }
            DispatchQueue.main.async {
                let temp: Int = Int(weather.main.temp)
                self.setWeatherValues(weather: weather.weather[0].main, description: weather.weather[0].description, temp: String(temp))
            }
        }
  }
}

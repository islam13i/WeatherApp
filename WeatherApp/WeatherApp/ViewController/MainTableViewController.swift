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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeather()
        // Do any additional setup after loading the view.
    }
    private func setWeatherValues(weather: String, description: String, temp: String){
        self.tempLabel.text = temp + "º"
        self.weatherDescLabel.text = description
       
        switch weather {
        case "Thunderstorm":
            weatherImageView.image = UIImage(named: "rain")
        case "Rain":
            weatherImageView.image = UIImage(named: "rain")
        case "Drizzle":
            weatherImageView.image = UIImage(named: "rain")
        case "Snow":
            weatherImageView.image = UIImage(named: "snow")
        case "Mist":
            weatherImageView.image = UIImage(named: "cloud")
        case "Smoke":
            weatherImageView.image = UIImage(named: "cloud")
        case "Haze":
            weatherImageView.image = UIImage(named: "cloud")
        case "Fog":
            weatherImageView.image = UIImage(named: "cloud")
        case "Sand":
            weatherImageView.image = UIImage(named: "cloud")
        case "Ash":
            weatherImageView.image = UIImage(named: "cloud")
        case "Squall":
            weatherImageView.image = UIImage(named: "cloud")
        case "Clear":
            weatherImageView.image = UIImage(named: "sun")
        case "Clouds":
            weatherImageView.image = UIImage(named: "cloud")
        default:
            weatherImageView.image = UIImage(named: "sun")
        }
        if description.hasSuffix("few clouds") {
            weatherImageView.image = UIImage(named: "cloudDay")
        }
        let formatter = DateFormatter()
               formatter.dateFormat = "h"
               let dateString = formatter.string(from: Date())
               if Int(dateString)! > 20 || Int(dateString)! < 6 {
                    if description.hasSuffix("few clouds") {
                        weatherImageView.image = UIImage(named: "cloudNight")
                    }
                    if weather == "Clear" {
                        weatherImageView.image = UIImage(named: "night")
                    }
                   // background.backgroundColor = #colorLiteral(red: 0.1913444765, green: 0.4744963567, blue: 0.6078736676, alpha: 1)
                    background.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    tempLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    weatherDescLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
               }else{
                   //background.backgroundColor = #colorLiteral(red: 0.3289328516, green: 0.781253159, blue: 0.9897740483, alpha: 1)
                    background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                tempLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                weatherDescLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
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

//
//  ViewController.swift
//  WeatherApp
//
//  Created by Islam on 3/14/20.
//  Copyright © 2020 Islam. All rights reserved.
//

import UIKit
import Alamofire
class MainTableViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var background: UIView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherDescLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherCollection: UICollectionView!
    
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    private var itemsPerRow: CGFloat = 3
    let screenSize: CGRect = UIScreen.main.bounds
    var collectionItems = listWeather()
    var isNight: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if screenSize.size.width < 350 || screenSize.size.height < 580 {
            itemsPerRow = 2.5
        }
        NetworkController.shared.fetchWeather(setCurrentWeather(_:))
        NetworkController.shared.configureSnapshot(setForecast(_:))
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return collectionItems.list.count - 26
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WeatherViewCell
        
        let weatherName = collectionItems.list[indexPath.row].weather[0].description
        if weatherName.hasSuffix("few clouds") {
            cell.imageView.image = getWeatherByDesc(weather: collectionItems.list[indexPath.row])
        }else{
            cell.imageView.image = collectionItems.list[indexPath.row].image
        }
        cell.tempLabel.text = String(collectionItems.list[indexPath.row].temperature) + "º"
        cell.timeLabel.text = collectionItems.list[indexPath.row].formattedDate()
           return cell
    }
    func setCurrentWeather(_ weather: Weather) {
        let temp: Int = Int(weather.main.temp)
        isNight = weather.weather[0].icon.contains("n")
        self.setWeatherValues(weather: weather.weather[0].main, description: weather.weather[0].description, temp: String(temp))
    }
    func setForecast(_ forecast: listWeather) {
        self.collectionItems = forecast
    
        self.weatherCollection.reloadData()
    }
    func setWeatherValues(weather: String, description: String, temp: String){
        self.tempLabel.text = temp + "º"
        self.weatherDescLabel.text = description
        weatherImageView.image = UIImage(named: getWeatherImage(weather))
       
        if description.hasSuffix("few clouds") {
            weatherImageView.image = getWeatherByDesc()
        }
        setColorsView()
    }
    func setColorsView() {
        if isNight{
            background.backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        }else{
            background.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        }
    }
    func getWeatherByDesc(weather: WeatherItem? = nil) -> UIImage? {
        if let weather = weather{
            var image = UIImage(named: "cloudDay")
            if weather.weather[0].icon.contains("n"){
                image = UIImage(named: "cloudNight")
                return image
            }
            return image
        }
        var image = UIImage(named: "cloudDay")
            if isNight {
                 image = UIImage(named: "cloudNight")
                return image
            }
        return image
    }
        
    
    func getWeatherImage(_ desc: String) -> String {
        switch desc {
               case "Thunderstorm", "Rain", "Drizzle":
                   return "rain"
               case "Snow":
                   return "snow"
               case "Mist", "Smoke", "Haze", "Fog", "Ash", "Sand", "Squall", "Clouds":
                   return "cloud"
               case "Clear":
                if isNight {
                    return "night"
                }
                   return "sun"
               default:
                   return "sun"
               }
    }
}

extension MainTableViewController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
    let availableWidth = view.frame.width - paddingSpace
    let widthPerItem = availableWidth / itemsPerRow
    
    return CGSize(width: widthPerItem, height: widthPerItem)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sectionInsets.left
  }
}

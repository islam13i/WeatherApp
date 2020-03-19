//
//  listWeather.swift
//  WeatherApp
//
//  Created by Islam on 3/18/20.
//  Copyright © 2020 Islam. All rights reserved.
//
import UIKit
import Foundation

class listWeather:Codable {
    var cod: String = ""
    var list:[WeatherItem] = []
}

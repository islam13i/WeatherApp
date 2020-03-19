//
//  Weather.swift
//  WeatherApp
//
//  Created by Islam on 3/15/20.
//  Copyright © 2020 Islam. All rights reserved.
//
import UIKit

class Weather:Codable {
    
    var coord:CoordinatesDetails
    var weather:[WeatherDetails]
    var main:MainDetails
    var id:Int
    var name:String
    var cod:Int
}

class CoordinatesDetails:Codable {
    var lon:Float
    var lat:Float
}

class WeatherDetails:Codable {
    var id:Int
    var main:String
    var description:String
    var icon:String
}

class MainDetails:Codable {
    var temp:Float
    var feels_like: Float
}



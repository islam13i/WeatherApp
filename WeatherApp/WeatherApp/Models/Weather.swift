//
//  Weather.swift
//  WeatherApp
//
//  Created by Islam on 3/15/20.
//  Copyright © 2020 Islam. All rights reserved.
//


struct Weather:Codable {
    var coord:CoordinatesDetails
    var weather:[WeatherDetails]
    var base:String
    var main:MainDetails
    var wind:WindDetails
    var clouds:CloudsDetails
    var dt:Float
    var sys:SysDetails
    var timezone:Float
    var id:Int
    var name:String
    var cod:Int
}

struct CoordinatesDetails:Codable {
    var lon:Float
    var lat:Float
}

struct WeatherDetails:Codable {
    var id:Int
    var main:String
    var description:String
    var icon:String
}

struct MainDetails:Codable {
    var temp:Float
    var feels_like: Float
    var temp_min:Float
    var temp_max:Float
    var pressure:Float
    var humidity:Float
}

struct WindDetails:Codable {
    var speed:Float
    var deg:Int
}
struct CloudsDetails:Codable {
    var all:Float
}
struct SysDetails:Codable {
var type:Int
var id:Int
var country:String
var sunrise:Int
var sunset:Int
}

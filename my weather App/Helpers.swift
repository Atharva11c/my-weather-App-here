//
//  Helpers.swift
//  my weather App
//
//  Created by Atharva Lavhate on 28/02/25.
//

import Foundation
import SwiftUI

//function for different emojis at different weather
func getWeatherEmoji( code: Int) -> String{
    var weatherEmoji : String = "☀️"
    switch code{
    case 1000:
        weatherEmoji = "☀️"
        break
        
    case 1003:
        weatherEmoji = "⛅️"
        break
        
    case 1273,1276,1279,1282:
        weatherEmoji = "⛈️"
        break
        
    case 1087:
        weatherEmoji = "🌩️"
        break
        
    case 1147,1135,1030,1009,1006:
        weatherEmoji = "☁️"
        break
        
    case 1264,1261,1258,1252,1249,1201,1198,1195,1192,1189,1186,1183,1180,1171,1168,1153,1150,1072,1063:
        weatherEmoji = "🌧️"
        break
        
        case 1255,1246,1243,1240,1237,1225,1222,1219,1216,1213,1210,1207,1204,1117,1114,1069,1066:
        weatherEmoji = "❄️"
        break
        
    default:
        weatherEmoji = "☀️"
        break
    }
    /*
    let conditionText = text.lowercased()
    
    if conditionText.contains("cloudy") || conditionText.contains("overcast"){
        weatherEmoji = "☁️"
    }
    
    else if conditionText.contains("rain"){
        weatherEmoji = "🌧️"
    }
    
    else if conditionText.contains("snow") || conditionText.contains("blizzard"){
        weatherEmoji = "❄️"
    }
    
    else if conditionText.contains("partly cloudy"){
        weatherEmoji = "⛅️"
    }
    
    else if conditionText.contains("sunny") || conditionText.contains("clear"){
        weatherEmoji = "☀️"
    }
    */
    return weatherEmoji
}

// Function to return background color based on weather
func getBackgroundColor(code: Int) -> Color {
    let blueSky = Color.init(red:135/255 , green: 206/255, blue: 235/255)
    let greySky = Color.init(red:47/255 , green: 79/255, blue: 79/255)
    var backgroundColor = greySky
    switch code {
    case 1000, 1003:
        backgroundColor = blueSky
        break
    default:
        break
    }
    return backgroundColor
}

func getShortDate(epoch : Int) -> String {
    
    return Date(timeIntervalSince1970: TimeInterval(epoch)).formatted(Date.FormatStyle() .weekday(.abbreviated))
    
}

func getShortTime(time : String) -> String {
    var meridiem = "AM"
    var dispalyTime = 1
    let miliatryTime = time.suffix(5)
    let currentTime = miliatryTime.prefix(2)
    
    if(currentTime == "00" || currentTime == "12"){
        dispalyTime = 12
        
        if (currentTime == "00"){
            meridiem = "AM"
        }
        else{
            meridiem = "PM"
        }
    }else{
        if let intTime = Int(currentTime){
            if(intTime>=13){
                dispalyTime = intTime - 12
                meridiem = "PM"
            }
            else{
                dispalyTime = intTime
                meridiem = "AM"
            }
        }
    }
    
    return "\(dispalyTime)\(meridiem)"
    
}

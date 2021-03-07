//
//  WeatherHandler.swift
//  FitBreak
//
//  Created by Alberto Hernández Pintor on 21/2/21.
//

import Foundation
import Alamofire

class WeatherHandler {
    
    static func getWeatherAtLocation(city: String, country: String, isSearching: Bool) {
        ApiManager().getLocationId(location: city) { (result) in
            switch result {
                case let .success(locations):
                    if locations.count > 0 {
                        let key = getCityInCountry(locations: locations, country: country)
                       searchWeatherInLocation(key: key, country: country, city: city, isSearching: isSearching)
                    }
                case let .failure(error):
                    print(error)
            }
        }
    }
    
    static func getCityInCountry(locations: [WeatherResults], country: String)-> String {
        let filteredCities = locations.filter{
            $0.Country.LocalizedName == country
        }
        
        if filteredCities.count > 0 {
            return filteredCities[0].Key
        } else {
            return ""
        }
        
    }
    
    static func searchWeatherInLocation(key: String, country: String, city: String, isSearching: Bool) {
        // Llamamos a la API para conseguir el tiempo de la localización
        ApiManager().getWeather(key: key) { (result) in
            switch result {
                case let .success(weather):
                    saveNewWeather(dailyForecast: weather.dailyForecasts[0], country: country, city: city, key: key)
                    
                    if isSearching {
                        Notifications.showNotification(title: "Nueva localización añadida", subtitle: "Ya puede visualizar el tiempo")
                    }
                case let .failure(error):
                    print(error)
            }
        }
    }
    
    static func saveNewWeather(dailyForecast: DailyForecast, country: String, city: String, key: String) {
        let usersDefaults = UserDefaults.standard
        var index = 0
        
        let weather = NewWeather(dailyForecasts: dailyForecast, country: country, city: city, key: key)
        
        if usersDefaults.object(forKey: "myWeather") != nil {
            let myWeather = usersDefaults.data(forKey: "myWeather")
            var weatherDecode = try! JSONDecoder().decode([NewWeather].self, from: myWeather!)
            for w in weatherDecode {
                if w.city == city && w.country == country {
                    weatherDecode.remove(at: index)
                    let newWeather = try! JSONEncoder().encode(weatherDecode)
                    usersDefaults.set(newWeather, forKey: "myWeather")
                    break;
                }
                index += 1
            }

            weatherDecode += [weather]
            let newWeather = try! JSONEncoder().encode(weatherDecode)
            usersDefaults.set(newWeather, forKey: "myWeather")
        } else {
            let newWeather = try! JSONEncoder().encode([weather])
            usersDefaults.set(newWeather, forKey: "myWeather")
        }
    }
    
    static func loadMyWeather()->[NewWeather] {
        let usersDefaults = UserDefaults.standard
        var weatherDecode: [NewWeather] = []
        
        if usersDefaults.object(forKey: "myWeather") != nil {
            let myWeather = usersDefaults.data(forKey: "myWeather")
            weatherDecode = try! JSONDecoder().decode([NewWeather].self, from: myWeather!)
        }
        
        return weatherDecode
    }
    
    static func updateMyWeather() {
        let myWeather = loadMyWeather()
        
        for weather in myWeather {
            searchWeatherInLocation(key: weather.key, country: weather.country, city: weather.city, isSearching: false)
        }
    }
    
    static func deleteWeather(index: Int) {
        let usersDefaults = UserDefaults.standard
        let myWeather = usersDefaults.data(forKey: "myWeather")
        var weatherDecode = try! JSONDecoder().decode([NewWeather].self, from: myWeather!)
        
        weatherDecode.remove(at: index)
        let newWeather = try! JSONEncoder().encode(weatherDecode)
        usersDefaults.set(newWeather, forKey: "myWeather")
    }
}

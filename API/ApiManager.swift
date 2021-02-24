//
//  ApiManager.swift
//  FitBreak
//
//  Created by Alberto Hernández Pintor on 21/2/21.
//

import Foundation
import Alamofire

class ApiManager {
    var session = Session.default
    
    // Obtener el ID de una localización pasando su nombre
    func getLocationId(location: String, completion: @escaping (Result <[WeatherResults], AFError>)->()) {
        session.request(MyUrlRequest.getLocationId(city: location)).validate().responseDecodable(of: [WeatherResults].self) { (result) in completion(result.result)
        }
    }
    
    // Obtener el tiempo de una ciudad por su clave
    func getWeather(key: String, completion: @escaping (Result <WeatherModel, AFError>)->()) {
        session.request(MyUrlRequest.getWeather(key: key)).validate().responseDecodable(of: WeatherModel.self) { (result) in completion(result.result)
        }
    }
}

enum MyUrlRequest: URLRequestConvertible {
    case getLocationId(city: String)
    case getWeather(key: String)

    static var baseUrl: String {
        return "https://dataservice.accuweather.com"
    }
    
    static var apiKey: String {
        return "ZAvdlqcH3TX5nhGZBxJfFxAUYYMXdmmg"
    }
    
    var method: HTTPMethod {
        switch self {
            case .getLocationId(city: _):
                return .get
            case .getWeather(key: _):
                return.get
        }
    }
    
    var path: String {
        switch self {
            case .getLocationId(city: _):
                return "/locations/v1/cities/search"
            case let .getWeather(key: key):
                return "/forecasts/v1/daily/1day/" + key

        }
    }
    
    func asURLRequest() throws -> URLRequest {
        do {
            let base = try MyUrlRequest.baseUrl.asURL()
            var urlRequest = try URLRequest(url: base.appendingPathComponent(path), method: method)
            
            switch self {
                case let .getLocationId(city: city):
                    urlRequest = try URLEncodedFormParameterEncoder(destination: .queryString).encode(["apikey": MyUrlRequest.apiKey, "q": city], into: urlRequest)
                case .getWeather(key: _):
                    urlRequest = try URLEncodedFormParameterEncoder(destination: .queryString).encode(["apikey": MyUrlRequest.apiKey], into: urlRequest)
            }
            
            return urlRequest
        } catch {
            throw error
        }
    }
}



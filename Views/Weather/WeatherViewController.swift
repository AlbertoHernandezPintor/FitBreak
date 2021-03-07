//
//  WeatherViewController.swift
//  FitBreak
//
//  Created by Alberto Hernández Pintor on 18/2/21.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchButton.layer.cornerRadius = searchButton.frame.height / 2
        searchButton.backgroundColor = UIColor(named: "SecondaryColor")
        searchButton.clipsToBounds = true
        searchButton.tintColor = .white
        
        tableView.reloadData()
        
        WeatherHandler.updateMyWeather()
        
        let userDefaults = UserDefaults.standard
        userDefaults.addObserver(self, forKeyPath: "myWeather", options: NSKeyValueObservingOptions.new, context: nil)
        userDefaults.synchronize()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        tableView.reloadData()
    }

    @IBAction func closeAllKeyboards(_ sender: Any) {
        cityTextField.resignFirstResponder()
        countryTextField.resignFirstResponder()
    }
    
    @IBAction func searchWeather() {
        if let city = cityTextField.text {
            if let country = countryTextField.text {
                if city != "" && country != "" {
                    cityTextField.text = ""
                    countryTextField.text = ""
                    WeatherHandler.getWeatherAtLocation(city: city, country: country, isSearching: true)
                } else {
                    let uiAlertController = UIAlertController(title: "Datos introducidos",
                                                            message: "Es obligatario introducir una ciudad y un país",
                                                     preferredStyle: .alert)
                    
                    let uiAction = UIAlertAction(title: "Aceptar",
                                                 style: .default,
                                               handler: {(action)->Void in //nada
                                                 })
                    
                    uiAlertController.addAction(uiAction)
                    
                    present(uiAlertController, animated: true, completion: nil)
                }
            }
        }
    }
}

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Cerramos el teclado
        textField.resignFirstResponder()
        
        return true
    }
}

extension WeatherViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        WeatherHandler.loadMyWeather().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        if let cell = customCell as? WeatherListTableViewCell {
            let weather = WeatherHandler.loadMyWeather()
            cell.city.text = weather[indexPath.row].city + " - " + weather[indexPath.row].country
            
            let maxTemp = floor((weather[indexPath.row].dailyForecasts.temperature.maximum.value - 32) * 5 / 9)
            cell.maxTemp.text = "\(maxTemp)" + " ºC"
            
            let minTemp = floor((weather[indexPath.row].dailyForecasts.temperature.minimum.value - 32) * 5 / 9)
            cell.minTemp.text = "\(minTemp)" + " ºC"
            
            if weather[indexPath.row].dailyForecasts.day.hasPrecipitation {
                if weather[indexPath.row].dailyForecasts.day.precipitationType == "Rain" {
                    if weather[indexPath.row].dailyForecasts.day.precipitationIntensity == "Light" {
                        cell.precipitation.image = UIImage(systemName: "cloud.drizzle")
                    } else {
                        cell.precipitation.image = UIImage(systemName: "cloud.heavyrain")
                    }
                } else if weather[indexPath.row].dailyForecasts.day.precipitationType == "Snow" {
                    if weather[indexPath.row].dailyForecasts.day.precipitationIntensity == "Light" {
                        cell.precipitation.image = UIImage(systemName: "cloud.sleet")
                    } else {
                        cell.precipitation.image = UIImage(systemName: "cloud.snow")
                    }
                }
            } else {
                cell.precipitation.image = UIImage(systemName: "sun.max")
            }

            return cell
        } else {
            return customCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = self.delete(indexPath: indexPath)
        
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        
        return swipe
    }
    
    private func delete(indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Borrar") {
            [weak self] (_, _, _) in
            guard let self = self else {return}
            
            let deleteAlert = UIAlertController(title: "Alerta de borrado",
                                                    message: "¿Está seguro?",
                                             preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancelar",
                                         style: .cancel,
                                       handler: {(action)->Void in})
            
            let deleteAction = UIAlertAction(title: "Borrar",
                                         style: .destructive,
                                       handler: {(action)->Void in
                                        WeatherHandler.deleteWeather(index: indexPath.row)
                                       })
            
            deleteAlert.addAction(cancelAction)
            deleteAlert.addAction(deleteAction)
            
            self.present(deleteAlert, animated: true, completion: nil)
        }
        
        return action
    }
}

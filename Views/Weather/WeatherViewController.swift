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
                    WeatherHandler.getWeatherAtLocation(city: city, country: country)
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
            cell.city.text = weather[indexPath.row].city

            return cell
        } else {
            return customCell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

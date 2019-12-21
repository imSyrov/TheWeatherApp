//
//  MainController.swift
//  TheWeatherApp
//
//  Created by ilya on 16/12/2019.
//  Copyright © 2019 ilya. All rights reserved.
//

import UIKit
import Alamofire

class MainController: UIViewController {
    
    @IBOutlet weak var systemInfomationLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var loadScreenView: UIView!
    @IBOutlet weak var currentTableView: WeatherOptionTableView!
    @IBOutlet weak var forecastCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var currentCity: String?
    var forecastWeather: ForecastWeatherModel?
    var forecastCells: [ForecastDataModel] = [] {
        didSet {
            forecastCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        forecastCollectionView.dataSource = self
        forecastCollectionView.delegate = self
        forecastCollectionView.register(ForecastWeatherCell.self)
    }
    
    func getWeather(for city: String?) {
        self.cityTextField.resignFirstResponder()
        activityIndicator.startAnimating()
        dataView.isHidden = true
        self.forecastCells.removeAll()
        loadScreenView.isHidden = false
        guard let city = city else { return }
        
        if city.isEmpty {
            showAlert(message: "Sorry, You didn't enter the city")
            self.activityIndicator.stopAnimating()
            self.loadScreenView.isHidden = true
            return
        }
        
        let connection = InternetConnection()
        
        if connection.checkConnection() {
            DatabaseService.database.clearData()
            loadWeatherFromInternet(for: city)
        }
        else {
            loadWeatherFromDatabase()
        }
        
        self.activityIndicator.stopAnimating()
        self.loadScreenView.isHidden = true
        self.dataView.isHidden = false
    }
    
    func loadWeatherFromInternet(for city: String) {
        let parameters: Parameters = ["q" : city]
        let weatherModel = WeatherModel()
        
        getCurrentWeather(parameters: parameters) { [weak self] result in
            switch result {
                case .success(let weather):
                    weatherModel.current = weather
                    self?.conditionImageView.load(for: weather.options[0].icon)
                    self?.fillTable(weather)
                case .failure(let error):
                    self?.showAlert(message: "\(error.localizedDescription)")
            }
        }
        
        getForecastWeather(parameters: parameters) { [weak self] result in
            switch result {
                case .success(let weather):
                    weatherModel.forecast = weather
                    DatabaseService.database.add(objects: [weatherModel])
                    self?.forecastWeather = weather
                    weather.data.forEach { data in
                        self?.forecastCells.append(data)
                    }
                case .failure(let error):
                    self?.showAlert(message: "\(error.localizedDescription)")
            }
        }
    }
    
    func loadWeatherFromDatabase() {
        let objects: [WeatherModel] = DatabaseService.database.read()
        if objects.count > 0 {
            showAlert(message: "No Internet connection")
            guard let weather = objects.first else { return }
            guard let current = weather.current else { return }
            self.fillTable(current)
            self.forecastWeather = weather.forecast            
            forecastWeather?.data.forEach { data in
                self.forecastCells.append(data)
            }
        } else {
            showAlert(message: "Error: Datas can't be received")
            return
        }
    }
    
    func getCurrentWeather(parameters: Parameters, complition: @escaping (Result<CurrentWeatherModel>) -> Void) {
        let API = APIService()
        API.getObject(for: .current, parameters: parameters, complition: complition)
    }
    
    func getForecastWeather(parameters: Parameters, complition: @escaping (Result<ForecastWeatherModel>) -> Void) {
        let API = APIService()
        API.getObject(for: .forecast, parameters: parameters, complition: complition)
    }
    
    func fillTable(_ data: CurrentWeatherModel) {
        let header = data.name + "\t" + (data.date?.toString(with: "dd.MM HH:mm") ?? "0.0")
        self.systemInfomationLabel.text = header
        var rows: [WeatherOptionTableRow] = []
        rows.append(WeatherOptionTableRow(title: "Temperature", value: data.main?.temperature.toDegrees() ?? "none"))
        rows.append(WeatherOptionTableRow(title: "Weather", value: data.options[0].descriptionOption))
        rows.append(WeatherOptionTableRow(title: "Humidity", value: data.main?.humidity.toPercent() ?? "none"))
        rows.append(WeatherOptionTableRow(title: "Pressure", value: data.main?.pressure.toPascal() ?? "none"))
        rows.append(WeatherOptionTableRow(title: "Wind", value: data.wind?.speed.toSpeed() ?? "none"))
        rows.append(WeatherOptionTableRow(title: "Cloudness", value: data.clouds?.cloudness.toPercent() ?? "none"))
        rows.append(WeatherOptionTableRow(title: "Min temperature", value: data.main?.minTemperature.toDegrees() ?? "none"))
        rows.append(WeatherOptionTableRow(title: "Max temperature", value: data.main?.maxTemperature.toDegrees() ?? "none"))
        rows.append(WeatherOptionTableRow(title: "Sunrise", value: data.system?.sunrise?.toString(with: "HH:mm:ss") ?? "none"))
        rows.append(WeatherOptionTableRow(title: "Sunset", value: data.system?.sunset?.toString(with: "HH:mm:ss") ?? "none"))
        rows.append(WeatherOptionTableRow(title: "Coordinates", value: "(\(data.coordinates?.longitude.toCoordinate() ?? "none"),\(data.coordinates?.latitude.toCoordinate() ?? "none"))"))
        currentTableView.setHeader(header)
        currentTableView.setRows(rows)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        currentCity = cityTextField.text
        getWeather(for: currentCity)
    }
    
    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
        getWeather(for: currentCity)
    }
    
}

extension MainController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ForecastWeatherCell = forecastCollectionView.dequeueReusable(for: indexPath)
        cell.confugure(data: forecastCells[indexPath.row])
        return cell
    }
}

extension MainController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let forecastWeatherController = ForecastWeatherController()
        forecastWeatherController.systemInformation = forecastWeather?.city
        forecastWeatherController.forecastModel = forecastWeather?.data[indexPath.item]
        
        present(forecastWeatherController, animated: true, completion: nil)
    }
}

extension MainController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: collectionView.frame.height)
    }
}

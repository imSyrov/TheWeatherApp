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
        cityTextField.text = "Samara"
        
        forecastCollectionView.dataSource = self
        forecastCollectionView.delegate = self
        forecastCollectionView.register(ForecastWeatherCell.self)
    }
    
    func loadWeather(for city: String?) {
        self.cityTextField.resignFirstResponder()
        self.forecastCells.removeAll()
        dataView.isHidden = true
        guard let city = city else { return }
        
        if city.isEmpty {
            showAlert(message: "Sorry, You didn't enter the city")
            return
        }
        loadScreenView.isHidden = false
        activityIndicator.startAnimating()
        let parameters: Parameters = ["q" : city]
        
        getCurrentWeather(parameters: parameters) { [weak self] result in
            switch result {
                case .success(let weather):
                    self?.conditionImageView.load(for: weather.options[0].icon)
                    self?.fillTable(weather)
                case .failure(let error):
                    self?.showAlert(message: "\(error.localizedDescription)")
            }
        }
        
        getForecastWeather(parameters: parameters) { [weak self] result in
            switch result {
                case .success(let weather):
                    self?.forecastWeather = weather
                    weather.data.forEach { data in
                        self?.forecastCells.append(data)
                    }
                case .failure(let error):
                    self?.showAlert(message: "\(error.localizedDescription)")
            }
        }
        
        self.activityIndicator.stopAnimating()
        self.loadScreenView.isHidden = true
        self.dataView.isHidden = false
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
    
    func getCurrentWeather(parameters: Parameters, complition: @escaping (Result<CurrentWeatherModel>) -> Void) {
        let API = APIService()
        API.getObject(for: .current, parameters: parameters, complition: complition)
    }
    
    func getForecastWeather(parameters: Parameters, complition: @escaping (Result<ForecastWeatherModel>) -> Void) {
        let API = APIService()
        API.getObject(for: .forecast, parameters: parameters, complition: complition)
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        currentCity = cityTextField.text
        loadWeather(for: currentCity)
    }
    
    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
        
        loadWeather(for: currentCity)
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

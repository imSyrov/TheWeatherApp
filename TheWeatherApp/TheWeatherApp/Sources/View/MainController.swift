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
            loadWeatherFromInternet(for: city)
        }
        else {
            loadWeatherFromDatabase(for: city)
            self.activityIndicator.stopAnimating()
            self.loadScreenView.isHidden = true
            self.dataView.isHidden = false
        }
    }
    
    func loadWeatherFromInternet(for city: String) {
        let request = WeatherRequest()
        let requestGroup = DispatchGroup()
        var currentWeather: CurrentWeatherModel?
        self.forecastWeather = nil
        
        requestGroup.enter()
        request.getCurrentWeather(for: city) { [weak self] result in
            switch result {
                case .success(let weather):
                    currentWeather = weather
                    if let name = weather.options.first?.icon {
                        self?.conditionImageView.load(for: name)
                    }                    
                    self?.systemInfomationLabel.text = weather.name + "\t" + (weather.date?.toString(with: "dd.MM HH:mm") ?? "")
                    self?.currentTableView.fillTable(data: weather)
                case .failure(let error):
                    self?.showAlert(message: "\(error.localizedDescription)")
            }
            requestGroup.leave()
        }
        
        requestGroup.enter()
        request.getForecastWeather(for: city) { [weak self] result in
            switch result {
                case .success(let weather):
                    self?.forecastWeather = weather
                    weather.data.forEach { data in
                        self?.forecastCells.append(data)
                    }
                case .failure(let error):
                    self?.showAlert(message: "\(error.localizedDescription)")
            }
            requestGroup.leave()
        }
        
        requestGroup.notify(queue: DispatchQueue.main) {
            if let current = currentWeather, let forecast = self.forecastWeather {
                let weatherModel = WeatherModel(current: current, forecast: forecast)
                DatabaseService.database.add(objects: [weatherModel])
                self.dataView.isHidden = false
            }
            self.activityIndicator.stopAnimating()
            self.loadScreenView.isHidden = true
        }
    }
    
    func loadWeatherFromDatabase(for city: String) {
        let objects: [WeatherModel] = DatabaseService.database.read(filter: "city == '\(city)'")
        if objects.count > 0 {
            showAlert(message: "No Internet connection")
            guard let weather = objects.first else { return }
            guard let current = weather.current else { return }
            self.currentTableView.fillTable(data: current)
            self.systemInfomationLabel.text = current.name + "\t" + (current.date?.toString(with: "dd.MM HH:mm") ?? "")
            self.forecastWeather = weather.forecast            
            forecastWeather?.data.forEach { data in
                self.forecastCells.append(data)
            }
        } else {
            showAlert(message: "Error: Datas can't be received")
            return
        }
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

//
//  ForecastWeatherController.swift
//  TheWeatherApp
//
//  Created by ilya on 17/12/2019.
//  Copyright © 2019 ilya. All rights reserved.
//

import UIKit

class ForecastWeatherController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var weatherOptionTableView: WeatherOptionTableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var systemInformation: SystemInformationForecastModel?
    var forecastModel: ForecastDataModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        headerLabel.text = (systemInformation?.name ?? "none") + "\n" + (forecastModel?.date?.toString(with: "dd:MM HH:mm") ?? "00:00")
        fillTable(data: forecastModel, system: systemInformation)
                
        if let imageName = forecastModel?.options[0].icon {
            conditionImageView.load(for: imageName)
        }
        
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    func fillTable(data: ForecastDataModel?, system: SystemInformationForecastModel?) {
        guard let data = data, let system = system else { return }
        var rows: [WeatherOptionTableRow] = []
        rows.append(WeatherOptionTableRow(title: "Temperature", value: data.main?.temperature.toDegrees() ?? "none"))
        rows.append(WeatherOptionTableRow(title: "Weather", value: data.options[0].descriptionOption))
        rows.append(WeatherOptionTableRow(title: "Humidity", value: data.main?.humidity.toPercent() ?? "none"))
        rows.append(WeatherOptionTableRow(title: "Pressure", value: data.main?.pressure.toPascal() ?? "none"))
        rows.append(WeatherOptionTableRow(title: "Wind", value: data.wind?.speed.toSpeed() ?? "none"))
        rows.append(WeatherOptionTableRow(title: "Cloudness", value: data.clouds?.cloudness.toPercent() ?? "none"))
        rows.append(WeatherOptionTableRow(title: "Min temperature", value: data.main?.minTemperature.toDegrees() ?? "none"))
        rows.append(WeatherOptionTableRow(title: "Max temperature", value: data.main?.maxTemperature.toDegrees() ?? "none"))
        rows.append(WeatherOptionTableRow(title: "Sunrise", value: system.sunrise?.toString(with: "HH:mm:ss") ?? "none"))
        rows.append(WeatherOptionTableRow(title: "Sunset", value: system.sunset?.toString(with: "HH:mm:ss") ?? "none"))
        rows.append(WeatherOptionTableRow(title: "Coordinates", value: "(\(system.coordinates?.longitude.toCoordinate() ?? "none"),\(system.coordinates?.latitude.toCoordinate() ?? "none"))"))
        weatherOptionTableView.setRows(rows)
    }

    @IBAction func returnToMainController(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

//
//  WeatherOptionTableView.swift
//  TheWeatherApp
//
//  Created by ilya on 16/12/2019.
//  Copyright © 2019 ilya. All rights reserved.
//

import UIKit

class WeatherOptionTableView: UITableView {
    
    private var header: String?
    private var rows: [WeatherOptionTableRow] = [] {
        didSet {
            reloadData()
        }
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.dataSource = self
        self.register(WeatherOptionCell.self)
    }
    
    private func setRows(_ rows: [WeatherOptionTableRow]) {
        self.rows = rows
    }
    
    func fillTable(data: CurrentWeatherModel) {
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
        self.setRows(rows)
    }
    
    func fillTable(data: ForecastDataModel, system: SystemInformationForecastModel) {
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
        self.setRows(rows)
    }
}

extension WeatherOptionTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WeatherOptionCell = self.dequeueReusableCell(for: indexPath)
        cell.configure(title: rows[indexPath.row].title, value: rows[indexPath.row].value)
        return cell
    }    
}

extension UITableView {
    func register<T: UITableViewCell> (_ cell: T.Type) {
        self.register(UINib(nibName: String(describing: cell.self), bundle: nil), forCellReuseIdentifier: String(describing: cell.self))
    }
    
    func dequeueReusableCell<T: UITableViewCell> (for indexPath: IndexPath) -> T {
        self.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }
}

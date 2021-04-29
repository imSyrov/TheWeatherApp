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
    private var rows: [WeatherOption] = [] {
        didSet {
            reloadData()
        }
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.dataSource = self
        self.register(WeatherOptionCell.self)
    }
    
    private func setRows(_ rows: [WeatherOption]) {
        self.rows = rows
    }
    
    func fillTable(data: CurrentWeatherModel) {
        var rows: [WeatherOption] = []
        rows.append(.temperature(data.main?.temperature ?? 0.0))
        rows.append(.weather(data.options[0].descriptionOption))
        rows.append(.humidity(data.main?.humidity ?? 0))
        rows.append(.pressure(data.main?.pressure ?? 0.0))
        rows.append(.wind(data.wind?.speed ?? 0.0))
        rows.append(.clodness(data.clouds?.cloudness ?? 0))
        rows.append(.minTemperature(data.main?.minTemperature ?? 0.0))
        rows.append(.maxTemperature(data.main?.maxTemperature ?? 0.0))
        rows.append(.sunrise(data.system?.sunrise ?? Date()))
        rows.append(.sunset(data.system?.sunset ?? Date()))
        rows.append(.coordinates(data.coordinates ?? CoordinatesModel()))
        self.setRows(rows)
    }
    
    func fillTable(data: ForecastDataModel, system: SystemInformationForecastModel) {
        var rows: [WeatherOption] = []
        rows.append(.temperature(data.main?.temperature ?? 0.0))
        rows.append(.weather(data.options[0].descriptionOption))
        rows.append(.humidity(data.main?.humidity ?? 0))
        rows.append(.pressure(data.main?.pressure ?? 0.0))
        rows.append(.wind(data.wind?.speed ?? 0.0))
        rows.append(.clodness(data.clouds?.cloudness ?? 0))
        rows.append(.minTemperature(data.main?.minTemperature ?? 0.0))
        rows.append(.maxTemperature(data.main?.maxTemperature ?? 0.0))
        rows.append(.sunrise(system.sunrise ?? Date()))
        rows.append(.sunset(system.sunset ?? Date()))
        rows.append(.coordinates(system.coordinates ?? CoordinatesModel()))
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

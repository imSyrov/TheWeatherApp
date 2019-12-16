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
    
    func setRows(_ rows: [WeatherOptionTableRow]) {
        self.rows = rows
    }
    
    func setHeader(_ header: String) {
        self.header = header
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
    
    /*func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return header
    }*/
}

extension WeatherOptionTableView {
    func register<T: UITableViewCell> (_ cell: T.Type) {
        self.register(UINib(nibName: String(describing: cell.self), bundle: nil), forCellReuseIdentifier: String(describing: cell.self))
    }
    
    func dequeueReusableCell<T: UITableViewCell> (for indexPath: IndexPath) -> T {
        self.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }
}

//
//  UITableView.swift
//  TheWeatherApp
//
//  Created by ilya on 23/12/2019.
//  Copyright © 2019 ilya. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell> (_ cell: T.Type) {
        self.register(UINib(nibName: String(describing: cell.self), bundle: nil), forCellReuseIdentifier: String(describing: cell.self))
    }
    
    func dequeueReusableCell<T: UITableViewCell> (for indexPath: IndexPath) -> T {
        self.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }
}

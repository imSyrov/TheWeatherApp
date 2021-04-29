//
//  UIImageView.swift
//  TheWeatherApp
//
//  Created by ilya on 16/12/2019.
//  Copyright © 2019 ilya. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(for name: String) {
        let connection = InternetConnection()
        if connection.checkConnection() {
            guard let url = URL(string: "http://openweathermap.org/img/wn/" + name + "@2x.png") else { return }
            DispatchQueue.global().async { [weak self] in
                guard let data = try? Data(contentsOf: url) else { return }
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}

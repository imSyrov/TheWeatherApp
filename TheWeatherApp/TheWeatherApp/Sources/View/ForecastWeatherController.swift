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
                
        if let imageName = forecastModel?.options.first?.icon {
            conditionImageView.load(for: imageName)
        }
        
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    func fillTable(data: ForecastDataModel?, system: SystemInformationForecastModel?) {
        guard let data = data, let system = system else { return }
        weatherOptionTableView.fillTable(data: data, system: system)
    }

    @IBAction func returnToMainController(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

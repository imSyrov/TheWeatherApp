//
//  CollectionView.swift
//  TheWeatherApp
//
//  Created by ilya on 16/12/2019.
//  Copyright © 2019 ilya. All rights reserved.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell> (_ cell: T.Type) {
        self.register(UINib(nibName: String(describing: cell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: cell.self))
    }
    
    func dequeueReusable<T: UICollectionViewCell> (for indexPath: IndexPath) -> T {
        self.dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
    }
}

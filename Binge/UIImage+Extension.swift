//
//  UIImage+Extension.swift
//  Binge
//
//  Created by Ciara Beitel on 1/9/20.
//  Copyright © 2020 Ciara Beitel. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: String) {
        let correctUrl = URL(string: "https://thetvdb.com" + url)!
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: correctUrl) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

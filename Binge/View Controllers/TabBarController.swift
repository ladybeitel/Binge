//
//  TabBarController.swift
//  Binge
//
//  Created by Ciara Beitel on 2/4/20.
//  Copyright © 2020 Ciara Beitel. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

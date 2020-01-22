//
//  LaunchViewController.swift
//  Binge
//
//  Created by Ciara Beitel on 1/22/20.
//  Copyright © 2020 Ciara Beitel. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var bunnyNoWhiskers: UIImageView!
    @IBOutlet weak var leftWhiskers: UIImageView!
    @IBOutlet weak var rightWhiskers: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        wiggleWhiskers()
    }
    
    func wiggleWhiskers() {
        UIView.animate(withDuration: 0.3, delay: 1.0, options: .curveEaseIn, animations: {
            self.leftWhiskers.transform = CGAffineTransform(rotationAngle: -0.02);
            self.rightWhiskers.transform = CGAffineTransform(rotationAngle: 0.02);
        }) { (_) in
            print("Rotating whiskers down.")
        }
        UIView.animate(withDuration: 0.3, delay: 1.5, options: .curveEaseIn, animations: {
            self.leftWhiskers.transform = CGAffineTransform(rotationAngle: 0.02);
            self.rightWhiskers.transform = CGAffineTransform(rotationAngle: -0.02);
        }) { (_) in
            print("Rotating whiskers up.")
        }
        UIView.animate(withDuration: 1.5, delay: 2.0, options: .curveEaseIn, animations: {
            self.leftWhiskers.alpha = 0.0;
            self.rightWhiskers.alpha = 0.0;
            self.bunnyNoWhiskers.alpha = 0.0;
        }) { (_) in
            print("Fading out.")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5, execute: {
            self.performSegue(withIdentifier: "ShowMainScreen", sender: nil)
        })
    }
}

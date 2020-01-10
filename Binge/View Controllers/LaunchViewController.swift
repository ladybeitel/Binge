//
//  LaunchViewController.swift
//  Binge
//
//  Created by Ciara Beitel on 1/9/20.
//  Copyright © 2020 Ciara Beitel. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    
    var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureImageView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        imageView.center = self.view.center
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func configureImageView() {
        imageView = UIImageView(frame: CGRect(x: view.center.x, y: view.center.y, width: 1024, height: 1024))
        imageView.image = UIImage(named: "Binge-Icons_1024w@1x.png")
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
    }
}

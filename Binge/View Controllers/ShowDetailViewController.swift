//
//  ShowDetailViewController.swift
//  Binge
//
//  Created by Ciara Beitel on 1/7/20.
//  Copyright © 2020 Ciara Beitel. All rights reserved.
//

import UIKit

class ShowDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - Outlets
    @IBOutlet weak var showPosterImage: UIImageView!
    @IBOutlet weak var showName: UILabel!
    @IBOutlet weak var showReleaseDate: UILabel!
    @IBOutlet weak var showGenre: UILabel!
    @IBOutlet weak var showNetwork: UILabel!
    @IBOutlet weak var showStatus: UILabel!
    @IBOutlet weak var showDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

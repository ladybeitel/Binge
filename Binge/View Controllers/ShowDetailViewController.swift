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
    var show: Show? {
        didSet {
            updateView()
        }
    }
    
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
        updateView()
    }
    
    func updateView() {
        guard let show = show, let releaseDate = show.releaseDate else { return }
        if isViewLoaded {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM yyyy"
            showName.text = show.name.capitalized
            showReleaseDate.text = formatter.string(from: releaseDate)
            showNetwork.text = show.network
            showStatus.text = show.status
            showDescription.text = show.overview
        }
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

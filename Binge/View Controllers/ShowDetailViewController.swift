//
//  ShowDetailViewController.swift
//  Binge
//
//  Created by Ciara Beitel on 1/7/20.
//  Copyright © 2020 Ciara Beitel. All rights reserved.
//

import UIKit
import CoreData

struct FakeSeason {
   var episodes: [EpisodeRepresentation]
}
struct FakeData {
    var seasons: [FakeSeason]
}

class ShowDetailViewController: UIViewController {
    
    // MARK: - Properties
    var show: Show? {
        didSet {
            updateView()
        }
    }
    
    var fakeData: FakeData = FakeData(seasons: [])
    
    // MARK: - Outlets
    @IBOutlet weak var showPosterImage: UIImageView!
    @IBOutlet weak var showName: UILabel!
    @IBOutlet weak var showReleaseDate: UILabel!
    @IBOutlet weak var showGenre: UILabel!
    @IBOutlet weak var showNetwork: UILabel!
    @IBOutlet weak var showStatus: UILabel!
    @IBOutlet weak var showDescription: UITextView!
    @IBOutlet weak var showTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        getFakeData()
        showTableView.dataSource = self
        showTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showTableView.reloadData()
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
    
    func getFakeData() {
        let episode1 = EpisodeRepresentation(id: 0001, name: "Pilot", episodeNumber: 1, seriesId: 0001, overview: "Episode Overview")
        let episode2 = EpisodeRepresentation(id: 0002, name: "Diversity Day", episodeNumber: 2, seriesId: 0002, overview: "Episode Overview")
        let episode3 = EpisodeRepresentation(id: 0003, name: "Health Care", episodeNumber: 3, seriesId: 0003, overview: "Episode Overview")
        let episode4 = EpisodeRepresentation(id: 0004, name: "The Alliance", episodeNumber: 4, seriesId: 0004, overview: "Episode Overview")
        let episode5 = EpisodeRepresentation(id: 0005, name: "Basketball", episodeNumber: 5, seriesId: 0005, overview: "Episode Overview")
        let episode6 = EpisodeRepresentation(id: 0001, name: "Hot Girl", episodeNumber: 1, seriesId: 0006, overview: "Episode Overview")
        let episode7 = EpisodeRepresentation(id: 0002, name: "The Dundies", episodeNumber: 2, seriesId: 0007, overview: "Episode Overview")
        let episode8 = EpisodeRepresentation(id: 0003, name: "Office Olympics", episodeNumber: 3, seriesId: 0008, overview: "Episode Overview")
        let episode9 = EpisodeRepresentation(id: 0004, name: "The Fire", episodeNumber: 4, seriesId: 0009, overview: "Episode Overview")
        let episode10 = EpisodeRepresentation(id: 0001, name: "Halloween", episodeNumber: 1, seriesId: 0010, overview: "Episode Overview")
        let episode11 = EpisodeRepresentation(id: 0002, name: "The Fight", episodeNumber: 2, seriesId: 0011, overview: "Episode Overview")
        let episode12 = EpisodeRepresentation(id: 0003, name: "The Client", episodeNumber: 3, seriesId: 0012, overview: "Episode Overview")
        let episode13 = EpisodeRepresentation(id: 0004, name: "Performance Review", episodeNumber: 4, seriesId: 0013, overview: "Episode Overview")
        let episode14 = EpisodeRepresentation(id: 0005, name: "E-Mail Surveillance", episodeNumber: 5, seriesId: 0014, overview: "Episode Overview")
        let episode15 = EpisodeRepresentation(id: 0006, name: "Christmas Party", episodeNumber: 6, seriesId: 0015, overview: "Episode Overview")
        
        let season1 = FakeSeason(episodes: [episode1, episode2, episode3, episode4, episode5])
        let season2 = FakeSeason(episodes: [episode6, episode7, episode8, episode9])
        let season3 = FakeSeason(episodes: [episode10, episode11, episode12, episode13, episode14, episode15])
        fakeData.seasons.append(contentsOf: [season1, season2, season3])
    }
}

// MARK: - Table view data source

extension ShowDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return fakeData.seasons.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            case 0: return "Season 1"
            case 1: return "Season 2"
            case 2: return "Season 3"
            default: return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fakeData.seasons[section].episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell", for: indexPath) as? EpisodeTableViewCell else { return UITableViewCell() }
        
        let episode = fakeData.seasons[indexPath.section].episodes[indexPath.row]
        
        cell.episodeNameLabel.text = episode.name
        cell.episodeNumberLabel.text = String(episode.episodeNumber)
        //cell.episodeWatchedSwitch
        
        return cell
    }
}

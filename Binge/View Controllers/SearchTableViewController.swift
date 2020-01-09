//
//  ShowSearchTableViewController.swift
//  Binge
//
//  Created by Ciara Beitel on 12/26/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import UIKit
import CoreData

class SearchTableViewController: UIViewController {
    
    var searchResults: [ShowRepresentation?] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SearchTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchShowCell", for: indexPath)
        let show = searchResults[indexPath.row]
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        cell.textLabel?.text = show?.name
        if let releaseDate = show?.releaseDate {
            cell.detailTextLabel?.text = formatter.string(from: releaseDate)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedShow = searchResults[indexPath.row]
        guard let show = selectedShow else { return }
        let alertController = UIAlertController(title: "Add \"\(show.name)\"", message: "Do you wish to add \"\(show.name)\" to your Binge list?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Add", style: .default) { alert in
           let context = CoreDataStack.shared.container.newBackgroundContext()
           let _ = Show(showRepresentation: show, context: context)
           CoreDataStack.shared.save(context: context)
           self.navigationController?.popViewController(animated: true)
        })
        present(alertController, animated: true, completion: nil)
    }
}

extension SearchTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text?.lowercased() else { return }
        APIController.shared.searchShows(name: searchText) { (result) in
            DispatchQueue.main.async {
                self.searchResults = result
                self.tableView.reloadData()
            }
        }
    }
}

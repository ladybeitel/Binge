//
//  ShowCollectionViewController.swift
//  Binge
//
//  Created by Ciara Beitel on 12/29/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "ShowCollectionViewCell"

class ShowCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    private var dataSource: UICollectionViewDiffableDataSource<Int, Show>?
    private var dataSourceSnapshot = NSDiffableDataSourceSnapshot<Int, Show>()
    
    lazy var fetchResultsController: NSFetchedResultsController<Show> = {
        let fetchRequest: NSFetchRequest<Show> = Show.createFetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: CoreDataStack.shared.mainContext,
                                             sectionNameKeyPath: "name",
                                             cacheName: nil)
        frc.delegate = self
        do {
            try frc.performFetch()
        } catch {
            fatalError("Error performing fetch for frc: \(error)")
        }
        return frc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource()
    }
    
    func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource <Int, Show>(collectionView: self.collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, show: Show) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ShowCollectionViewCell
            cell.showName.text = show.name
            return cell
        }
        
        updateCollectionView()
    }
    
    func updateCollectionView() {
        dataSourceSnapshot = NSDiffableDataSourceSnapshot<Int, Show>()
        dataSourceSnapshot.appendSections([0])
        dataSourceSnapshot.appendItems(fetchResultsController.fetchedObjects ?? [])
        dataSource?.apply(self.dataSourceSnapshot)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fetchResultsController.sections?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailVCSegue" {
            let destinationVC = segue.destination as? ShowDetailViewController
            destinationVC?.postController = postController
            
        } else if segue.identifier == "ViewVideoPost" {
            let destinationVC = segue.destination as? VideoPostDetailTableViewController
            
            guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
            
            destinationVC?.postController = postController
            destinationVC?.post = postController.posts[indexPath.row]
        }
    }
}

// MARK: - NSFetchedResultsControllerDelegate
extension ShowCollectionViewController: NSFetchedResultsControllerDelegate {
    /// Whenever the `NSFetchedResultsController` data changes, reload the collection view data with animations
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateCollectionView()
    }
}

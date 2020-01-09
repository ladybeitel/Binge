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
enum Section: CaseIterable {
    case added
}

class ShowCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    private var dataSource: UICollectionViewDiffableDataSource<Section, Show>?
    private var dataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, Show>()
    
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
        self.navigationController?.navigationBar.tintColor = UIColor.systemPurple
    }
    
    func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource <Section, Show>(collectionView: self.collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, show: Show) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ShowCollectionViewCell
            if let banner = show.banner {
                cell.showBannerImage.load(url: banner)
            }
            return cell
        }
        updateCollectionView()
    }
    
    func updateCollectionView() {
        dataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, Show>()
        dataSourceSnapshot.appendSections([.added])
        dataSourceSnapshot.appendItems(fetchResultsController.fetchedObjects ?? [])
        dataSource?.apply(self.dataSourceSnapshot)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fetchResultsController.sections?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailVCSegue" {
            guard let detailVC = segue.destination as? ShowDetailViewController,
                let cell = sender as? ShowCollectionViewCell,
                let indexPath = self.collectionView.indexPath(for: cell) else { return }
            
            guard let show = self.dataSource?.itemIdentifier(for: indexPath) else { return }
            detailVC.show = show
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

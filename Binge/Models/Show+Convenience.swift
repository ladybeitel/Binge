//
//  Show+Convenience.swift
//  Binge
//
//  Created by Ciara Beitel on 12/30/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import Foundation
import CoreData

extension Show {
    var showRepresentation: ShowRepresentation? {
        guard let releaseDate = releaseDate else { return nil }
        return ShowRepresentation(poster: poster,
                                  id: id,
                                  name: name,
                                  network: network,
                                  overview: overview,
                                  releaseDate: releaseDate,
                                  status: status)
    }
    
    convenience init(poster: String?, id: Int16, name: String, network: String?, overview: String?, releaseDate: Date?, status: String?, context: NSManagedObjectContext) {
        self.init(context: context)
        self.poster = poster
        self.id = id
        self.name = name
        self.network = network
        self.overview = overview
        self.releaseDate = releaseDate
        self.status = status
    }
    
    @discardableResult convenience init?(showRepresentation: ShowRepresentation, context: NSManagedObjectContext) {
        self.init(poster: showRepresentation.poster,
                  id: showRepresentation.id,
                  name: showRepresentation.name,
                  network: showRepresentation.network,
                  overview: showRepresentation.overview,
                  releaseDate: showRepresentation.releaseDate,
                  status: showRepresentation.status,
                  context: context)
    }
}

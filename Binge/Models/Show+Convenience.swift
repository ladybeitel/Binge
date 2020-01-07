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
        return ShowRepresentation(name: name, releaseDate: releaseDate)
    }
    
    convenience init(name: String, releaseDate: Date?, context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = name
        self.releaseDate = releaseDate
    }
    
    @discardableResult convenience init?(showRepresentation: ShowRepresentation, context: NSManagedObjectContext) {
        guard let releaseDate = showRepresentation.releaseDate else { return nil }
        self.init(name: showRepresentation.name, releaseDate: releaseDate, context: context)
    }
}

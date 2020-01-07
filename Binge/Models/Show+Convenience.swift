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
        return ShowRepresentation(name: name, releaseDate: releaseDate, id: Int(id))
    }
    
    convenience init(name: String, releaseDate: Date?, id: Int, context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = name
        self.releaseDate = releaseDate
        self.id = Int16(id)
    }
    
    @discardableResult convenience init?(showRepresentation: ShowRepresentation, context: NSManagedObjectContext) {
        guard let releaseDate = showRepresentation.releaseDate else { return nil }
        self.init(name: showRepresentation.name, releaseDate: releaseDate, id: showRepresentation.id, context: context)
    }
}

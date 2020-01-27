//
//  Show+CoreDataProperties.swift
//  Binge
//
//  Created by Ciara Beitel on 1/8/20.
//  Copyright © 2020 Ciara Beitel. All rights reserved.
//
//

import Foundation
import CoreData


extension Show {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Show> {
        return NSFetchRequest<Show>(entityName: "Show")
    }

    @NSManaged public var poster: String?
    @NSManaged public var id: Int16
    @NSManaged public var name: String
    @NSManaged public var network: String?
    @NSManaged public var overview: String?
    @NSManaged public var releaseDate: Date?
    @NSManaged public var status: String?
    @NSManaged public var seasons: NSSet?

}

// MARK: Generated accessors for seasons
extension Show {

    @objc(addSeasonsObject:)
    @NSManaged public func addToSeasons(_ value: Season)

    @objc(removeSeasonsObject:)
    @NSManaged public func removeFromSeasons(_ value: Season)

    @objc(addSeasons:)
    @NSManaged public func addToSeasons(_ values: NSSet)

    @objc(removeSeasons:)
    @NSManaged public func removeFromSeasons(_ values: NSSet)

}

//
//  Artist+CoreDataProperties.swift
//  LEDGERº
//
//  Created by Malik Falana on 8/3/22.
//
//

import Foundation
import CoreData


extension Artist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Artist> {
        return NSFetchRequest<Artist>(entityName: "Artist")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var source: Manga?

}

extension Artist : Identifiable {

}

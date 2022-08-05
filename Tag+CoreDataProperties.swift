//
//  Tag+CoreDataProperties.swift
//  LEDGERº
//
//  Created by Malik Falana on 8/3/22.
//
//

import Foundation
import CoreData


extension Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var source: Manga?

}

extension Tag : Identifiable {

}

//
//  Author+CoreDataProperties.swift
//  LEDGERº
//
//  Created by Malik Falana on 8/3/22.
//
//

import Foundation
import CoreData


extension Author {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Author> {
        return NSFetchRequest<Author>(entityName: "Author")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var source: Manga?

}

extension Author : Identifiable {

}

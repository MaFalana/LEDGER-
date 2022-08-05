//
//  Lib+CoreDataProperties.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/24/22.
//
//

import Foundation
import CoreData


extension Lib {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lib> {
        return NSFetchRequest<Lib>(entityName: "Lib")
    }
    
}

// MARK: Generated accessors for data
extension Lib {

    @objc(insertObject:inDataAtIndex:)
    @NSManaged public func insertIntoData(_ value: Manga, at idx: Int)

    @objc(removeObjectFromDataAtIndex:)
    @NSManaged public func removeFromData(at idx: Int)

    @objc(insertData:atIndexes:)
    @NSManaged public func insertIntoData(_ values: [Manga], at indexes: NSIndexSet)

    @objc(removeDataAtIndexes:)
    @NSManaged public func removeFromData(at indexes: NSIndexSet)

    @objc(replaceObjectInDataAtIndex:withObject:)
    @NSManaged public func replaceData(at idx: Int, with value: Manga)

    @objc(replaceDataAtIndexes:withData:)
    @NSManaged public func replaceData(at indexes: NSIndexSet, with values: [Manga])

    @objc(addDataObject:)
    @NSManaged public func addToData(_ value: Manga)

    @objc(removeDataObject:)
    @NSManaged public func removeFromData(_ value: Manga)

    @objc(addData:)
    @NSManaged public func addToData(_ values: NSOrderedSet)

    @objc(removeData:)
    @NSManaged public func removeFromData(_ values: NSOrderedSet)

}

extension Lib : Identifiable {

}

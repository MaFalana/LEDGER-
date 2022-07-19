//
//  RHistory+CoreDataProperties.swift
//  Ledger
//
//  Created by Malik Falana on 7/16/22.
//
//

import Foundation
import CoreData


extension RHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RHistory> {
        return NSFetchRequest<RHistory>(entityName: "RHistory")
    }

    @NSManaged public var data: NSOrderedSet?

}

// MARK: Generated accessors for data
extension RHistory {

    @objc(insertObject:inDataAtIndex:)
    @NSManaged public func insertIntoData(_ value: Chapter, at idx: Int)

    @objc(removeObjectFromDataAtIndex:)
    @NSManaged public func removeFromData(at idx: Int)

    @objc(insertData:atIndexes:)
    @NSManaged public func insertIntoData(_ values: [Chapter], at indexes: NSIndexSet)

    @objc(removeDataAtIndexes:)
    @NSManaged public func removeFromData(at indexes: NSIndexSet)

    @objc(replaceObjectInDataAtIndex:withObject:)
    @NSManaged public func replaceData(at idx: Int, with value: Chapter)

    @objc(replaceDataAtIndexes:withData:)
    @NSManaged public func replaceData(at indexes: NSIndexSet, with values: [Chapter])

    @objc(addDataObject:)
    @NSManaged public func addToData(_ value: Chapter)

    @objc(removeDataObject:)
    @NSManaged public func removeFromData(_ value: Chapter)

    @objc(addData:)
    @NSManaged public func addToData(_ values: NSOrderedSet)

    @objc(removeData:)
    @NSManaged public func removeFromData(_ values: NSOrderedSet)

}

extension RHistory : Identifiable {

}

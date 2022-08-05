//
//  Backup+CoreDataProperties.swift
//  LEDGERº
//
//  Created by Malik Falana on 8/3/22.
//
//

import Foundation
import CoreData


extension Backup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Backup> {
        return NSFetchRequest<Backup>(entityName: "Backup")
    }

    

}

// MARK: Generated accessors for libraries
extension Backup {

    @objc(insertObject:inLibrariesAtIndex:)
    @NSManaged public func insertIntoLibraries(_ value: Lib, at idx: Int)

    @objc(removeObjectFromLibrariesAtIndex:)
    @NSManaged public func removeFromLibraries(at idx: Int)

    @objc(insertLibraries:atIndexes:)
    @NSManaged public func insertIntoLibraries(_ values: [Lib], at indexes: NSIndexSet)

    @objc(removeLibrariesAtIndexes:)
    @NSManaged public func removeFromLibraries(at indexes: NSIndexSet)

    @objc(replaceObjectInLibrariesAtIndex:withObject:)
    @NSManaged public func replaceLibraries(at idx: Int, with value: Lib)

    @objc(replaceLibrariesAtIndexes:withLibraries:)
    @NSManaged public func replaceLibraries(at indexes: NSIndexSet, with values: [Lib])

    @objc(addLibrariesObject:)
    @NSManaged public func addToLibraries(_ value: Lib)

    @objc(removeLibrariesObject:)
    @NSManaged public func removeFromLibraries(_ value: Lib)

    @objc(addLibraries:)
    @NSManaged public func addToLibraries(_ values: NSOrderedSet)

    @objc(removeLibraries:)
    @NSManaged public func removeFromLibraries(_ values: NSOrderedSet)

}

// MARK: Generated accessors for history
extension Backup {

    @objc(insertObject:inHistoryAtIndex:)
    @NSManaged public func insertIntoHistory(_ value: History, at idx: Int)

    @objc(removeObjectFromHistoryAtIndex:)
    @NSManaged public func removeFromHistory(at idx: Int)

    @objc(insertHistory:atIndexes:)
    @NSManaged public func insertIntoHistory(_ values: [History], at indexes: NSIndexSet)

    @objc(removeHistoryAtIndexes:)
    @NSManaged public func removeFromHistory(at indexes: NSIndexSet)

    @objc(replaceObjectInHistoryAtIndex:withObject:)
    @NSManaged public func replaceHistory(at idx: Int, with value: History)

    @objc(replaceHistoryAtIndexes:withHistory:)
    @NSManaged public func replaceHistory(at indexes: NSIndexSet, with values: [History])

    @objc(addHistoryObject:)
    @NSManaged public func addToHistory(_ value: History)

    @objc(removeHistoryObject:)
    @NSManaged public func removeFromHistory(_ value: History)

    @objc(addHistory:)
    @NSManaged public func addToHistory(_ values: NSOrderedSet)

    @objc(removeHistory:)
    @NSManaged public func removeFromHistory(_ values: NSOrderedSet)

}

extension Backup : Identifiable {

}

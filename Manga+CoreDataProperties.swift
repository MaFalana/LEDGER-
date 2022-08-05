//
//  Manga+CoreDataProperties.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 7/14/22.
//
//

import Foundation
import CoreData


extension Manga {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Manga> {
        return NSFetchRequest<Manga>(entityName: "Manga")
    }

    

}

// MARK: Generated accessors for bookmarks
extension Manga {

    @objc(insertObject:inBookmarksAtIndex:)
    @NSManaged public func insertIntoBookmarks(_ value: Chapter, at idx: Int)

    @objc(removeObjectFromBookmarksAtIndex:)
    @NSManaged public func removeFromBookmarks(at idx: Int)

    @objc(insertBookmarks:atIndexes:)
    @NSManaged public func insertIntoBookmarks(_ values: [Chapter], at indexes: NSIndexSet)

    @objc(removeBookmarksAtIndexes:)
    @NSManaged public func removeFromBookmarks(at indexes: NSIndexSet)

    @objc(replaceObjectInBookmarksAtIndex:withObject:)
    @NSManaged public func replaceBookmarks(at idx: Int, with value: Chapter)

    @objc(replaceBookmarksAtIndexes:withBookmarks:)
    @NSManaged public func replaceBookmarks(at indexes: NSIndexSet, with values: [Chapter])

    @objc(addBookmarksObject:)
    @NSManaged public func addToBookmarks(_ value: Chapter)

    @objc(removeBookmarksObject:)
    @NSManaged public func removeFromBookmarks(_ value: Chapter)

    @objc(addBookmarks:)
    @NSManaged public func addToBookmarks(_ values: NSOrderedSet)

    @objc(removeBookmarks:)
    @NSManaged public func removeFromBookmarks(_ values: NSOrderedSet)

}

// MARK: Generated accessors for chapters
extension Manga {

    @objc(insertObject:inChaptersAtIndex:)
    @NSManaged public func insertIntoChapters(_ value: Chapter, at idx: Int)

    @objc(removeObjectFromChaptersAtIndex:)
    @NSManaged public func removeFromChapters(at idx: Int)

    @objc(insertChapters:atIndexes:)
    @NSManaged public func insertIntoChapters(_ values: [Chapter], at indexes: NSIndexSet)

    @objc(removeChaptersAtIndexes:)
    @NSManaged public func removeFromChapters(at indexes: NSIndexSet)

    @objc(replaceObjectInChaptersAtIndex:withObject:)
    @NSManaged public func replaceChapters(at idx: Int, with value: Chapter)

    @objc(replaceChaptersAtIndexes:withChapters:)
    @NSManaged public func replaceChapters(at indexes: NSIndexSet, with values: [Chapter])

    @objc(addChaptersObject:)
    @NSManaged public func addToChapters(_ value: Chapter)

    @objc(removeChaptersObject:)
    @NSManaged public func removeFromChapters(_ value: Chapter)

    @objc(addChapters:)
    @NSManaged public func addToChapters(_ values: NSOrderedSet)

    @objc(removeChapters:)
    @NSManaged public func removeFromChapters(_ values: NSOrderedSet)

}

// MARK: Generated accessors for tags
extension Manga {

    @objc(insertObject:inTagsAtIndex:)
    @NSManaged public func insertIntoTags(_ value: Tag, at idx: Int)

    @objc(removeObjectFromTagsAtIndex:)
    @NSManaged public func removeFromTags(at idx: Int)

    @objc(insertTags:atIndexes:)
    @NSManaged public func insertIntoTags(_ values: [Tag], at indexes: NSIndexSet)

    @objc(removeTagsAtIndexes:)
    @NSManaged public func removeFromTags(at indexes: NSIndexSet)

    @objc(replaceObjectInTagsAtIndex:withObject:)
    @NSManaged public func replaceTags(at idx: Int, with value: Tag)

    @objc(replaceTagsAtIndexes:withTags:)
    @NSManaged public func replaceTags(at indexes: NSIndexSet, with values: [Tag])

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: Tag)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: Tag)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSOrderedSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSOrderedSet)

}

// MARK: Generated accessors for saved
extension Manga {

    @objc(insertObject:inSavedAtIndex:)
    @NSManaged public func insertIntoSaved(_ value: Chapter, at idx: Int)

    @objc(removeObjectFromSavedAtIndex:)
    @NSManaged public func removeFromSaved(at idx: Int)

    @objc(insertSaved:atIndexes:)
    @NSManaged public func insertIntoSaved(_ values: [Chapter], at indexes: NSIndexSet)

    @objc(removeSavedAtIndexes:)
    @NSManaged public func removeFromSaved(at indexes: NSIndexSet)

    @objc(replaceObjectInSavedAtIndex:withObject:)
    @NSManaged public func replaceSaved(at idx: Int, with value: Chapter)

    @objc(replaceSavedAtIndexes:withSaved:)
    @NSManaged public func replaceSaved(at indexes: NSIndexSet, with values: [Chapter])

    @objc(addSavedObject:)
    @NSManaged public func addToSaved(_ value: Chapter)

    @objc(removeSavedObject:)
    @NSManaged public func removeFromSaved(_ value: Chapter)

    @objc(addSaved:)
    @NSManaged public func addToSaved(_ values: NSOrderedSet)

    @objc(removeSaved:)
    @NSManaged public func removeFromSaved(_ values: NSOrderedSet)

}

// MARK: Generated accessors for history
extension Manga {

    @objc(insertObject:inHistoryAtIndex:)
    @NSManaged public func insertIntoHistory(_ value: Chapter, at idx: Int)

    @objc(removeObjectFromHistoryAtIndex:)
    @NSManaged public func removeFromHistory(at idx: Int)

    @objc(insertHistory:atIndexes:)
    @NSManaged public func insertIntoHistory(_ values: [Chapter], at indexes: NSIndexSet)

    @objc(removeHistoryAtIndexes:)
    @NSManaged public func removeFromHistory(at indexes: NSIndexSet)

    @objc(replaceObjectInHistoryAtIndex:withObject:)
    @NSManaged public func replaceHistory(at idx: Int, with value: Chapter)

    @objc(replaceHistoryAtIndexes:withHistory:)
    @NSManaged public func replaceHistory(at indexes: NSIndexSet, with values: [Chapter])

    @objc(addHistoryObject:)
    @NSManaged public func addToHistory(_ value: Chapter)

    @objc(removeHistoryObject:)
    @NSManaged public func removeFromHistory(_ value: Chapter)

    @objc(addHistory:)
    @NSManaged public func addToHistory(_ values: NSOrderedSet)

    @objc(removeHistory:)
    @NSManaged public func removeFromHistory(_ values: NSOrderedSet)

}

extension Manga : Identifiable {

}

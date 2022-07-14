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

    @NSManaged public var cover: String?
    @NSManaged public var id: String
    @NSManaged public var status: String?
    @NSManaged public var synopsis: String?
    @NSManaged public var title: String
    @NSManaged public var artist: Artist?
    @NSManaged public var author: Author?
    @NSManaged public var bookmarks: NSOrderedSet?
    @NSManaged public var chapters: NSOrderedSet?
    @NSManaged public var tags: NSOrderedSet?

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

extension Manga : Identifiable {

}

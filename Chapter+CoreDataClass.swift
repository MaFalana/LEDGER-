//
//  Chapter+CoreDataClass.swift
//  LEDGERº
//
//  Created by Malik Falana on 7/25/22.
//
//

import Foundation
import CoreData

@objc(Chapter)
public class Chapter: NSManagedObject
{
    @NSManaged public var chapterNumber: String?
    @NSManaged public var id: String?
    @NSManaged public var isBookmarked: Bool
    @NSManaged public var pages: Int64
    @NSManaged public var publishDate: Date?
    @NSManaged public var savedPages: [String]?
    @NSManaged public var title: String?
    @NSManaged public var externalURL: String?
    @NSManaged public var primary: Manga?
    @NSManaged public var secondary: Manga?
    @NSManaged public var source: Manga?
    
//    enum CodingKeys: String, CodingKey
//    {
//        case chapterNumber = "chapterNumber"
//        case id = "id"
//        case isBookmarked = "isBookmarked"
//        case pages = "pages"
//        case publishDate = "publishDate"
//        case savedPages = "savedPages"
//        case title = "title"
//        case externalURL = "externalURL"
//        case primary = "primary"
//        case secondary = "secondary"
//        case source = "source"
//    }
//
//
//    required public convenience init(from decoder: Decoder) throws
//    {
//        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError() }
//        guard let entity = NSEntityDescription.entity(forEntityName: "Chapter", in: context) else { fatalError() }
//
//        self.init(entity: entity, insertInto: context)
//
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        chapterNumber = try values.decode(String.self, forKey: CodingKeys.chapterNumber)
//        id = try values.decode(String.self, forKey: CodingKeys.id)
//        isBookmarked = try values.decode(Bool.self, forKey: CodingKeys.isBookmarked)
//        pages = try values.decode(Int64.self, forKey: CodingKeys.pages)
//        publishDate = try values.decode(Date.self, forKey: CodingKeys.publishDate)
//        savedPages = try values.decode([String].self, forKey: CodingKeys.savedPages)
//        title = try values.decode(String.self, forKey: CodingKeys.title)
//        externalURL = try values.decode(String.self, forKey: CodingKeys.externalURL)
//        primary = try values.decode(Manga.self, forKey: CodingKeys.primary)
//        secondary = try values.decode(Manga.self, forKey: CodingKeys.secondary)
//        source = try values.decode(Manga.self, forKey: CodingKeys.source)
//    }
}

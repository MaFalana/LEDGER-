//
//  Manga+CoreDataClass.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 7/14/22.
//
//

import Foundation
import CoreData

@objc(Manga)
public class Manga: NSManagedObject
{
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
    @NSManaged public var saved: NSOrderedSet?
    
//    enum CodingKeys: String, CodingKey
//    {
//        case cover = "cover"
//        case id = "id"
//        case status = "status"
//        case synopsis = "synopsis"
//        case title = "title"
//        case artist = "artist"
//        case author = "author"
//        case bookmarks = "bookmarks"
//        case chapters = "chapters"
//        case tags = "tags"
//        case saved = "saved"
//    }
//
//    required public convenience init(from decoder: Decoder) throws
//    {
//        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError() }
//        guard let entity = NSEntityDescription.entity(forEntityName: "Manga", in: context) else { fatalError() }
//
//        self.init(entity: entity, insertInto: context)
//
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        cover = try values.decode(String.self, forKey: CodingKeys.cover)
//        id = try values.decode(String.self, forKey: CodingKeys.id)
//        status = try values.decode(String.self, forKey: CodingKeys.status)
//        synopsis = try values.decode(String.self, forKey: CodingKeys.synopsis)
//        title = try values.decode(String.self, forKey: CodingKeys.title)
//        artist = try values.decode(Artist.self, forKey: CodingKeys.artist)
//        author = try values.decode(Author.self, forKey: CodingKeys.author)
//        bookmarks = try values.decode(Set<Chapter>.self, forKey: CodingKeys.bookmarks)
//        chapters = try values.decode(Set<Chapter>.self, forKey: CodingKeys.chapters)
//        tags = try values.decode(Set<Tag>.self, forKey: CodingKeys.tags)
//        saved = try values.decode(Set<Chapter>.self, forKey: CodingKeys.saved)
//    }
}


extension CodingUserInfoKey
{
    static let context = CodingUserInfoKey(rawValue: "context")
}

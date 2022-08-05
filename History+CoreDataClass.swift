//
//  History+CoreDataClass.swift
//  LEDGERº
//
//  Created by Malik Falana on 8/1/22.
//
//

import Foundation
import CoreData

@objc(History)
public class History: NSManagedObject
{
     @NSManaged public var readDate: Date?
     @NSManaged public var chapter: Chapter?
    
//    enum CodingKeys: String, CodingKey
//    {
//        case readDate = "readDate"
//        case chapter = "chapter"
//    }
//
//    required public convenience init(from decoder: Decoder) throws
//    {
//        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError() }
//        guard let entity = NSEntityDescription.entity(forEntityName: "History", in: context) else { fatalError() }
//
//        self.init(entity: entity, insertInto: context)
//
//
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        readDate = try values.decode(Date.self, forKey: CodingKeys.readDate)
//        chapter = try values.decode(Chapter.self, forKey: CodingKeys.chapter)
//    }
}

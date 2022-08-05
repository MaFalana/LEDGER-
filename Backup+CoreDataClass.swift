//
//  Backup+CoreDataClass.swift
//  LEDGERº
//
//  Created by Malik Falana on 8/3/22.
//
//

import Foundation
import CoreData

@objc(Backup)
public class Backup: NSManagedObject
{

    @NSManaged public var creationDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var libraries: NSOrderedSet?
    @NSManaged public var history: NSOrderedSet?
    
//    enum CodingKeys: String, CodingKey
//    {
//        case creationDate = "creationDate"
//        case id = "id"
//        case libraries = "libraries"
//        case history = "history"
//    }
//
//    required public convenience init(from decoder: Decoder) throws
//    {
//        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError() }
//        guard let entity = NSEntityDescription.entity(forEntityName: "Backup", in: context) else { fatalError() }
//
//        self.init(entity: entity, insertInto: context)
//
//
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        creationDate = try values.decode(Date.self, forKey: CodingKeys.creationDate)
//        id = try values.decode(UUID.self, forKey: CodingKeys.id)
//        libraries = try values.decode(Set<Lib>.self, forKey: CodingKeys.libraries)
//        history = try values.decode(Set<History>.self, forKey: CodingKeys.history)
//    }
}

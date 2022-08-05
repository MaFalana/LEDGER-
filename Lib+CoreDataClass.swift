//
//  Lib+CoreDataClass.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/24/22.
//
//

import Foundation
import CoreData

@objc(Lib)
public class Lib: NSManagedObject
{
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var data: NSOrderedSet?
    
//    enum CodingKeys: String, CodingKey
//    {
//        case id = "id"
//        case name = "name"
//        case data = "data"
//    }
//
//    required public convenience init(from decoder: Decoder) throws
//    {
//        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError() }
//        guard let entity = NSEntityDescription.entity(forEntityName: "Lib", in: context) else { fatalError() }
//        //let entity = NSEntityDescription.entity(forEntityName: "Lib", in: context)!
//
//        self.init(entity: entity, insertInto: context)
//
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decode(UUID.self, forKey: CodingKeys.id)
//        name = try values.decode(String.self, forKey: CodingKeys.name)
//        data = try values.decode(Set<Manga>.self, forKey: CodingKeys.data)
//    }

}

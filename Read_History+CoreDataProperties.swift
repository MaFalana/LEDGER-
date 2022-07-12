//
//  Read_History+CoreDataProperties.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 7/10/22.
//
//

import Foundation
import CoreData


extension Read_History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Read_History> {
        return NSFetchRequest<Read_History>(entityName: "Read_History")
    }

    @NSManaged public var data: [Chapter]?

}

extension Read_History : Identifiable {

}

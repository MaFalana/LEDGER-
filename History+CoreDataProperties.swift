//
//  History+CoreDataProperties.swift
//  LEDGERº
//
//  Created by Malik Falana on 8/1/22.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    

}

extension History : Identifiable {

}

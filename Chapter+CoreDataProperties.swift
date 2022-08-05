//
//  Chapter+CoreDataProperties.swift
//  LEDGERº
//
//  Created by Malik Falana on 7/25/22.
//
//

import Foundation
import CoreData


extension Chapter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Chapter> {
        return NSFetchRequest<Chapter>(entityName: "Chapter")
    }



}

extension Chapter : Identifiable {

}

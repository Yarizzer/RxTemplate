//
//  ItemEntity+CoreDataProperties.swift
//  
//
//  Created by Yaroslav Abaturov on 12.02.2023.
//
//

import Foundation
import CoreData


extension ItemEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemEntity> {
        return NSFetchRequest<ItemEntity>(entityName: Constants.entityName)
    }

    @NSManaged public var uid: UUID
    @NSManaged public var title: String
    @NSManaged public var lastSelected: Bool
}

extension ItemEntity {
    private struct Constants {
        static let entityName = "ItemEntity"
    }
}

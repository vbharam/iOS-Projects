//
//  ItemType+CoreDataProperties.swift
//  DreamLister
//
//  Created by Vishal Bharam on 9/22/16.
//  Copyright © 2016 Codecoop. All rights reserved.
//

import Foundation
import CoreData

extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType");
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}

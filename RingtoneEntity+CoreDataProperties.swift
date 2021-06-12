//
//  RingtoneEntity+CoreDataProperties.swift
//  Wakey
//
//  Created by Student on 11.06.21.
//
//

import Foundation
import CoreData


extension RingtoneEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RingtoneEntity> {
        return NSFetchRequest<RingtoneEntity>(entityName: "RingtoneEntity")
    }

    @NSManaged public var title: String?
    @NSManaged public var path: String?

}

extension RingtoneEntity : Identifiable {

}

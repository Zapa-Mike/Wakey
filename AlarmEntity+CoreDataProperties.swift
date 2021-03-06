//
//  AlarmEntity+CoreDataProperties.swift
//  Wakey
//
//  Created by Student on 13.06.21.
//
//

import Foundation
import CoreData


extension AlarmEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AlarmEntity> {
        return NSFetchRequest<AlarmEntity>(entityName: "AlarmEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var mission: String?
    @NSManaged public var repeatAlarm: Bool
    @NSManaged public var ringtone: String?
    @NSManaged public var scheduledTime: Date?
    @NSManaged public var title: String?
    @NSManaged public var wakeUpWisdom: Bool

}

extension AlarmEntity : Identifiable {

}

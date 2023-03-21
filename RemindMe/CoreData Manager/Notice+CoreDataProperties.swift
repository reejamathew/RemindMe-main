//
//  Notice+CoreDataProperties.swift
//  RemindMe
//
//  Created by Sethuram Vijayakumar on 2022-12-02.
//
//

import Foundation
import CoreData


extension Notice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notice> {
        return NSFetchRequest<Notice>(entityName: "Notice")
    }

    @NSManaged public var date: String?
    @NSManaged public var imagedata: Data?
    @NSManaged public var notice: String?
    @NSManaged public var title: String?
    @NSManaged public var emailId:String?

}

extension Notice : Identifiable {

}

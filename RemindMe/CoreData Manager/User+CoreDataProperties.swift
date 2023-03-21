//
//  User+CoreDataProperties.swift
//  RemindMe
//
//  Created by Sethuram Vijayakumar on 2022-12-02.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var gender: String?
    @NSManaged public var lastName: String?
    @NSManaged public var password: String?
    @NSManaged public var emailId: String?

}

extension User : Identifiable {

}

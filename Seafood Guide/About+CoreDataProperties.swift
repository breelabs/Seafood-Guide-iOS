//
//  About+CoreDataProperties.swift
//  
//
//  Created by Ibrahim Hassan on 11/12/19.
//
//

import Foundation
import CoreData


extension About {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<About> {
        return NSFetchRequest<About>(entityName: "About")
    }

    @NSManaged public var descnews: String?
    @NSManaged public var linknews: String?
    @NSManaged public var titlenews: String?
    
    @objc dynamic var uppercaseFirstLetterOfName: String {
        get {
            return String.init(titlenews?.uppercased().first ?? Character.init(""))
        }
    }
}

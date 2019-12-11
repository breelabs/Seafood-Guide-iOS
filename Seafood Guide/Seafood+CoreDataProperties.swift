//
//  Seafood+CoreDataProperties.swift
//  
//
//  Created by Ibrahim Hassan on 11/12/19.
//
//

import Foundation
import CoreData


extension Seafood {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Seafood> {
        return NSFetchRequest<Seafood>(entityName: "Seafood")
    }

    @NSManaged public var bad: String?
    @NSManaged public var desc: String?
    @NSManaged public var fishtype: String?
    @NSManaged public var good: String?
    @NSManaged public var name: String?
    @NSManaged public var region: String?
    
    @objc dynamic public var uppercaseFirstLetterOfName: String {
        get {
            return String(name?.uppercased().first ?? Character.init("")) 
        }
    }

}

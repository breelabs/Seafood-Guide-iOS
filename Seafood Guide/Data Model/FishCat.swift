//  Converted to Swift 5.1 by Swiftify v5.1.26565 - https://objectivec2swift.com/
//
//  FishCat.swift
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

import CoreData
import Foundation
import UIKit

@objcMembers class FishCat: NSObject {
    var window: UIWindow?
    var caption = ""
    var image: UIImage?
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?
    var managedObjectContext: NSManagedObjectContext?

    init(caption theCaption: String?, andImage theImage: UIImage?) {
        super.init()
        caption = theCaption ?? ""
        image = theImage
    }

    class func getSampleData() -> [AnyHashable]? {

        let fish1 = FishCat(caption: "Mild Fish", andImage: UIImage(named: "fish1"))

        let fish2 = FishCat(caption: "Thicker & Flavorful", andImage: UIImage(named: "fish2"))

        let fish3 = FishCat(caption: "Steak Like Fish", andImage: UIImage(named: "fish3"))

        let fish4 = FishCat(caption: "Small Fish", andImage: UIImage(named: "fish4"))

        let fish5 = FishCat(caption: "Shell Fish", andImage: UIImage(named: "fish5"))

        let fish6 = FishCat(caption: "Other", andImage: UIImage(named: "fish6"))

        let fish7 = FishCat(caption: "All Fish", andImage: UIImage(named: "allfish.png"))

        let fish8 = FishCat(caption: "Dirty Dozen", andImage: UIImage(named: "donteat"))


        return [fish1, fish2, fish3, fish4, fish5, fish6, fish7, fish8]
    }
}

//  Converted to Swift 5.1 by Swiftify v5.1.26565 - https://objectivec2swift.com/
//
//  config.swift
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

import Foundation


//Feed
let URLFluxXmlNEWS = ""
let URLFluxXmlHome = ""


//Mail
let Mail = ""
let MailSubject = "Smart Seafood Guide iOS App"
let MailMessage = "A message from the Smart Seafood Guide iOS App"

//Map
let MapLatitude = 39.0402
let MapLongitude = -76.998328
let Title = ""
let SubTitle = ""

@objcMembers
class config: NSObject {
    //Feed RSS-XML
    class func getFeedNEWS() -> String? {
        return URLFluxXmlNEWS
    }

    class func getFeedHome() -> String? {
        return URLFluxXmlHome
    }

    //Mail
    class func getMail() -> String {
        return Mail
    }

    class func getMailSubject() -> String? {
        return MailSubject
    }

    class func getMailMessage() -> String? {
        return MailMessage
    }

    //Map
    class func getLatitude() -> Double {
        return MapLatitude
    }

    class func getLongitude() -> Double {
        return MapLongitude
    }

    class func getTitle() -> String? {
        return Title
    }

    class func getSubTitle() -> String? {
        return SubTitle
    }
}

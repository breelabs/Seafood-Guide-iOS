//
//  config.m
//  Oodeo
//
//  Created by paul favier on 19/11/13.
//  Copyright (c) 2013 MonCocoPilote. All rights reserved.
//

#import "config.h"

//Feed
#define URLFluxXmlNEWS @"http://www.imamac.guru/ios-news.xml"
#define URLFluxXmlHome @"http://www.imamac.guru/ios.xml"


//Mail
#define Mail @""
#define MailSubject @"MG Help Request!"
#define MailMessage @"A Mac Support message from the Mac Gurus App"

//Map
#define MapLatitude 39.0402
#define MapLongitude -76.998328
#define Title @"Mac Gurus"
#define SubTitle @"Serving the DC, MD and VA Regions"

@implementation config

+(NSString *)getFeedNEWS{
    return URLFluxXmlNEWS;
}

+(NSString *)getFeedHome{
    return URLFluxXmlHome;
}


+(NSString *)getMailSubject
{
    return MailSubject;
}

+(NSString *)getMail
{
    return Mail;
}

+(NSString *)getMailMessage
{
    return MailMessage;
}


+(double)getLatitude
{
    return MapLatitude;
}

+(double)getLongitude
{
    return MapLongitude;
}

+(NSString *)getTitle
{
    return Title;
}

+(NSString *)getSubTitle
{
    return SubTitle;
}

@end

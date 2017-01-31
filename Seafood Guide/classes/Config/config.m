//
//  config.m
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import "config.h"

//Feed
#define URLFluxXmlNEWS @""
#define URLFluxXmlHome @""


//Mail
#define Mail @""
#define MailSubject @"Smart Seafood Guide iOS App"
#define MailMessage @"A message from the Smart Seafood Guide iOS App"

//Map
#define MapLatitude 39.0402
#define MapLongitude -76.998328
#define Title @""
#define SubTitle @""

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

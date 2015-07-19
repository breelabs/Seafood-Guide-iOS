//
//  config.h
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface config : NSObject

//Feed RSS-XML
+(NSString *)getFeedNEWS;
+(NSString *)getFeedHome;

//Mail
+(NSString *)getMail;
+(NSString *)getMailSubject;
+(NSString *)getMailMessage;

//Map
+(double)getLatitude;
+(double)getLongitude;
+(NSString *)getTitle;
+(NSString *)getSubTitle;

@end

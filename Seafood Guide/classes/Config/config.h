//
//  config.h
//  Oodeo
//
//  Created by paul favier on 19/11/13.
//  Copyright (c) 2013 MonCocoPilote. All rights reserved.
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

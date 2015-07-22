//
//  About.h
//  Seafood Guide
//
//  Created by Jon on 7/20/15.
//  Copyright (c) 2015 Jon Brown Designs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface About : NSManagedObject

@property (nonatomic, retain) NSString * descnews;
@property (nonatomic, retain) NSString * linknews;
@property (nonatomic, retain) NSString * titlenews;

@end

//
//  Lingo.h
//  Seafood Guide
//
//  Created by Jon on 7/13/15.
//  Copyright (c) 2015 Jon Brown Designs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Lingo : NSManagedObject

@property (nonatomic, retain) NSString * linknews;
@property (nonatomic, retain) NSString * descnews;
@property (nonatomic, retain) NSString * titlenews;
@property (nonatomic, retain) NSString * imageurl;

@end

//
//  Seafood.h
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Seafood : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * fishtype;
@property (nonatomic, retain) NSString * bad;
@property (nonatomic, retain) NSString * good;
@property (nonatomic, retain) NSString * region;

@end

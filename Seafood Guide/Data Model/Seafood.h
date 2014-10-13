//
//  Seafood.h
//  Seafood Guide
//
//  Created by Remote Admin on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
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

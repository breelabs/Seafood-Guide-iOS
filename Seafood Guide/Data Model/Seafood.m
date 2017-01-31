//
//  Seafood.m
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import "Seafood.h"


@implementation Seafood

@dynamic bad;
@dynamic desc;
@dynamic fishtype;
@dynamic good;
@dynamic name;
@dynamic region;

- (NSString *)uppercaseFirstLetterOfName {
    NSString *aString = [[self valueForKey:@"name"] uppercaseString];
    
    // support UTF-16:
    NSString *stringToReturn = [aString substringWithRange:[aString rangeOfComposedCharacterSequenceAtIndex:0]];
    
    // OR no UTF-16 support:
    //NSString *stringToReturn = [aString substringToIndex:1];
    
    return stringToReturn;
}

@end

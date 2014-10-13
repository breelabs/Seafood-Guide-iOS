//
//  Seafood.m
//  Seafood Guide
//
//  Created by Remote Admin on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
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

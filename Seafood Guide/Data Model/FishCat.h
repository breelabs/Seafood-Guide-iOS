//
//  FishCat.h
//  Seafood Guide
//
//  Created by Remote Admin on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface FishCat : NSObject

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, copy) NSString* caption;

@property (nonatomic, retain) UIImage* image;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

-(id)initWithCaption:(NSString*)theCaption andImage:(UIImage*)theImage;

+(NSArray*)getSampleData;

@end

//
//  FishCat.h
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface FishCat : NSObject

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, copy) NSString *caption;

@property (nonatomic, retain) UIImage *image;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

-(id)initWithCaption:(NSString*)theCaption andImage:(UIImage*)theImage;

+(NSArray*)getSampleData;

@end

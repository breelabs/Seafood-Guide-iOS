//
//  FishCat.m
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import "FishCat.h"


@implementation FishCat

@synthesize window = _window;
@synthesize caption, image;
@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize managedObjectContext = __managedObjectContext;

-(id)initWithCaption:(NSString*)theCaption andImage:(UIImage*)theImage
{
    self = [super init];
    
    if(self)
    {
        
    }
    self.caption = theCaption;
    self.image = theImage;
    
    return self;
}

+(NSArray*)getSampleData
{
    
    FishCat* fish1 = [[FishCat alloc] initWithCaption:@"Mild Fish" andImage:[UIImage imageNamed:@"fish1"]];
    
    FishCat* fish2 = [[FishCat alloc] initWithCaption:@"Thicker & Flavorful" andImage:[UIImage imageNamed:@"fish2"]];
    
    FishCat* fish3 = [[FishCat alloc] initWithCaption:@"Steak Like Fish" andImage:[UIImage imageNamed:@"fish3"]];
    
    FishCat* fish4 = [[FishCat alloc] initWithCaption:@"Small Fish" andImage:[UIImage imageNamed:@"fish4"]];
    
    FishCat* fish5 = [[FishCat alloc] initWithCaption:@"Shell Fish" andImage:[UIImage imageNamed:@"fish5"]];
    
    FishCat* fish6 = [[FishCat alloc] initWithCaption:@"Other" andImage:[UIImage imageNamed:@"fish6"]];
    
    FishCat* fish7 = [[FishCat alloc] initWithCaption:@"All Fish" andImage:[UIImage imageNamed:@"allfish.png"]];
    
    FishCat* fish8 = [[FishCat alloc] initWithCaption:@"Dirty Dozen" andImage:[UIImage imageNamed:@"donteat"]];
    
    
    return [NSArray arrayWithObjects:fish1, fish2, fish3, fish4, fish5, fish6, fish7, fish8, nil];
}


@end

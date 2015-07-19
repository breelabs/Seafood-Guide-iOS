//
//  FishTVC.h
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h" // so we can fetch
#import "Seafood.h"
#import "TVCDetailViewController.h"
#import "GridViewController.h"

@interface FishTVC : CoreDataTableViewController <UITableViewDelegate,UITableViewDataSource>
{
    NSString *predicateKey;
    NSString *uppercaseFirstLetterOfName;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (id)initWithFishSize:(NSString *)size;

@end

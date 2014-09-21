//
//  FishTVC.h
//  Seafood Guide
//
//  Created by Remote Admin on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
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
@property(nonatomic, retain) NSString *yourStringProperty;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationBarTitle;

- (id)initWithFishSize:(NSString *)size;

@end

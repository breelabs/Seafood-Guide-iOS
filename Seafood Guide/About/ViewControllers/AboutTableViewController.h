//
//  AboutTableViewController.h
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailAboutViewController.h"
#import "CoreDataTableViewController.h" // so we can fetch
#import "About.h"

@interface AboutTableViewController : UITableViewController <UITableViewDelegate,UITableViewDataSource,UINavigationBarDelegate, UINavigationControllerDelegate>
{
    NSString *uppercaseFirstLetterOfName;
    NSString *predicateKey;
    DetailAboutViewController *_detailAboutViewController;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController1;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController2;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (retain) DetailAboutViewController *detailAboutViewController;
@end

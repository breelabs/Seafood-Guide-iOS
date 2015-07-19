//
//  LingoTableViewController.h
//  Seafood Guide
//
//  Created by Jon Brown on 9/1/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailLingoViewController.h"
#import "CoreDataTableViewController.h" // so we can fetch
#import "Lingo.h"

@interface LingoTableViewController : UITableViewController <UITableViewDelegate,UITableViewDataSource,UINavigationBarDelegate, UINavigationControllerDelegate>
{
    NSString *uppercaseFirstLetterOfName;
    NSString *predicateKey;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (id)initWithLingoSize:(NSString *)size;

@end

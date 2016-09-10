//
//  GridViewController.h
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AQGridView.h"
#import <CoreData/CoreData.h>
#import "FishTVC.h"

@interface GridViewController : UIViewController <AQGridViewDelegate, AQGridViewDataSource>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) IBOutlet AQGridView * gridView;

@property (nonatomic, retain) NSArray * services;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
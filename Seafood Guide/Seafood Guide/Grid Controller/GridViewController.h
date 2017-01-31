//
//  GridViewController.h
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "FishTVC.h"

@interface GridViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
{
    IBOutlet UIButton *customButtonHome;
}
@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) NSArray * services;
@property (nonatomic, retain) NSArray * recipeImages;
@property (nonatomic, retain) IBOutlet UICollectionView *myCollectionView;
@property (retain) TVCDetailViewController *detailNewsViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;



@end

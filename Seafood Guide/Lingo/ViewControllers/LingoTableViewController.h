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
    NSArray *_objects;
    NSMutableData *_responseData;
    DetailLingoViewController *_detailLingoViewController;
    UIButton * backButton ;
    NSMutableDictionary *animals;
    NSArray *animalSectionTitles;
    NSArray *animalSectionImg;
    NSArray *animalSectionDesc;
    NSString *uppercaseFirstLetterOfName;
    NSString *predicateKey;
}

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,retain) NSMutableArray *imageArray;
@property(nonatomic,retain) NSMutableArray *titleArray;
@property(nonatomic,retain) NSMutableArray *descArray;
@property (nonatomic, retain) IBOutlet UITableView *LingoTbView;
@property (nonatomic, strong) IBOutlet UIButton* directionsButton;

@property (retain) DetailLingoViewController *detailLingoViewController;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

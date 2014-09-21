//
//  AboutTableViewController.h
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailAboutViewController.h"

@interface AboutTableViewController : UITableViewController <UITableViewDelegate,UITableViewDataSource,UINavigationBarDelegate, UINavigationControllerDelegate>
{
    NSArray *_objects;
    NSMutableData *_responseData;
    DetailAboutViewController *_detailAboutViewController;
    UIButton * backButton ;
    
}


@property(nonatomic,retain) NSMutableArray *titleArray;
@property(nonatomic,retain) NSMutableArray *descArray;

@property(nonatomic,retain) NSMutableArray *titleSec2Array;
@property(nonatomic,retain) NSMutableArray *descSec2Array;

@property(nonatomic,retain) NSMutableArray *titleSec3Array;
@property(nonatomic,retain) NSMutableArray *descSec3Array;


@property (nonatomic, retain) IBOutlet UITableView *AboutTbView;
@property (nonatomic, strong) IBOutlet UIButton* directionsButton;

@property (retain) DetailAboutViewController *detailAboutViewController;

@end

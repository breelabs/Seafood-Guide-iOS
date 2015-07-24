//
//  NewsViewController.h
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailNewsViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface NewsViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UINavigationBarDelegate, UINavigationControllerDelegate>
{
    NSArray *_objects;
    NSMutableData *_responseData;
    DetailNewsViewController *_detailNewsViewController;
    UIButton * backButton ;
}

@property (nonatomic, assign) IBOutlet UIView *cautionView;
@property (strong, nonatomic) IBOutlet UIButton *btnToggle;
@property (nonatomic, retain) IBOutlet UITableView *NewsTbView;
@property(nonatomic,retain) NSMutableArray *numArray;
@property(nonatomic,retain) NSMutableArray *imageArray;
@property(nonatomic,retain) NSMutableArray *titleArray;
@property(nonatomic,retain) NSMutableArray *descArray;
@property (nonatomic, strong) IBOutlet UIButton* directionsButton;

@property (retain) DetailNewsViewController *detailNewsViewController;

-(IBAction)btnToggleClick:(id)sender;

@end

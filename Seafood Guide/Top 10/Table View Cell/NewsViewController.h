//
//  NewsViewController.h
//  Oodeo
//
//  Created by paul favier on 15/11/13.
//  Copyright (c) 2013 MonCocoPilote. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailNewsViewController.h"

@interface NewsViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UINavigationBarDelegate, UINavigationControllerDelegate>
{
    NSArray *_objects;
    NSMutableData *_responseData;
    DetailNewsViewController *_detailNewsViewController;
    UIButton * backButton ;
}

@property (strong, nonatomic) IBOutlet UIView *cautionView;
@property (strong, nonatomic) IBOutlet UIButton *btnToggle;
@property (nonatomic, retain) IBOutlet UITableView *NewsTbView;
@property(nonatomic,retain) NSMutableArray *imageArray;
@property(nonatomic,retain) NSMutableArray *titleArray;
@property(nonatomic,retain) NSMutableArray *descArray;
@property (nonatomic, strong) IBOutlet UIButton* directionsButton;

@property (retain) DetailNewsViewController *detailNewsViewController;

-(IBAction)btnToggleClick:(id)sender;

@end

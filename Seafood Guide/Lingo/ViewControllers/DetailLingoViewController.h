//
//  DetailLingoViewController.h
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "ProgressHUD.h"

@class Lingo;

@interface DetailLingoViewController : UITableViewController <UIWebViewDelegate,MFMailComposeViewControllerDelegate>

{
    NSString *str;
    
}

@property (nonatomic, strong) Lingo *item;
@property (nonatomic, strong) IBOutlet UIButton* directionsButton;


@end

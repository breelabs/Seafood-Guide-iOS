//
//  TVCDetailViewController.h
//  Seafood Guide
//
//  Created by Remote Admin on 7/18/12.
//
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "ProgressHUD.h"

@class Seafood;

@interface TVCDetailViewController : UITableViewController <UIWebViewDelegate,MFMailComposeViewControllerDelegate> {
    NSString * str;
}

@property (nonatomic, strong) Seafood *item;
@property (nonatomic, strong) IBOutlet UIButton* directionsButton;


@end

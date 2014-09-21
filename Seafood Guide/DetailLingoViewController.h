//
//  DetailLingoViewController.h
//  Seafood Guide
//
//  Created by Jon Brown on 9/1/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailLingoViewController : UIViewController <UINavigationBarDelegate, UINavigationControllerDelegate>

{
    NSString *str;
    NSString *lblTitle;
    NSString *txtProject;
    IBOutlet UIButton *customButton;
    IBOutlet UIWindow *window;
    
}

@property(nonatomic,retain) IBOutlet UIImageView *imgView;
@property(nonatomic,retain) IBOutlet UIImageView *backg;
@property(nonatomic,retain) IBOutlet UILabel *lbl;
@property(nonatomic,retain) IBOutlet UILabel *lblshare;
@property(nonatomic,retain) IBOutlet UITextView *txtView;
@property(nonatomic,retain) IBOutlet UIButton *fbButton;
@property(nonatomic,retain) IBOutlet UIButton *twButton;
@property (nonatomic, strong) IBOutlet UIButton* directionsButton;
@property (nonatomic, assign) long myInt;

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSString *lblTitle;
@property (nonatomic, retain) NSString *txtProject;


@end

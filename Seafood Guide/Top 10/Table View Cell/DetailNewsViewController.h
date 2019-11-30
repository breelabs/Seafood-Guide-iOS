//
//  DetailNewsViewController.h
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DetailNewsViewController : UIViewController <UINavigationBarDelegate, UINavigationControllerDelegate>

{
    NSString *str;
    NSString *lblTitle;
    NSString *txtProject;
    IBOutlet UIButton *customButton;
    IBOutlet UIWindow *window;

}

@property(nonatomic,retain) IBOutlet UIImageView *imgView;
@property(nonatomic,retain) IBOutlet UITextView *txtView;
@property (nonatomic, assign) long myInt;

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSString *lblTitle;
@property (nonatomic, retain) NSString *txtProject;


@end

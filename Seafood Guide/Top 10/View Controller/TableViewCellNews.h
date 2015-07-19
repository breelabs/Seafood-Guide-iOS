//
//  TableViewCellNews.h
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCellNews : UITableViewCell

{
    
    IBOutlet UILabel *date;
    IBOutlet UILabel *text;
    IBOutlet UIImageView *image;
    IBOutlet UIImageView *imagetitle;
    IBOutlet UIButton *facebookButton;
    IBOutlet UIButton *twitterButton;
    
}

@property (nonatomic, retain) UILabel *date;
@property (nonatomic, retain) UILabel *text;
@property (nonatomic, retain) UIImageView *image;
@property (nonatomic, retain) UIImageView *imagetitle;
@property (nonatomic, retain) UIButton *facebookButton;
@property (nonatomic, retain) UIButton *twitterButton;
@end

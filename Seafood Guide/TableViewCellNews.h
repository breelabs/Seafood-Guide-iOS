//
//  TableViewCellNews.h
//  Oodeo
//
//  Created by paul favier on 18/11/13.
//  Copyright (c) 2013 MonCocoPilote. All rights reserved.
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

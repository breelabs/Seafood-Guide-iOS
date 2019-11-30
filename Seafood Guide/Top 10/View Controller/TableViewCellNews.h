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
    
    IBOutlet UILabel *text;
    IBOutlet UIImageView *image;
    IBOutlet UILabel *circle;
    IBOutlet UILabel *numb;
    
}

@property (nonatomic, retain) UILabel *date;
@property (nonatomic, retain) UILabel *text;
@property (nonatomic, retain) UILabel *circle;
@property (nonatomic, retain) UILabel *numb;
@property (nonatomic, retain) UIImageView *image;
@property (nonatomic, retain) UIImageView *imagetitle;
@end

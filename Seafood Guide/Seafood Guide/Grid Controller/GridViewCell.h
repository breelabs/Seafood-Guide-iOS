//
//  GridViewCell.h
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AQGridView.h"

@interface GridViewCell : AQGridViewCell

@property (nonatomic, retain) UIImageView * imageView;

@property (nonatomic, retain) UILabel * captionLabel;

@end
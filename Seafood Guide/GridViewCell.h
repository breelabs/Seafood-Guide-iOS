//
//  GridViewCell.h
//  Seafood Guide
//
//  Created by Remote Admin on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AQGridView.h"

@interface GridViewCell : AQGridViewCell

@property (nonatomic, retain) UIImageView * imageView;

@property (nonatomic, retain) UILabel * captionLabel;

@end
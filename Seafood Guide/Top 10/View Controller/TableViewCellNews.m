//
//  TableViewCellNews.m
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import "TableViewCellNews.h"
#import <QuartzCore/QuartzCore.h>

@implementation TableViewCellNews
@synthesize date,text,image,imagetitle,numb,circle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}
- (void)viewDidLoad
{

    
#pragma mark - Button Style
    

}

@end

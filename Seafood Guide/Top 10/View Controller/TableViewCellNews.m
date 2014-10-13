//
//  TableViewCellNews.m
//  Oodeo
//
//  Created by paul favier on 18/11/13.
//  Copyright (c) 2013 MonCocoPilote. All rights reserved.
//

#import "TableViewCellNews.h"

@implementation TableViewCellNews
@synthesize date,text,image,imagetitle,facebookButton,twitterButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

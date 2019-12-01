//
//  DetailNewsViewController.m
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import "DetailNewsViewController.h"
#import "NewsViewController.h"

@interface DetailNewsViewController ()

@end

@implementation DetailNewsViewController
@synthesize txtView,imgView,image,lblTitle,txtProject,myInt;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    #pragma mark - Button Style
    
    // R: 76 G: 76 B: 76
    UIColor *buttColor = [UIColor colorWithRed:(255.0 / 255.0) green:(255.0 / 255.0) blue:(255.0 / 255.0) alpha: 1];
    
    CALayer * layer = [customButton layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:4.0]; //when radius is 0, the border is a rectangle
    [layer setBorderWidth:1.0];
    [layer setBorderColor:[buttColor CGColor]];
    
    NSString* All = [self lblTitle];
    self.navigationItem.title = All;
}

-(void)viewDidAppear:(BOOL)animated
{

    [imgView setImage:image];
    [txtView setText:txtProject];
    [UIView setAnimationDuration:0.5f];
    [self.imgView setAlpha:1];
    [self.txtView setAlpha:1];
    
    [UIView commitAnimations];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self.imgView setImage:nil];
    [self.txtView setText:nil];
    [self.imgView setAlpha:0];
    [self.txtView setAlpha:0];
    

}



- (void)didMoveToParentViewController:(UIViewController *)parent
{
    if (![parent isEqual:self.parentViewController]) {
        
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(UIButton*)createButtonWithFrame:(CGRect)frame andLabel:(NSString*)label
{
    
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    
    [button setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.shadowOffset = CGSizeMake(0, -1);
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    
    [button setTitle:label forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [[button layer] setBorderWidth:1.0f];
    [[button layer] setBorderColor:[UIColor whiteColor].CGColor];
    [[button layer] setMasksToBounds:YES];
    [[button layer] setCornerRadius:4.0]; //when radius is 0, the border is a rectangle
    [[button layer] setBorderWidth:1.0];
    
    return button;
}

-(void)closeView
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
    

    

}

@end

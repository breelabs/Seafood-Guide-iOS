//
//  DetailNewsViewController.m
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import "DetailNewsViewController.h"
#import "NewsViewController.h"
#import <Social/Social.h>

@interface DetailNewsViewController ()

@end

@implementation DetailNewsViewController
@synthesize txtView,imgView,lbl,image,lblTitle,txtProject,backg,lblshare,directionsButton,myInt;

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
    // Do any additional setup after loading the view from its nib.
    
    #pragma mark - Button Style
    
    // R: 76 G: 76 B: 76
    UIColor *buttColor = [UIColor colorWithRed:(255.0 / 255.0) green:(255.0 / 255.0) blue:(255.0 / 255.0) alpha: 1];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
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
    [lbl setText:lblTitle];
    [UIView beginAnimations:@"ResizeAnimation" context:NULL];
    [UIView setAnimationDuration:0.5f];
    [self.imgView setAlpha:1];
    [self.lbl setAlpha:1];
    [self.txtView setAlpha:1];
    [self.backg setAlpha:1];
    [self.fbButton setAlpha:1];
    [self.twButton setAlpha:1];
    [self.lblshare setAlpha:1];
    
    [UIView commitAnimations];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self.imgView setImage:nil];
    [self.lbl setText:nil];
    [self.txtView setText:nil];
    [self.backg setAlpha:0];
    [self.imgView setAlpha:0];
    [self.txtView setAlpha:0];
    [self.lbl setAlpha:0];
    [self.fbButton setAlpha:0];
    [self.twButton setAlpha:0];
    [self.lblshare setAlpha:0];
    

}


- (void)didMoveToParentViewController:(UIViewController *)parent
{
    if (![parent isEqual:self.parentViewController]) {
        //NSLog(@"Back pressed");
        
    }
}

- (IBAction)postToTwitter:(id)sender {
    
    
    SLComposeViewController *tweetSheet = [SLComposeViewController
                                           composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    str = [self txtProject];
    str = [str substringToIndex: MIN(65, [str length])];
    
    NSString *one = [self lblTitle];
    
    NSString* All = [NSString stringWithFormat:@"%@\rDescription:%@", one, str];
    
    [tweetSheet setInitialText:All];
    [self presentViewController:tweetSheet animated:YES completion:nil];
    
}

- (IBAction)postToFacebook:(id)sender {
    
    
    
    SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    [controller setInitialText:txtProject];
    [controller addImage:image];
    [self presentViewController:controller animated:YES completion:Nil];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    //[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
    

    

}

@end

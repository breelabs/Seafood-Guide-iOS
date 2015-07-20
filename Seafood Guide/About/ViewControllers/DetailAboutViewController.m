//
//  DetailAboutViewController.m
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import "DetailAboutViewController.h"
#import <Social/Social.h>

@interface DetailAboutViewController ()

@end

@implementation DetailAboutViewController
@synthesize txtView,lbl,lblTitle,txtProject,backg,lblshare,directionsButton,myInt;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    
    UIImage * backgroundPattern = [UIImage imageNamed:@"Whitey"];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:backgroundPattern]];
    
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"Whitey"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    
    myInt = [[self lblTitle]length];
    if (myInt > 15) {
        str = [self lblTitle];
        str = [str substringToIndex: MIN(25, [str length])];
        NSString* All = [NSString stringWithFormat:@"%@...", str];
        self.navigationItem.title = All;
    } else {
        NSString* All = [self lblTitle];
        self.navigationItem.title = All;
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    
    [txtView setText:txtProject];
    
    NSString *uppercase = [lblTitle uppercaseString];
    
    [lbl setText:uppercase];
    [UIView beginAnimations:@"ResizeAnimation" context:NULL];
    [UIView setAnimationDuration:0.5f];
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
    [self.lbl setText:nil];
    [self.txtView setText:nil];
    [self.backg setAlpha:0];
    [self.txtView setAlpha:0];
    [self.lbl setAlpha:0];
    [self.fbButton setAlpha:0];
    [self.twButton setAlpha:0];
    [self.lblshare setAlpha:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)postToTwitter:(id)sender {
    
    [self urlMkr:@"http://www.google.com"];
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
    
    [self urlMkr:@"http://www.google.com"];
    
    SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    [controller setInitialText:txtProject];
    [self presentViewController:controller animated:YES completion:Nil];
    
}


-(void)urlMkr:(NSString *)makeURL
{
    
    // Set URL String
    
    NSURL *myURL = [NSURL URLWithString:makeURL]; // gets url from string
    NSURLRequest *req = [NSURLRequest requestWithURL:myURL];
    
    // Make the Request
    
    NSURLResponse *resp;
    NSData *data = [NSURLConnection sendSynchronousRequest:req returningResponse:&resp error:NULL];
    
    // for ASYNC[[NSURLConnection alloc] initWithRequest:req delegate:self startImmediately:YES];
    
    if(!data){
        
        UIViewController *myError = [[UIViewController alloc]init];
        myError.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        myError.modalPresentationStyle = UIModalPresentationFormSheet;
        myError.view.backgroundColor = [UIColor blackColor];
        //[self presentModalViewController:myError animated:YES];
        [self presentViewController:myError animated:YES completion:nil];
        
        UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 146,
                                                                     40,
                                                                     472, 260)];
        myLabel.text = @"\n This \n Requires \n A Network \n Connection.";
        myLabel.font = [UIFont boldSystemFontOfSize:48];
        myLabel.backgroundColor = [UIColor clearColor];
        myLabel.shadowColor = [UIColor grayColor];
        myLabel.shadowOffset = CGSizeMake(1,1);
        myLabel.textColor = [UIColor whiteColor];
        myLabel.textAlignment = NSTextAlignmentCenter;
        myLabel.lineBreakMode = NSLineBreakByWordWrapping;
        myLabel.numberOfLines = 18;
        [myLabel sizeToFit];
        [myError.view addSubview:myLabel];
        //[self.myLabel release];
        
        self.directionsButton = [self createButtonWithFrame:CGRectMake(22, 395, 276, 52) andLabel:@"Go Back"];
        
        [myError.view addSubview:directionsButton];
        
        [self.directionsButton addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
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

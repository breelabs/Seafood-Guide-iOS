//
//  AboutTableViewController.m
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import "AboutTableViewController.h"
#import "RXMLElement.h"
#import <Social/Social.h>
#import "DetailAboutViewController.h"

@interface AboutTableViewController ()

@end

@implementation AboutTableViewController

@synthesize tableView = _tableView, AboutTbView,descArray,titleArray,directionsButton,titleSec2Array,descSec2Array,titleSec3Array,descSec3Array;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.descArray = [[NSMutableArray alloc]init];
    self.titleArray = [[NSMutableArray alloc]init];
    
    self.descSec2Array = [[NSMutableArray alloc]init];
    self.titleSec2Array = [[NSMutableArray alloc]init];
    
    self.descSec3Array = [[NSMutableArray alloc]init];
    self.titleSec3Array = [[NSMutableArray alloc]init];
    
    // Add these right after creating the UITableView
    AboutTbView.delegate = self;
    AboutTbView.dataSource = self;
    
    [self refresh];
    
    [self refreshsec2];
    
    [self refreshsec3];
}

-(void)refresh
{
    // Create the request.
    //NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[config getFeedNEWS]]];
    
    // Create url connection and fire request
    //NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    RXMLElement *rootXML = [RXMLElement elementFromXMLFile:@"ios-about-1.xml"];
    
    RXMLElement *rxmlNews = [rootXML child:@"news"];
    
    NSArray *rxmlIndividualNew = [rxmlNews children:@"new"];
    
    //NSLog(@"test nsarray : %@",[[rxmlIndividualNew objectAtIndex:0] child:@"imageurl"]);
    
    for (int i=0; i<rxmlIndividualNew.count; i++) {
        //NSLog(@"i = %d",i);
        
        NSString *title = [NSString stringWithString:[[rxmlIndividualNew objectAtIndex:i] child:@"titlenews"].text];
        NSString *desc = [NSString stringWithString:[[rxmlIndividualNew objectAtIndex:i] child:@"descnews"].text];
        
        [titleArray addObject:title];
        [descArray addObject:desc];
    }
    
    
    [AboutTbView reloadData];
    
}

-(void)refreshsec2
{
    // Create the request.
    //NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[config getFeedNEWS]]];
    
    // Create url connection and fire request
    //NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    RXMLElement *rootXML = [RXMLElement elementFromXMLFile:@"ios-about-2.xml"];
    
    RXMLElement *rxmlNews = [rootXML child:@"news"];
    
    NSArray *rxmlIndividualNew = [rxmlNews children:@"new"];
    
    //NSLog(@"test nsarray : %@",[[rxmlIndividualNew objectAtIndex:0] child:@"imageurl"]);
    
    for (int i=0; i<rxmlIndividualNew.count; i++) {
        //NSLog(@"i = %d",i);
        
        NSString *title = [NSString stringWithString:[[rxmlIndividualNew objectAtIndex:i] child:@"titlenews"].text];
        NSString *desc = [NSString stringWithString:[[rxmlIndividualNew objectAtIndex:i] child:@"descnews"].text];
        
        [titleSec2Array addObject:title];
        [descSec2Array addObject:desc];
    }
    
    
    [AboutTbView reloadData];
    
}

-(void)refreshsec3
{
    // Create the request.
    //NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[config getFeedNEWS]]];
    
    // Create url connection and fire request
    //NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    RXMLElement *rootXML = [RXMLElement elementFromXMLFile:@"ios-about-3.xml"];
    
    RXMLElement *rxmlNews = [rootXML child:@"news"];
    
    NSArray *rxmlIndividualNew = [rxmlNews children:@"new"];
    
    //NSLog(@"test nsarray : %@",[[rxmlIndividualNew objectAtIndex:0] child:@"imageurl"]);
    
    for (int i=0; i<rxmlIndividualNew.count; i++) {
        //NSLog(@"i = %d",i);
        
        NSString *title = [NSString stringWithString:[[rxmlIndividualNew objectAtIndex:i] child:@"titlenews"].text];
        NSString *desc = [NSString stringWithString:[[rxmlIndividualNew objectAtIndex:i] child:@"descnews"].text];
        
        [titleSec3Array addObject:title];
        [descSec3Array addObject:desc];
    }
    
    
    [AboutTbView reloadData];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //return [titleArray count];
    
    if (section == 0) {
		return 6;
	} else if (section == 1) {
		return 1;
	} else if (section == 2) {
        return 4;
    }
    
    return [titleArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    

        // whatever height you'd want for a real section header
    
    NSArray *sectionTitleInfo = @[@"About the Seafood Guide", @"What You Can Do" , @"Labeling"];
        return [sectionTitleInfo objectAtIndex:section];

    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"aboutcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
     if (indexPath.section == 0) {
         cell.textLabel.text = [titleArray objectAtIndex:indexPath.row];
         
     } else if (indexPath.section == 1) {
         cell.textLabel.text = [titleSec2Array objectAtIndex:indexPath.row];
     } else if (indexPath.section == 2) {
         cell.textLabel.text = [titleSec3Array objectAtIndex:indexPath.row];
     }
    
    cell.textLabel.numberOfLines = 0;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [UIView beginAnimations:@"ResizeAnimation" context:NULL];
    [UIView setAnimationDuration:0.5f];
    [UIView commitAnimations];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    DetailAboutViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"detailabout"];
    
    
    if (_detailAboutViewController == nil) {
        
        NSString * storyboardName = @"Main_iPhone";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        self.detailAboutViewController = [storyboard instantiateViewControllerWithIdentifier:@"detailabout"];
        
    }
    
    if (indexPath.section == 0) {
        controller.lblTitle = [titleArray objectAtIndex:indexPath.row];
        controller.txtProject = [descArray objectAtIndex:indexPath.row];
    } else if (indexPath.section == 1) {
        controller.lblTitle = [titleSec2Array objectAtIndex:indexPath.row];
        controller.txtProject = [descSec2Array objectAtIndex:indexPath.row];
    } else if (indexPath.section == 2) {
        controller.lblTitle = [titleSec3Array objectAtIndex:indexPath.row];
        controller.txtProject = [descSec3Array objectAtIndex:indexPath.row];
    }

    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:controller animated:YES];

}


- (IBAction)postToTwitter:(id)sender {
    
    [self urlMkr:@"http://www.google.com"];
    
    NSInteger tid = ((UIControl *) sender).tag;
    
    SLComposeViewController *tweetSheet = [SLComposeViewController
                                           composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    [tweetSheet setInitialText:[titleArray objectAtIndex:tid]];
    [self presentViewController:tweetSheet animated:YES completion:nil];
    
}

- (IBAction)postToFacebook:(id)sender {
    
    [self urlMkr:@"http://www.google.com"];
    
    NSInteger tid = ((UIControl *) sender).tag;
    
    
    SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    [controller setInitialText:[descArray objectAtIndex:tid]];
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end

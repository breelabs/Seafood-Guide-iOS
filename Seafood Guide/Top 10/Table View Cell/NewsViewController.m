//
//  NewsViewController.m
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import "NewsViewController.h"
#import "TableViewCellNews.h"
#import <Social/Social.h>
#import "RXMLElement.h"
#import "DetailNewsViewController.h"
#import "config.h"
#import <QuartzCore/QuartzCore.h>

@interface NewsViewController ()

@end

@implementation NewsViewController
@synthesize NewsTbView,numArray,imageArray,descArray,titleArray,directionsButton;

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

    // Do any additional setup after loading the view from its nib.
    self.numArray = [[NSMutableArray alloc] init];
    self.imageArray = [[NSMutableArray alloc]init];
    self.descArray = [[NSMutableArray alloc]init];
    self.titleArray = [[NSMutableArray alloc]init];
    
    // Add these right after creating the UITableView
    NewsTbView.delegate = self;
    NewsTbView.dataSource = self;
    
   // UIImage * backgroundPattern = [UIImage imageNamed:@"Whitey"];
    
    //[self.view setBackgroundColor:[UIColor colorWithPatternImage:backgroundPattern]];
    
    
    //UIGraphicsBeginImageContext(self.view.frame.size);
   // [[UIImage imageNamed:@"Whitey"] drawInRect:self.view.bounds];
    //UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //UIGraphicsEndImageContext();
    
   // self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    [self refresh];

}

-(void)refresh
{
    // Create the request.
    //NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[config getFeedNEWS]]];
    
    // Create url connection and fire request
    //NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    RXMLElement *rootXML = [RXMLElement elementFromXMLFile:@"ios-news.xml"];
    
    RXMLElement *rxmlNews = [rootXML child:@"news"];
    
    NSArray *rxmlIndividualNew = [rxmlNews children:@"new"];
    
    //NSLog(@"test nsarray : %@",[[rxmlIndividualNew objectAtIndex:0] child:@"imageurl"]);
    
    for (int i=0; i<rxmlIndividualNew.count; i++) {
        //NSLog(@"i = %d",i);
        
        //NSURL *imgUrl = [NSURL URLWithString:[[rxmlIndividualNew objectAtIndex:i] child:@"imageurl"].text];
        NSString *imgUrl = [NSString stringWithFormat:@"%@" , [[rxmlIndividualNew objectAtIndex:i] child:@"imageurl"].text];
        NSString *num = [NSString stringWithFormat:@"%@" , [[rxmlIndividualNew objectAtIndex:i] child:@"linknews"].text];
        //UIImage *img1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:imgUrl]];
        UIImage *img1 = [UIImage imageNamed:imgUrl];
        
        NSString *title = [NSString stringWithString:[[rxmlIndividualNew objectAtIndex:i] child:@"titlenews"].text];
        NSString *desc = [NSString stringWithString:[[rxmlIndividualNew objectAtIndex:i] child:@"descnews"].text];
        
        [numArray addObject:num];
        [imageArray addObject:img1];
        [titleArray addObject:title];
        [descArray addObject:desc];
    }
    
    [NewsTbView reloadData];
    
}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    
    // You can parse the stuff in your instance variable now
    //RXMLElement *rootXML = [RXMLElement elementFromXMLData:_responseData];
    RXMLElement *rootXML = [RXMLElement elementFromXMLFile:@"ios-news.xml"];
    
    RXMLElement *rxmlNews = [rootXML child:@"news"];
    
    NSArray *rxmlIndividualNew = [rxmlNews children:@"new"];
    
    //NSLog(@"test nsarray : %@",[[rxmlIndividualNew objectAtIndex:0] child:@"imageurl"]);
    
    for (int i=0; i<rxmlIndividualNew.count; i++) {
        //NSLog(@"i = %d",i);
        
        //NSURL *imgUrl = [NSURL URLWithString:[[rxmlIndividualNew objectAtIndex:i] child:@"imageurl"].text];
        NSString *imgUrl = [NSString stringWithFormat:@"%@" , [[rxmlIndividualNew objectAtIndex:i] child:@"imageurl"].text];
        
        //UIImage *img1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:imgUrl]];
        UIImage *img1 = [UIImage imageNamed:imgUrl];
        
        NSString *title = [NSString stringWithString:[[rxmlIndividualNew objectAtIndex:i] child:@"titlenews"].text];
        NSString *desc = [NSString stringWithString:[[rxmlIndividualNew objectAtIndex:i] child:@"descnews"].text];
        
        [imageArray addObject:img1];
        [titleArray addObject:title];
        [descArray addObject:desc];
    }
    
    
    
    [NewsTbView reloadData];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return imageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIndent";
    TableViewCellNews *cell = (TableViewCellNews *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSString *CellName;
    
    CellName = @"TableViewCellNews";
    
    if (cell == nil) {
        
        UIViewController *c = [[UIViewController alloc] initWithNibName:CellName bundle:nil];
        
        cell = (TableViewCellNews *)c.view;
    }
    
    cell.textLabel.numberOfLines = 0;
    cell.numb.text = [numArray objectAtIndex:indexPath.row];
    cell.image.image = [imageArray objectAtIndex:indexPath.row];
    cell.image.layer.cornerRadius = 5;
    cell.image.clipsToBounds = YES;
    cell.image.layer.borderColor=[[UIColor grayColor] CGColor];
    cell.image.layer.borderWidth=1.2;
    
    cell.circle.layer.cornerRadius=15;
    cell.circle.clipsToBounds=YES;
    cell.circle.layer.borderColor=[[UIColor grayColor] CGColor];
    cell.circle.layer.borderWidth=2.0;
    
    cell.text.text = [titleArray objectAtIndex:indexPath.row];
    cell.image.contentMode = UIViewContentModeScaleToFill;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.image setAlpha:0];
    [cell.imagetitle setAlpha:0];
    [cell.text setAlpha:0];
    [cell.facebookButton setAlpha:0];
    [cell.twitterButton setAlpha:0];
    [UIView beginAnimations:@"ResizeAnimation" context:NULL];
    [UIView setAnimationDuration:0.5f];
    [cell.image setAlpha:1];
    [cell.text setAlpha:1];
    [cell.imagetitle setAlpha:1];
    [cell.facebookButton setAlpha:1];
    [cell.twitterButton setAlpha:1];
    [UIView commitAnimations];
    
   // [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
    
    [cell.twitterButton    addTarget:self
                              action:@selector(postToTwitter:)
                    forControlEvents:UIControlEventTouchUpInside];
    cell.twitterButton.tag = indexPath.row;
    
    [cell.facebookButton    addTarget:self
                               action:@selector(postToFacebook:)
                     forControlEvents:UIControlEventTouchUpInside];
    cell.facebookButton.tag = indexPath.row;

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
DetailNewsViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"detailview"];
    
    if (_detailNewsViewController == nil) {
        
        NSString * storyboardName = @"Main_iPhone";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        self.detailNewsViewController = [storyboard instantiateViewControllerWithIdentifier:@"detailview"];

    }

    
    controller.image = [imageArray objectAtIndex:indexPath.row];
    controller.lblTitle = [titleArray objectAtIndex:indexPath.row];
    controller.txtProject = [descArray objectAtIndex:indexPath.row];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:controller animated:YES];
    

}


- (IBAction)postToTwitter:(id)sender {
    
    
    
    NSInteger tid = ((UIControl *) sender).tag;
    
    SLComposeViewController *tweetSheet = [SLComposeViewController
                                           composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    [tweetSheet setInitialText:[titleArray objectAtIndex:tid]];
    //[tweetSheet addURL:object.link];
    [tweetSheet addImage:[imageArray objectAtIndex:tid]];
    [self presentViewController:tweetSheet animated:YES completion:nil];
    
}

- (IBAction)postToFacebook:(id)sender {
    
   
    
    NSInteger tid = ((UIControl *) sender).tag;
   
    
    SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
      [controller setInitialText:[descArray objectAtIndex:tid]];
  //  [controller addURL:object.link];
    [controller addImage:[imageArray objectAtIndex:tid]];
    [self presentViewController:controller animated:YES completion:Nil];
    
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

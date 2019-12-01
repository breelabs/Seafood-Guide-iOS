//
//  NewsViewController.m
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import "NewsViewController.h"
#import "TableViewCellNews.h"
#import "RXMLElement.h"
#import "DetailNewsViewController.h"
#import "config.h"
#import <QuartzCore/QuartzCore.h>

@interface NewsViewController ()

@end

@implementation NewsViewController
@synthesize NewsTbView,numArray,imageArray,descArray,titleArray;

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

    self.numArray = [[NSMutableArray alloc] init];
    self.imageArray = [[NSMutableArray alloc]init];
    self.descArray = [[NSMutableArray alloc]init];
    self.titleArray = [[NSMutableArray alloc]init];
    
    NewsTbView.delegate = self;
    NewsTbView.dataSource = self;
    
    [self refresh];

}

-(void)refresh
{
    
    RXMLElement *rootXML = [RXMLElement elementFromXMLFile:@"ios-news.xml"];
    
    RXMLElement *rxmlNews = [rootXML child:@"news"];
    
    NSArray *rxmlIndividualNew = [rxmlNews children:@"new"];
        
    for (int i=0; i<rxmlIndividualNew.count; i++) {
        NSString *imgUrl = [NSString stringWithFormat:@"%@" , [[rxmlIndividualNew objectAtIndex:i] child:@"imageurl"].text];
        NSString *num = [NSString stringWithFormat:@"%@" , [[rxmlIndividualNew objectAtIndex:i] child:@"linknews"].text];
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

    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {

    RXMLElement *rootXML = [RXMLElement elementFromXMLFile:@"ios-news.xml"];
    
    RXMLElement *rxmlNews = [rootXML child:@"news"];
    
    NSArray *rxmlIndividualNew = [rxmlNews children:@"new"];
    
    
    for (int i=0; i<rxmlIndividualNew.count; i++) {
        
        NSString *imgUrl = [NSString stringWithFormat:@"%@" , [[rxmlIndividualNew objectAtIndex:i] child:@"imageurl"].text];
        
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

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    [UIView beginAnimations:@"ResizeAnimation" context:NULL];
    [UIView setAnimationDuration:0.5f];
    [cell.image setAlpha:1];
    [cell.text setAlpha:1];
    [cell.imagetitle setAlpha:1];
    [UIView commitAnimations];
    
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
    [[button layer] setCornerRadius:4.0]; 
    [[button layer] setBorderWidth:1.0];
    
    return button;
}


@end

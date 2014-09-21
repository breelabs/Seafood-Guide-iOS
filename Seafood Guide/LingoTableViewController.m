//
//  LingoTableViewController.m
//  Seafood Guide
//
//  Created by Jon Brown on 9/1/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import "LingoTableViewController.h"
#import "RXMLElement.h"
#import <Social/Social.h>
#import "DetailLingoViewController.h"

@interface LingoTableViewController ()

@end

@implementation LingoTableViewController


@synthesize tableView = _tableView, LingoTbView,imageArray,descArray,titleArray,directionsButton;


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
    self.imageArray = [[NSMutableArray alloc]init];
    self.descArray = [[NSMutableArray alloc]init];
    self.titleArray = [[NSMutableArray alloc]init];
   
    
    // Add these right after creating the UITableView
    LingoTbView.delegate = self;
    LingoTbView.dataSource = self;
    
    [self refresh];

}


-(void)refresh
{
    // Create the request.
    //NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[config getFeedNEWS]]];
    
    // Create url connection and fire request
    //NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    RXMLElement *rootXML = [RXMLElement elementFromXMLFile:@"ios-lingo.xml"];
    
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


    
    animals = [[NSMutableDictionary alloc] init];
   
    
    // initialize places with an array for each letter
    NSString *alphabet = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    for (int x = 0; x < 26; x++) {
        NSString *letter = [alphabet substringWithRange:NSMakeRange(x, 1)];
        [animals setObject:[NSMutableArray array] forKey:letter];
    }
    
    // then put each place in the array corresponding to its first letter
    for (NSString *place in titleArray) {
        NSString *first = [[place substringWithRange:NSMakeRange(0, 1)] uppercaseString];
        NSMutableArray *letterArray = [animals objectForKey:first];
        [letterArray addObject:place];
    }
    
    animalSectionTitles = [[animals allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    [LingoTbView reloadData];
    
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
    

    return [animalSectionTitles count];
    
    
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{

    if ([tableView.dataSource tableView:tableView numberOfRowsInSection:section] == 0) {
        return 0;
    } else {
        // whatever height you'd want for a real section header
        return [animalSectionTitles objectAtIndex:section];
    }

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
   
  
        //Return the number of rows in the section.
        NSString *sectionTitle = [animalSectionTitles objectAtIndex:section];
        NSArray *sectionAnimals = [animals objectForKey:sectionTitle];
        return [sectionAnimals count];
        

    
       
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{

        return animalSectionTitles;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //lingocells *cell = [tableView dequeueReusableCellWithIdentifier:@"lingocells"];
    
    static NSString *cellID = @"lingocells";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }

    // Configure the cell...
    NSString *sectionTitle = [animalSectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionAnimals = [animals objectForKey:sectionTitle];
    NSString *animal = [sectionAnimals objectAtIndex:indexPath.row];
    

    cell.textLabel.text = animal;
    cell.textLabel.numberOfLines = 0;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [UIView beginAnimations:@"ResizeAnimation" context:NULL];
    [UIView setAnimationDuration:0.5f];
    [UIView commitAnimations];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
 
    DetailLingoViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"detaillingoview"];

    
    if (_detailLingoViewController == nil) {
        
        NSString * storyboardName = @"Main_iPhone";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        self.detailLingoViewController = [storyboard instantiateViewControllerWithIdentifier:@"detaillingoview"];

    }
    
    NSString *sectionTitle = [animalSectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionAnimals = [animals objectForKey:sectionTitle];
    NSString *animal = [sectionAnimals objectAtIndex:indexPath.row];
    
    controller.image = [imageArray objectAtIndex:indexPath.row];
    controller.lblTitle = animal;
    controller.txtProject = [descArray objectAtIndex:indexPath.row];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:controller animated:YES];
    

}


- (IBAction)postToTwitter:(id)sender {
    
    [self urlMkr:@"http://www.google.com"];
    
    NSInteger tid = ((UIControl *) sender).tag;
    
    SLComposeViewController *tweetSheet = [SLComposeViewController
                                           composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    [tweetSheet setInitialText:[titleArray objectAtIndex:tid]];
    [tweetSheet addImage:[imageArray objectAtIndex:tid]];
    [self presentViewController:tweetSheet animated:YES completion:nil];
    
}

- (IBAction)postToFacebook:(id)sender {
    
    [self urlMkr:@"http://www.google.com"];
    
    NSInteger tid = ((UIControl *) sender).tag;
    
    
    SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    [controller setInitialText:[descArray objectAtIndex:tid]];
    [controller addImage:[imageArray objectAtIndex:tid]];
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

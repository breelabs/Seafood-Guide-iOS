//
//  TVCDetailViewController.m
//  Seafood Guide
//
//  Created by Remote Admin on 7/18/12.
//
//

#import "TVCDetailViewController.h"
#import "FishTVC.h"
#import <Social/Social.h>
#import "WebViewController.h"
#import "config.h"

@interface TVCDetailViewController ()

@end

@implementation TVCDetailViewController

@synthesize item, directionsButton;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    self.title = [item name];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // #warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // #warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {

    if([indexPath row] == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"CellType1"];
        if(!cell)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellType1"];
        [[cell textLabel] setText:[item name]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else if([indexPath row] == 1)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"CellType2"];
        if(!cell)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellType2"];
        [[cell textLabel] setText:[item region]];
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else if([indexPath row] == 2)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"CellType3"];
        if(!cell)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellType3"];
        [[cell textLabel] setText:[item desc]];
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    else if([indexPath row] == 3)
    {        
        cell = [tableView dequeueReusableCellWithIdentifier:@"CellType4"];
        if(!cell)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellType4"];
        [[cell textLabel] setText:[item good]];
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
        
        
    } else if (indexPath.section == 1) {
        
        if([indexPath row] == 0)
        {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"CellType6"];
        if(!cell)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellType6"];
        [[cell textLabel] setText:@"Share On Twitter"];
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        } else if ([indexPath row] == 1) {
            
            cell = [tableView dequeueReusableCellWithIdentifier:@"CellType7"];
            if(!cell)
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellType7"];
            [[cell textLabel] setText:@"Share On Facebook"];
            
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        } else if ([indexPath row] == 2) {
            
            cell = [tableView dequeueReusableCellWithIdentifier:@"CellType8"];
            if(!cell)
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellType8"];
            [[cell textLabel] setText:@"View Online Guide"];
           // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        } else if ([indexPath row] == 3) {
            
            cell = [tableView dequeueReusableCellWithIdentifier:@"CellType9"];
            if(!cell)
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellType9"];
            [[cell textLabel] setText:@"Email to a friend"];
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        } else if ([indexPath row] == 4) {
            
            cell = [tableView dequeueReusableCellWithIdentifier:@"CellType10"];
            if(!cell)
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellType10"];
            [[cell textLabel] setText:@"Like this item"];
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }

    } 
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //NSString *text = @"25345234 582345 928345 923485yp2349857y32terughewrkgjherlkjgehrg"
    
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    if ([indexPath row] == 0) {
        
        [self postToTwitter:self];
    
    } else if ([indexPath row] == 1) {
        
        [self postToFacebook:self];
        
    } else if ([indexPath row] == 2) {
        
        [self goWebsite];
    } else if ([indexPath row] == 3) {
        
        [self sendEmail];
        
    }
    
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 && indexPath.row == 2) {
        
     
//        NSStringDrawingContext *ctx = [NSStringDrawingContext new];
//        NSAttributedString *aString = [[NSAttributedString alloc] initWithString:[item desc]];
//        UITextView *calculationView = [[UITextView alloc] init];
//        [calculationView setAttributedText:aString];
//        
//        CGRect textRect = [calculationView.text boundingRectWithSize:CGSizeMake(270 - (10 * 2), 200000.0f)
//                                                             options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:calculationView.font} context:ctx];
        
//        CGRect textRect = [calculationView.text boundingRectWithSize:self.view.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:calculationView.font} context:ctx];
        
//        CGFloat height = MAX(textRect.size.height, 44.0f);
//        return height + (2 * 2);
        
        CGSize size = [[item desc] sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(290 - (10 * 2), 200000.0f)];
    
        CGFloat height = MAX(size.height, 44.0f);
        
        return height + (2 * 2);
        
    }
    return 44;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Fish Information";
    } else if (section == 1) {
        return @"Share";
    }
    
    return nil;
}
-(void)viewDidAppear:(BOOL)animated
{
    //[super viewDidAppear:YES];
    [self.navigationItem setHidesBackButton:NO];
}

- (IBAction)postToTwitter:(id)sender {
    
    [self urlMkr:@"http://www.google.com"];
    SLComposeViewController *tweetSheet = [SLComposeViewController
                                           composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    str = [item desc];
    str = [str substringToIndex: MIN(65, [str length])];
    
    NSString *one = [item name];
    NSString *two = [item region];
    NSString *three = [item good];
    
    NSString* All = [NSString stringWithFormat:@"Fish Name: %@\r%@\r%@\rDescription:%@", one, two, three, str];
    
    [tweetSheet setInitialText:All];
    [self presentViewController:tweetSheet animated:YES completion:nil];
    
}

-(void)goWebsite {
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.imamac.guru/"]];
    
    
    [self urlMkr:@"http://www.google.com"];
    
    NSURL *url = [NSURL URLWithString:@"http://www.foodandwaterwatch.org/common-resources/fish/seafood/seafood-guide-data/"];
    WebViewController *webViewController = [[WebViewController alloc] initWithURL:url andTitle:@"Online Guide"];
    [self presentViewController:webViewController animated:YES completion:nil];
}

- (IBAction)postToFacebook:(id)sender {
    
    [self urlMkr:@"http://www.google.com"];
    SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    str = [item desc];
    str = [str substringToIndex: MIN(100, [str length])];
    
    NSString *one = [item name];
    NSString *two = [item region];
    NSString *three = [item good];
    
    NSString* All = [NSString stringWithFormat:@"Fish Name: %@\r%@\r%@\rDescription:\r%@\r-- Seafood App", one, two, three, str];
    
    [controller setInitialText:All];
    [self presentViewController:controller animated:YES completion:Nil];
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            //NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            [ProgressHUD showError:@"Email Not Sent"];
            break;
        case MFMailComposeResultSaved:
            //NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            [ProgressHUD showSuccess:@"Email Saved!"];
            break;
        case MFMailComposeResultSent:
            // NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            [ProgressHUD showSuccess:@"Email Sent!"];
            break;
        case MFMailComposeResultFailed:
            //NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            [ProgressHUD showError:@"Email Not Sent"];
            break;
        default:
            //NSLog(@"Mail not sent.");
            [ProgressHUD showError:@"Email Not Sent"];
            break;
    }
    // Remove the mail view
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)sendEmail {
    
    str = [item desc];
    str = [str substringToIndex: MIN(1165, [str length])];
    
    NSString *one = [item name];
    NSString *two = [item region];
    NSString *three = [item good];
    
    NSString* All = [NSString stringWithFormat:@"Fish Name: %@\n\nType: %@\n\n%@\n\nDescription:\n%@", one, two, three, str];
    
    
    [self urlMkr:@"http://www.google.com"];
    
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setSubject:[NSString stringWithFormat:@"Food & Water Watch - Check This Out: %@", one]];
        NSArray *toRecipients = [NSArray arrayWithObjects:[config getMail], nil];
        [mailer setToRecipients:toRecipients];
        NSString *emailBody = All;
        [mailer setMessageBody:emailBody isHTML:NO];
        [self presentViewController:mailer animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
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

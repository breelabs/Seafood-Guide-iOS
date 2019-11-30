//
//  TVCDetailViewController.m
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import "TVCDetailViewController.h"
#import "FishTVC.h"
#import <Social/Social.h>
#import "config.h"

@interface TVCDetailViewController ()

@end

@implementation TVCDetailViewController

@synthesize item;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    self.title = [item name];
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // #warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0) {
        return 3;
    } else {
        return 1;
    }
    
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
        [[cell textLabel] setText:@"Email to a friend"];
        
        }

    } 
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section == 1) {
    
    if ([indexPath row] == 0) {
        
        [self sendEmail];
        
    }
    
    }
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 && indexPath.row == 2) {
 
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        
        NSDictionary *attributes = @{
                                     NSFontAttributeName:[UIFont systemFontOfSize:17],
                                     NSParagraphStyleAttributeName:paragraphStyle
                                     };
        
        CGRect textRect = [[item desc] boundingRectWithSize:CGSizeMake(290 - (10 * 2), 200000.0f)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:attributes
                                               context:nil];
        
        float height = textRect.size.height;
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

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            [ProgressHUD showError:@"Email Not Sent"];
            break;
        case MFMailComposeResultSaved:
            [ProgressHUD showSuccess:@"Email Saved!"];
            break;
        case MFMailComposeResultSent:
            [ProgressHUD showSuccess:@"Email Sent!"];
            break;
        case MFMailComposeResultFailed:
            [ProgressHUD showError:@"Email Not Sent"];
            break;
        default:
            [ProgressHUD showError:@"Email Not Sent"];
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)sendEmail {
    
    str = [item desc];
    str = [str substringToIndex: MIN(1165, [str length])];
    
    NSString *one = [item name];
    NSString *two = [item region];
    NSString *three = [item good];
    
    NSString* All = [NSString stringWithFormat:@"Fish Name: %@\n\nType: %@\n\n%@\n\nDescription:\n%@", one, two, three, str];
    
    
    
    
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
        
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"Failure"
                                    message:@"Your device doesn't support the composer sheet"
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *noButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       //Handle no, thanks button
                                       [self.presentedViewController dismissViewControllerAnimated:NO completion:nil];
                                   }];
        
        [alert addAction:noButton];
        
        [self presentViewController:alert animated:YES completion:nil];
        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
//                                                        message:@"Your device doesn't support the composer sheet"
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//        [alert show];
        
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

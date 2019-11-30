//
//  AboutTableViewController.m
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import "AboutTableViewController.h"
#import "CoreDataTableViewController.h"
#import "About.h"
#import "AppDelegate.h"
#import "DetailAboutViewController.h"

@implementation AboutTableViewController
@synthesize window = _window;
@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize fetchedResultsController1 = __fetchedResultsController1;
@synthesize fetchedResultsController2 = __fetchedResultsController2;
@synthesize managedObjectContext = __managedObjectContext;


- (NSManagedObjectContext *)managedObjectContext
{
    if (!__managedObjectContext)
    {
        __managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    }
    return __managedObjectContext;
    
}


- (void)setupFetchedResultsController

{
    NSString *entityName = @"About"; // Put your entity name here
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"linknews = '3'"];
    [request setPredicate:predicate];
    
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"linknews"
                                                                                     ascending:YES
                                                                                      selector:@selector(localizedCaseInsensitiveCompare:)]];

    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    
    
    [self.fetchedResultsController performFetch:nil];
    
    
    
    
}

- (void)setupFetchedResultsController1

{
    NSString *entityName1 = @"About"; // Put your entity name here
    
    NSFetchRequest *request1 = [NSFetchRequest fetchRequestWithEntityName:entityName1];
    
    NSPredicate * predicate1 = [NSPredicate predicateWithFormat:@"linknews = '1'"];
    [request1 setPredicate:predicate1];
    
    request1.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"linknews"
                                                                                     ascending:YES
                                                                                      selector:@selector(localizedCaseInsensitiveCompare:)]];
    
    self.fetchedResultsController1 = [[NSFetchedResultsController alloc] initWithFetchRequest:request1
                                                                        managedObjectContext:self.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    
    
    [self.fetchedResultsController1 performFetch:nil];
    
    
    
    
}

- (void)setupFetchedResultsController2

{
    NSString *entityName2 = @"About"; // Put your entity name here
    
    NSFetchRequest *request2 = [NSFetchRequest fetchRequestWithEntityName:entityName2];
    
    NSPredicate * predicate2 = [NSPredicate predicateWithFormat:@"linknews = '2'"];
    [request2 setPredicate:predicate2];
    
    request2.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"linknews"
                                                                                      ascending:YES
                                                                                       selector:@selector(localizedCaseInsensitiveCompare:)]];
    
    self.fetchedResultsController2 = [[NSFetchedResultsController alloc] initWithFetchRequest:request2
                                                                         managedObjectContext:self.managedObjectContext
                                                                           sectionNameKeyPath:nil
                                                                                    cacheName:nil];
    
    
    [self.fetchedResultsController2 performFetch:nil];
    
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSArray *sectionTitleInfo = @[@"About the Seafood Guide", @"What You Can Do" , @"Labeling"];
    return [sectionTitleInfo objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 6;
    } else if (section == 1) {
        return 1;
    } else if (section == 2) {
        return 4;
    }
    NSArray *fetchedObjects = [__fetchedResultsController fetchedObjects];
    return [fetchedObjects count];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupFetchedResultsController];
    [self setupFetchedResultsController1];
    [self setupFetchedResultsController2];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"aboutcell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSArray *fetchedObjects = [__fetchedResultsController fetchedObjects];
    NSArray *fetchedObjects1 = [__fetchedResultsController1 fetchedObjects];
    NSArray *fetchedObjects2 = [__fetchedResultsController2 fetchedObjects];
    
    NSArray *title4 = [fetchedObjects valueForKeyPath:@"titlenews"];
    NSArray *title6 = [fetchedObjects1 valueForKeyPath:@"titlenews"];
    NSArray *title1 = [fetchedObjects2 valueForKeyPath:@"titlenews"];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = [title6 objectAtIndex:indexPath.row];
        
    } else if (indexPath.section == 1) {
        cell.textLabel.text = [title1 objectAtIndex:indexPath.row];
    } else if (indexPath.section == 2) {
        cell.textLabel.text = [title4 objectAtIndex:indexPath.row];
    }
    
    return cell;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem.title = @"Back";
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Table view sends data to detail view

-(void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailAboutViewController *detailViewController = [[DetailAboutViewController alloc]init];
    
    if (indexPath.section == 0) {
        About *allAbout = [[__fetchedResultsController1 fetchedObjects] objectAtIndex:indexPath.row];
        [detailViewController setItem:allAbout];
    } else if (indexPath.section == 1) {
        About *allAbout1 = [[__fetchedResultsController2 fetchedObjects] objectAtIndex:indexPath.row];
        [detailViewController setItem:allAbout1];
    } else if (indexPath.section == 2) {
        About *allAbout2 = [[__fetchedResultsController fetchedObjects] objectAtIndex:indexPath.row];
        [detailViewController setItem:allAbout2];
    }
    
   
    [self.navigationController pushViewController:detailViewController
                                         animated:YES];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
}
-(void)viewDidAppear:(BOOL)animated
{
    [self.navigationItem setHidesBackButton:NO];
}

@end

//
//  LingoTableViewController.m
//  Seafood Guide
//
//  Created by Jon Brown on 9/1/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import "LingoTableViewController.h"
#import "CoreDataTableViewController.h"
#import "Lingo.h"
#import "AppDelegate.h"
#import "DetailLingoViewController.h"

@implementation LingoTableViewController
@synthesize window = _window;
@synthesize fetchedResultsController = __fetchedResultsController;
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
    
    // 1 - Decide what Entity you want
    NSString *entityName = @"Lingo"; // Put your entity name here
    NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", entityName);
    
    // 2 - Request that Entity
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    
    //    NSString *theFrameThatWasTouchedwithTheUsersFinger = [[NSString alloc]init];
    //    theFrameThatWasTouchedwithTheUsersFinger = note;
    
    
    // 3 - Filter it if you want
    
    //predicateKey = @"";
    
    // 4 - Sort it if you want
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"titlenews"
                                                                                     ascending:YES
                                                                                      selector:@selector(localizedCaseInsensitiveCompare:)]];
    
    // 5 - Fetch it
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.managedObjectContext
                                                                          sectionNameKeyPath:@"uppercaseFirstLetterOfName"
                                                                                   cacheName:nil];
    
    
    //[request setPropertiesToGroupBy:[NSArray arrayWithObject:statusDesc]];
    //    for (NSObject* o in fishnames)
    //    {
    //        NSLog(@"%@",o);
    //    }
    
    
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
    if (error) {
        NSLog(@"Unable to perform fetch.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    } else {
        NSLog(@"Performed Fetch fine.");
    }
}



//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    // Return the number of sections.
//    return [animalSectionTitles count];
//}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo name];
    
    //    if ([self.tableView.dataSource tableView:tableView numberOfRowsInSection:section] == 0) {
    //        return nil;
    //    }
    //    return [animalSectionTitles objectAtIndex:section];
    
}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    // Return the number of rows in the section.
//    NSString *sectionTitle = [animalSectionTitles objectAtIndex:section];
//    NSArray *sectionAnimals = [animals objectForKey:sectionTitle];
//    return [sectionAnimals count];
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id  sectionInfo = [[__fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupFetchedResultsController];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"lingocells";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    // Configure the cell...
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    Lingo *lingo = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = lingo.titlenews;
    
    NSLog(@"%@", lingo.titlenews);
    
    return cell;
    
}



- (id)initWithLingoSize:(NSString *)size
{
    self = [super initWithStyle:UITableViewStylePlain];
    
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self initWithLingoSize:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // BUG
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    self.navigationItem.backBarButtonItem.title = @"Back";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view sends data to detail view
// Core data to detail view

-(void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DetailLingoViewController *detailViewController = [[DetailLingoViewController alloc]init];
    
    NSInteger sumSections = 0;
    for (int i = 0; i < indexPath.section; i++) {
        long rowsInSection = [self.tableView numberOfRowsInSection:i];
        sumSections += rowsInSection;
    }
    // NSInteger currentRow = sumSections + indexPath.row;
    
    //NSInteger currentRow = indexPath.row;
    
    //NSLog(@"hey %ld", (long)currentRow);
    
    // Lingo *allLingo = [[self.fetchedResultsController fetchedObjects] objectAtIndex:currentRow];
    //[DetailLingoViewController setItem:allLingo];
    
    [self.navigationController pushViewController:detailViewController
                                         animated:YES];
    
    self.navigationItem.backBarButtonItem.title = @"";
}
-(void)viewDidAppear:(BOOL)animated
{
    //[super viewDidAppear:YES];
    [self.navigationItem setHidesBackButton:NO];
}

@end

//
//  FishTVC.m
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import "FishTVC.h"
#import "CoreDataTableViewController.h"
#import "Seafood.h"
#import "AppDelegate.h"
#import "TVCDetailViewController.h"

@implementation FishTVC

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
    NSString *entityName = @"Seafood"; // Put your entity name here
    //NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", entityName);
    
    // 2 - Request that Entity
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    
//    NSString *theFrameThatWasTouchedwithTheUsersFinger = [[NSString alloc]init];
//    theFrameThatWasTouchedwithTheUsersFinger = note;

    
    // 3 - Filter it if you want

    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSUInteger integerFromPrefs = [defaults integerForKey:@"justclicked"];
    predicateKey = [NSString stringWithFormat:@"%li",  (unsigned long)integerFromPrefs];
    
    if (integerFromPrefs == 0) {
        self.title = @"Mild Fish";
    } else if (integerFromPrefs == 1) {
        self.title = @"Thicker & Flavorful";
    } else if (integerFromPrefs == 2) {
        self.title = @"Steak Like";
    } else if (integerFromPrefs == 3) {
        self.title = @"Small Fish";
    } else if (integerFromPrefs == 4) {
        self.title = @"Shellfish";
    } else if (integerFromPrefs == 5) {
        self.title = @"Other";
    } else if (integerFromPrefs == 6) {
        self.title = @"All Fish";
    } else if (integerFromPrefs == 7) {
        self.title = @"Dirty Dozen";
    }
    
    //NSLog(@"Setting up predicate value %lu", (unsigned long)integerFromPrefs);
    
    if(predicateKey)
    {
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"fishtype like[c] %@",predicateKey];
        [request setPredicate:pred];
        //NSLog(@"Setting up predicate value %@", predicateKey);
    }
    
    
    // 4 - Sort it if you want
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name"
                                                                                     ascending:YES
                                                                                      selector:@selector(localizedCaseInsensitiveCompare:)]];
    
    // 5 - Fetch it
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.managedObjectContext
                                                                          sectionNameKeyPath:@"uppercaseFirstLetterOfName"
                                                                                   cacheName:nil];
       
    
    
    [self.fetchedResultsController performFetch:nil];
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo name];
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupFetchedResultsController];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"FishCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    
    // Configure the cell...

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    Seafood *seafood = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = seafood.name;

    
    return cell;
    
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}

- (id)initWithFishSize:(NSString *)size
{
    self = [super initWithStyle:UITableViewStylePlain];
    
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self initWithFishSize:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    
    TVCDetailViewController *detailViewController = [[TVCDetailViewController alloc]init];

    NSInteger sumSections = 0;
    for (int i = 0; i < indexPath.section; i++) {
        long rowsInSection = [self.tableView numberOfRowsInSection:i];
        sumSections += rowsInSection;
    }
    NSInteger currentRow = sumSections + indexPath.row;
    
    Seafood *allSeafood = [[self.fetchedResultsController fetchedObjects] objectAtIndex:currentRow];
    [detailViewController setItem:allSeafood];
    
    [self.navigationController pushViewController:detailViewController
                                         animated:YES];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
}
-(void)viewDidAppear:(BOOL)animated
{
    [self.navigationItem setHidesBackButton:NO];
}

@end

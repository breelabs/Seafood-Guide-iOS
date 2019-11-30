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

    NSString *entityName = @"Lingo"; // Put your entity name here

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];

    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"titlenews"
                                                                                     ascending:YES
                                                                                      selector:@selector(localizedCaseInsensitiveCompare:)]];
    
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
    
    static NSString *CellIdentifier = @"lingocells";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    Lingo *lingo = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = lingo.titlenews;
        
    return cell;
    
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
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
    self.navigationItem.backBarButtonItem.title = @"Back";
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Table view sends data to detail view

-(void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DetailLingoViewController *detailViewController = [[DetailLingoViewController alloc]init];
    
    NSInteger sumSections = 0;
    for (int i = 0; i < indexPath.section; i++) {
        long rowsInSection = [self.tableView numberOfRowsInSection:i];
        sumSections += rowsInSection;
    }
    NSInteger currentRow = sumSections + indexPath.row;
    
   
    Lingo *allLingo = [[self.fetchedResultsController fetchedObjects] objectAtIndex:currentRow];
    [detailViewController setItem:allLingo];

    [self.navigationController pushViewController:detailViewController
                                         animated:YES];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
}
-(void)viewDidAppear:(BOOL)animated
{
    [self.navigationItem setHidesBackButton:NO];
}

@end

//
//  GridViewController.m
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import "GridViewController.h"
#import "FishCat.h"
#import <QuartzCore/QuartzCore.h>

#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)480) < DBL_EPSILON)
#define IS_IPHONE_5 (([UIScreen mainScreen].scale == 2.f && [UIScreen mainScreen].bounds.size.height == 568)?YES:NO)
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)667) < DBL_EPSILON)
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)736) < DBL_EPSILON)
#define IS_IPAD (( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) ? YES : NO)
#define IS_RETINA_DISPLAY_DEVICE (([UIScreen mainScreen].scale == 2.f)?YES:NO)

@implementation GridViewController
{
    NSArray *recipePhotos;
    NSArray *labelTitles;
}
@synthesize window = _window;
@synthesize services, myCollectionView, recipeImages;
@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize managedObjectContext = __managedObjectContext;

static NSString * const reuseIdentifier = @"Cell";



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void) viewDidLoad
{
    [super viewDidLoad];
    
    myCollectionView.delegate = self;
    myCollectionView.dataSource = self;
    
    self.services = [FishCat getSampleData];
    // Initialize recipe image array
    
    recipePhotos = [NSArray arrayWithObjects:@"fish1.png", @"fish2.png", @"fish3.png", @"fish4.png", @"fish5.png", @"fish6.png", @"allfish.png", @"donteat.png", nil];
    
    labelTitles = [NSArray arrayWithObjects:@"Mild Fish", @"Flavorful Fish", @"Steak Like Fish", @"Small Fish", @"Shell Fish", @"Other", @"All Fish", @"Dirty Dozen", nil];
    
    UIImage * backgroundPattern = [UIImage imageNamed:@"FabricPlaid"];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:backgroundPattern]];
    [myCollectionView setBackgroundColor:[UIColor colorWithPatternImage:backgroundPattern]];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}



-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(IS_IPHONE_6)
    {
        return CGSizeMake(137, 100);
    } else if(IS_IPHONE_4) {
        return CGSizeMake(137, 77);
    } else if(IS_IPHONE_6_PLUS) {
        return CGSizeMake(137, 100);
    } else {
        return CGSizeMake(137, 100);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self performSegueWithIdentifier:@"detail" sender:self];
    
    NSString *selectedItem = [NSString stringWithFormat:@"%@",[recipePhotos objectAtIndex:indexPath.item]];
    
    if([selectedItem  isEqual: @"fish1.png"]) {
        NSString *myValue = @"0";
        
        NSString *defaultPrefsFile = [[NSBundle mainBundle] pathForResource:@"defaultPrefs" ofType:@"plist"];
        NSDictionary *defaultPreferences = [NSDictionary dictionaryWithContentsOfFile:defaultPrefsFile];
        [[NSUserDefaults standardUserDefaults] registerDefaults:defaultPreferences];
        
        [[NSUserDefaults standardUserDefaults] setValue:myValue forKey:@"justclicked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    } else if ([selectedItem  isEqual: @"fish2.png"]) {
        NSString *myValue = @"1";
                
        NSString *defaultPrefsFile = [[NSBundle mainBundle] pathForResource:@"defaultPrefs" ofType:@"plist"];
        NSDictionary *defaultPreferences = [NSDictionary dictionaryWithContentsOfFile:defaultPrefsFile];
        [[NSUserDefaults standardUserDefaults] registerDefaults:defaultPreferences];
        
        [[NSUserDefaults standardUserDefaults] setValue:myValue forKey:@"justclicked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    } else if ([selectedItem  isEqual: @"fish3.png"]) {
        NSString *myValue = @"2";
        
        NSString *defaultPrefsFile = [[NSBundle mainBundle] pathForResource:@"defaultPrefs" ofType:@"plist"];
        NSDictionary *defaultPreferences = [NSDictionary dictionaryWithContentsOfFile:defaultPrefsFile];
        [[NSUserDefaults standardUserDefaults] registerDefaults:defaultPreferences];
        
        [[NSUserDefaults standardUserDefaults] setValue:myValue forKey:@"justclicked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    } else if ([selectedItem  isEqual: @"fish4.png"]) {
        NSString *myValue = @"3";
        
        NSString *defaultPrefsFile = [[NSBundle mainBundle] pathForResource:@"defaultPrefs" ofType:@"plist"];
        NSDictionary *defaultPreferences = [NSDictionary dictionaryWithContentsOfFile:defaultPrefsFile];
        [[NSUserDefaults standardUserDefaults] registerDefaults:defaultPreferences];
        
        [[NSUserDefaults standardUserDefaults] setValue:myValue forKey:@"justclicked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    } else if ([selectedItem  isEqual: @"fish5.png"]) {
        NSString *myValue = @"4";
        
        NSString *defaultPrefsFile = [[NSBundle mainBundle] pathForResource:@"defaultPrefs" ofType:@"plist"];
        NSDictionary *defaultPreferences = [NSDictionary dictionaryWithContentsOfFile:defaultPrefsFile];
        [[NSUserDefaults standardUserDefaults] registerDefaults:defaultPreferences];
        
        [[NSUserDefaults standardUserDefaults] setValue:myValue forKey:@"justclicked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    } else if ([selectedItem  isEqual: @"fish6.png"]) {
        NSString *myValue = @"5";
        
        NSString *defaultPrefsFile = [[NSBundle mainBundle] pathForResource:@"defaultPrefs" ofType:@"plist"];
        NSDictionary *defaultPreferences = [NSDictionary dictionaryWithContentsOfFile:defaultPrefsFile];
        [[NSUserDefaults standardUserDefaults] registerDefaults:defaultPreferences];
        
        [[NSUserDefaults standardUserDefaults] setValue:myValue forKey:@"justclicked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    } else if ([selectedItem  isEqual: @"allfish.png"]) {
        NSString *myValue = @"6";
        
        NSString *defaultPrefsFile = [[NSBundle mainBundle] pathForResource:@"defaultPrefs" ofType:@"plist"];
        NSDictionary *defaultPreferences = [NSDictionary dictionaryWithContentsOfFile:defaultPrefsFile];
        [[NSUserDefaults standardUserDefaults] registerDefaults:defaultPreferences];
        
        [[NSUserDefaults standardUserDefaults] setValue:myValue forKey:@"justclicked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    } else if ([selectedItem  isEqual: @"donteat.png"]) {
        NSString *myValue = @"7";
        
        NSString *defaultPrefsFile = [[NSBundle mainBundle] pathForResource:@"defaultPrefs" ofType:@"plist"];
        NSDictionary *defaultPreferences = [NSDictionary dictionaryWithContentsOfFile:defaultPrefsFile];
        [[NSUserDefaults standardUserDefaults] registerDefaults:defaultPreferences];
        
        [[NSUserDefaults standardUserDefaults] setValue:myValue forKey:@"justclicked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
    
    
    
    
    NSLog(@"Predicate value## %@", selectedItem);
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return recipePhotos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    recipeImageView.image = [UIImage imageNamed:[recipePhotos objectAtIndex:indexPath.row]];
    
    UILabel *labelView = (UILabel *)[cell viewWithTag:50];
    labelView.text = [NSString stringWithFormat:@"%@", [labelTitles objectAtIndex:indexPath.row]];
    
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 4;
    
    return cell;
}


@end

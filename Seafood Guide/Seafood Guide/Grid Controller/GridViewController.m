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

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_X  (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)

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
    
    
    if (@available(iOS 11, *)) {
        UIEdgeInsets insets = [UIApplication sharedApplication].delegate.window.safeAreaInsets;
        if (insets.top > 0) {
            // We're running on an iPhone with a notch.
            
            // move Collection View to propper place
            CGRect mycviewFrame = myCollectionView.frame;
            mycviewFrame.origin.y = 110;
            mycviewFrame.origin.x = 0;
            myCollectionView.frame = mycviewFrame;
            self.myCollectionView.frame = CGRectMake(0,110,375,692);
            
        }
    }
    
    
    
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}



-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    int numberOfCellInRow = 2;
    CGFloat cellWidth =  ([[UIScreen mainScreen] bounds].size.width-45)/numberOfCellInRow;
    
    if(IS_IPHONE_6)
    {
        return CGSizeMake(cellWidth, 120);
    } else if(IS_IPHONE_4_OR_LESS) {
        return CGSizeMake(cellWidth, 56);
    } else if(IS_IPHONE_6P) {
        return CGSizeMake(cellWidth, 140);
    } else if(IS_IPHONE_X) {
        return CGSizeMake(cellWidth, 140);
    } else {
        return CGSizeMake(cellWidth, 86);
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

//
//  GridViewController.m
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import "GridViewController.h"
#import "GridViewCell.h"
#import "FishCat.h"
#import <QuartzCore/QuartzCore.h>

@implementation GridViewController

@synthesize window = _window;
@synthesize gridView, services;
@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize managedObjectContext = __managedObjectContext;

#define IS_IPAD (( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) ? YES : NO)
#define IS_IPHONE_5 (([UIScreen mainScreen].scale == 2.f && [UIScreen mainScreen].bounds.size.height == 568)?YES:NO)
#define IS_RETINA_DISPLAY_DEVICE (([UIScreen mainScreen].scale == 2.f)?YES:NO)

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidAppear:(BOOL)animated {
    [self.gridView deselectItemAtIndex:self.gridView.indexOfSelectedItem
                              animated:YES];
}
- (void) viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_IPHONE_5)
    {
        //do stuff for 4 inch iPhone screen
        self.gridView = [[AQGridView alloc] initWithFrame:CGRectMake(0, 20, 320, 500)];
    }
    else
    {
        //do stuff for 3.5 inch iPhone screen
        self.gridView = [[AQGridView alloc] initWithFrame:CGRectMake(0, 20, 320, 450)];
    }
    
    
    self.gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
	self.gridView.autoresizesSubviews = YES;
	self.gridView.delegate = self;
	self.gridView.dataSource = self;
    
    [self.view addSubview:gridView];
    
    UIImage * backgroundPattern = [UIImage imageNamed:@"FabricPlaid"];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:backgroundPattern]];

    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"FabricPlaid"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    
    self.services = [FishCat getSampleData];
    
    [self.gridView reloadData];
    
    UIView* gradientView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 4)];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = gradientView.bounds;
    
    UIColor* lightColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    UIColor* darkColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    gradient.colors = [NSArray arrayWithObjects:(id)darkColor.CGColor, (id)lightColor.CGColor, nil];
    [gradientView.layer insertSublayer:gradient atIndex:0];
    
    [self.view addSubview:gradientView];
    
}


- (NSUInteger) numberOfItemsInGridView: (AQGridView *) aGridView
{
    return [services count];
}


- (AQGridViewCell *) gridView: (AQGridView *) aGridView cellForItemAtIndex: (NSUInteger) index
{
    static NSString * PlainCellIdentifier = @"PlainCellIdentifier";
    
    
    GridViewCell * cell = (GridViewCell *)[aGridView dequeueReusableCellWithIdentifier:@"PlainCellIdentifier"];
    
    if ( cell == nil )
    {
        cell = [[GridViewCell alloc] initWithFrame: CGRectMake(0.0, 0.0, 160, 123)
                                   reuseIdentifier: PlainCellIdentifier];
        
    }
    
    FishCat* service = [services objectAtIndex:index];
    
    [cell.imageView setImage:service.image];
    [cell.captionLabel setText:service.caption];
    
    return cell;
    
}


- (CGSize) portraitGridCellSizeForGridView: (AQGridView *) aGridView
{
    return ( CGSizeMake(160.0, 123) );
}

NSString *localStringValue;

-(void)gridView:(AQGridView *)gridView didSelectItemAtIndex:(NSUInteger)index
{
    [self performSegueWithIdentifier:@"detail" sender:self];
    NSLog (@"Selected theArgument=%lu\n", (unsigned long)index);

    
//    NSString *str = nil;
//    if(index == 0)
//        str = @"big";
//    else// if(index == 1)
//        str = @"small";
    
    
//    NSString *myValue = [[NSString alloc]initWithFormat:@"%@",];
//    myValue = @"%d", index;
    
      NSString *myValue = [NSString stringWithFormat:@"%lu", (unsigned long)index]; // d = decimal, i = integer
    
//    NSNumber *num = [NSNumber numberWithInt:index]; //object in dictionary
    
//    int prim = [myValue intValue];
//    int prim2 = [num intValue];
    
    
    NSString *defaultPrefsFile = [[NSBundle mainBundle] pathForResource:@"defaultPrefs" ofType:@"plist"];
    NSDictionary *defaultPreferences = [NSDictionary dictionaryWithContentsOfFile:defaultPrefsFile];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultPreferences];
    
    [[NSUserDefaults standardUserDefaults] setValue:myValue forKey:@"justclicked"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"Predicate value## %@", myValue);
    
}


@end
//
//  AppDelegate.h
//  Seafood Guide
//
//  Created by Jon Brown on 8/30/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSString *dataloaded;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


- (void) insertRoleWithRoleName:(NSString *)seafoodName typeName:(NSString *)seafoodType descName:(NSString *)seafoodDesc goodName:(NSString *)seafoodGood badName:(NSString *)seafoodBad regName:(NSString *)seafoodRegion;



@end
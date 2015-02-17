//
//  AppDelegate.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/4/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "AppDelegate.h"
#import "TripManager.h"

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (void)customizeAppearance
{
    [[UITextField appearance] setTintColor:[UIColor colorWithRed:0.2 green:0.25 blue:0.28 alpha:1]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHue:0.57 saturation:0.29 brightness:0.28 alpha:1]];
    if([[[UIDevice currentDevice] systemVersion] floatValue] > 8.0) {
        // for iOS 7 and earlier, this has been implemented in LoginViewController.m
        [[UINavigationBar appearance] setTranslucent:NO];
    }
    [[UINavigationBar appearance] setTintColor: [UIColor colorWithHue:0.57 saturation:0.29 brightness:0.28 alpha:1]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
                                                           NSFontAttributeName: [UIFont fontWithName:APP_FONT_BOLD size:18],
                                                           }];
//    NSShadow *shadow = [NSShadow new];
//    shadow.shadowColor = [UIColor whiteColor];
//    
//    [[UINavigationBar appearance] setTitleTextAttributes:
//     [NSDictionary dictionaryWithObjectsAndKeys:
//      [UIColor colorWithRed:66/255.0f green:58/255.0f blue:56/255.0f alpha:1.0f],
//      NSForegroundColorAttributeName,
//    shadow,
//      NSShadowAttributeName,
//      [UIFont fontWithName:APP_FONT_BOLD size:18],
//      NSFontAttributeName, nil]];
    
    //CHECK IF iOS7 OR PREV FOR BACK BUTTON ARROW
    
    UIImage *temp=nil;
    temp = [temp stretchableImageWithLeftCapWidth: 30.0 topCapHeight: 50.0];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        temp = [UIImage imageNamed:@"Back-arrow"];
        [[UIBarButtonItem appearance] setBackButtonBackgroundImage: temp forState: UIControlStateNormal barMetrics: UIBarMetricsDefault];
        [[UIBarButtonItem appearance] setBackButtonBackgroundImage: temp forState: UIControlStateNormal barMetrics: UIBarMetricsDefault];
    } else {
        temp = [[UIImage imageNamed:@"Back-arrow"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
        [[UINavigationBar appearance] setBackIndicatorImage:temp];
        [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:temp];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self customizeAppearance];
    
    TripManager *manager = [TripManager getInstance];
    manager.managedObjectContext = self.managedObjectContext;
    
    if (self.locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        self.locationManager.distanceFilter = 100.0f;
        self.locationManager.pausesLocationUpdatesAutomatically = NO;
    }
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"intrepidApp" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"intrepidApp.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption:@YES,
                              NSInferMappingModelAutomaticallyOption:@YES};
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Location methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.lastLocation = [locations lastObject];
    NSLog(@"latitude: %f, longitude: %f", self.lastLocation.coordinate.latitude, self.lastLocation.coordinate.longitude);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (error.code == kCLErrorDenied) {
        NSLog(@"user denied access to location");
        [self.locationManager stopUpdatingLocation];
        [self.locationManager stopMonitoringSignificantLocationChanges];
    } else {
        NSLog(@"location error: %@", error);
    }
}

@end

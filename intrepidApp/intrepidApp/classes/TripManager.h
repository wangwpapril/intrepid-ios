//
//  TripManager.h
//  intrepidApp
//
//  Created by Philip Ojha on 7/31/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TripManager : NSObject

// Core Data
@property ( strong, nonatomic) NSManagedObjectContext *managedObjectContext;

+(TripManager *)getInstance;
-(NSArray *) getCities;

@end

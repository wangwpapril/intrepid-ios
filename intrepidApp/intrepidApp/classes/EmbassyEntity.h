//
//  EmbassyEntity.h
//  intrepidApp
//
//  Created by Philip Ojha on 7/31/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface EmbassyEntity : NSManagedObject

@property (nonatomic, retain) NSString * embassyDescription;
@property (nonatomic, retain) NSString * flagName;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSManagedObject *city;

@end

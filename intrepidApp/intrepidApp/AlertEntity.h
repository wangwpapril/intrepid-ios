//
//  AlertEntity.h
//  intrepidApp
//
//  Created by Chaitanya Shah on 2015-01-23.
//  Copyright (c) 2015 JonCarrHarris Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CityEntity;

@interface AlertEntity : NSManagedObject

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) CityEntity *city;

@end

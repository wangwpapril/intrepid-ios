//
//  HealthEntity.h
//  intrepidApp
//
//  Created by Madelaine Page on 2014-12-14.
//  Copyright (c) 2014 JonCarrHarris Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CityEntity;

@interface HealthEntity : NSManagedObject

@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * name;
@property (nonatomic) BOOL common;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) NSString * symptoms;
@property (nonatomic, retain) NSString * immunization;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) CityEntity *city;

@end

//
//  EmbassyEntity.h
//  intrepidApp
//
//  Created by Philip Ojha on 8/21/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CityEntity;

@interface EmbassyEntity : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) CityEntity * city;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * fax;
@property (nonatomic, retain) NSString * flag;
@property (nonatomic, retain) NSString * hours;
@property (nonatomic, retain) NSString * image1x;
@property (nonatomic, retain) NSString * image2x;
@property (nonatomic, retain) NSString * image3x;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * services;

@end

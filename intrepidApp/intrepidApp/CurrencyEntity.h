//
//  CurrencyEntity.h
//  intrepidApp
//
//  Created by Madelaine Page on 2014-12-28.
//  Copyright (c) 2014 JonCarrHarris Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CityEntity;

@interface CurrencyEntity : NSManagedObject

@property (nonatomic, retain) CityEntity * city;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * value;

@end

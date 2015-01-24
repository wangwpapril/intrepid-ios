//
//  RequestBuilder.h
//  intrepidApp
//
//  Created by Philip on 2014-12-04.
//  Copyright (c) 2014 JonCarrHarris Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityEntity.h"

@interface RequestBuilder : NSObject

+ (void)fetchUser:(NSDictionary *)user;
+ (void)fetchDestinations;
+ (void)fetchTrip:(NSString *)trip;
+ (void)fetchEmbassy:(NSDictionary *)cityDict withCity:(CityEntity *)city;
+ (void)fetchCurrency:(NSDictionary *)cityDict withCity:(CityEntity *)city;
+ (void)fetchAlert:(NSDictionary *)cityDict withCity:(CityEntity *)city;

@end

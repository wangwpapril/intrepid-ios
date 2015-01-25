//
//  DestinationEntity.h
//  intrepidApp
//
//  Created by Chaitanya Shah on 2015-01-15.
//  Copyright (c) 2015 JonCarrHarris Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DestinationEntity : NSManagedObject

@property (nonatomic, retain) NSString * currencyImage1x;
@property (nonatomic, retain) NSString * currencyImage2x;
@property (nonatomic, retain) NSString * currencyImage3x;
@property (nonatomic, retain) NSNumber * destinationId;
@property (nonatomic, retain) NSString * flagImage1x;
@property (nonatomic, retain) NSString * flagImage2x;
@property (nonatomic, retain) NSString * flagImage3x;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * type;

@end

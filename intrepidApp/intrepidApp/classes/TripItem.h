//
//  TripItem.h
//  intrepidApp
//
//  Created by Jon Carr-Harris on 7/28/2013.
//  Copyright (c) 2013 Swish Labs Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TripItem : NSObject

@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *continent;
@property (nonatomic, copy) NSNumber *destinationId;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *image2x;
@property (nonatomic, copy) NSString *image3x;

@end

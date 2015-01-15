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

@property (nonatomic, retain) NSNumber * destinationId;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * name;

@end

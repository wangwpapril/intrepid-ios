//
//  HealthSearch.m
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-06.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "HealthItem.h"

@implementation HealthItem

@synthesize category;
@synthesize name;
@synthesize common;
@synthesize description;
@synthesize details;

+(id)healthItemOfCategory:(NSString *)category name:(NSString *)name description:(NSString *)description details:(NSString *)details common:(BOOL)common
{
    HealthItem *newHealthItem = [[self alloc] init];
    newHealthItem.category = category;
    newHealthItem.name = name;
    newHealthItem.common = common;
    newHealthItem.description = description;
    newHealthItem.details = details;
    return newHealthItem;
}

@end


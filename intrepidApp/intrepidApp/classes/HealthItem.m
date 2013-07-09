//
//  HealthSearch.m
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-06.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "HealthItem.h"

@interface HealthItem ()

@end

@implementation HealthItem

@synthesize category;
@synthesize name;
@synthesize common;

+(id)healthItemOfCategory:(NSString *)category name:(NSString *)name common:(BOOL)common
{
    HealthItem *newHealthItem = [[self alloc] init];
    newHealthItem.category = category;
    newHealthItem.name = name;
    newHealthItem.common = common;
    return newHealthItem;
}

@end


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
@synthesize symptoms;
@synthesize immunization;

+(id)healthItemOfCategory:(NSString *)category name:(NSString *)name description:(NSString *)description details:(NSString *)details common:(BOOL)common symptoms:(NSString *)symptoms immunization:(NSString *)immunization image:(NSString *)image;
{
    HealthItem *newHealthItem = [[self alloc] init];
    newHealthItem.category = category;
    newHealthItem.name = name;
    newHealthItem.common = common;
    newHealthItem.description = description;
    newHealthItem.details = details;
    newHealthItem.image = image;
    return newHealthItem;
}

@end


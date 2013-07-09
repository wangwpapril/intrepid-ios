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
@synthesize image;
@synthesize name;
@synthesize common;

+(id)healthItemOfCategory:(NSString *)category image:(UIImage *)image name:(NSString *)name common:(BOOL)common
{
    HealthItem *newHealthItem = [[self alloc] init];
    newHealthItem.category = category;
    newHealthItem.image = image;
    newHealthItem.name = name;
    newHealthItem.common = common;
    return newHealthItem;
}

@end


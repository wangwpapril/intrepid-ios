//
//  EmbassyDetailedItem.m
//  intrepidApp
//
//  Created by Jon Carr-Harris on 7/30/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "EmbassyDetailedItem.h"

@implementation EmbassyDetailedItem

@synthesize category;
@synthesize name;
@synthesize description;

+(id)embassyItemOfCategory:(NSString *)category name:(NSString *)name description:(NSString *)description;
{
    EmbassyDetailedItem *newEmbassyDetailedItem = [[self alloc] init];
    newEmbassyDetailedItem.category = category;
    newEmbassyDetailedItem.name = name;
    newEmbassyDetailedItem.description = description;
    return newEmbassyDetailedItem;
}

@end

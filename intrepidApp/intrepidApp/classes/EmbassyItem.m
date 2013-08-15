//
//  EmbassyItem.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/28/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "EmbassyItem.h"

@implementation EmbassyItem

@synthesize flag;
@synthesize name;
@synthesize description;

+(id)embassyItemOfContinent:(NSString *)continent name:(NSString *)name description:(NSString *)description flag:(NSString *)flag;
{
    EmbassyItem *newEmbassyItem = [[self alloc] init];
    newEmbassyItem.name = name;
    newEmbassyItem.description = description;
    newEmbassyItem.flag = flag;
    return newEmbassyItem;
}

@end

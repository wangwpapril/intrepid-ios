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
@synthesize country;


+(id)currencyItemOfCountry:(NSString *)country flag:(NSString*)flag
{
    EmbassyItem *item = [[self alloc] init];
    item.country = country;
    item.flag = flag;
    return item;
}

@end

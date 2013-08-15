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
@synthesize address;
@synthesize hours;
@synthesize tel;
@synthesize fax;
@synthesize email;
@synthesize services;
@synthesize notice;

+(id)embassyItemOfLocation:(NSString *)location name:(NSString *)name flag:(NSString *)flag address:(NSString *)address tel:(NSString *)tel fax:(NSString*)fax email:(NSString*)email hours:(NSString *)hours services:(NSString*)services notice:(NSString *)notice;
{
    EmbassyItem *newEmbassyItem = [[self alloc] init];
    newEmbassyItem.name = name;
    newEmbassyItem.flag = flag;
    newEmbassyItem.address = address;
    newEmbassyItem.hours = hours;
    newEmbassyItem.tel = tel;
    newEmbassyItem.email = email;
    newEmbassyItem.fax = fax;
    newEmbassyItem.services = services;
    newEmbassyItem.notice = notice;
    
    return newEmbassyItem;
}

@end

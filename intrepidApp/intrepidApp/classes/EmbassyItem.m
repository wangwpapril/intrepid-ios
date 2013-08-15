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
@synthesize address;
@synthesize hours;
@synthesize contact;
@synthesize services;
@synthesize notice;
@synthesize assistance;
@synthesize immigration;

+(id)embassyItemOfContinent:(NSString *)continent name:(NSString *)name description:(NSString *)description flag:(NSString *)flag address:(NSString *)address contact:(NSString *)contact hours:(NSString *)hours services:(NSString*)services notice:(NSString *)notice assistance:(NSString*)assistance immigration:(NSString*)immigration;
{
    EmbassyItem *newEmbassyItem = [[self alloc] init];
    newEmbassyItem.name = name;
    newEmbassyItem.description = description;
    newEmbassyItem.flag = flag;
    newEmbassyItem.address = address;
    newEmbassyItem.contact = hours;
    newEmbassyItem.contact = contact;
    newEmbassyItem.services = services;
    newEmbassyItem.notice = notice;
    newEmbassyItem.assistance = assistance;
    newEmbassyItem.immigration = immigration;
    
    return newEmbassyItem;
}

@end

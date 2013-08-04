//
//  CurrencyItem.m
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-23.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "CurrencyItem.h"

@implementation CurrencyItem

@synthesize flag;
@synthesize country;
@synthesize value;

+(id)currencyItemOfCountry:(NSString *)country flag:(NSString*)flag value:(NSString *)value
{
    CurrencyItem *newCurrencyItem = [[self alloc] init];
    newCurrencyItem.country = country;
    newCurrencyItem.flag = flag;
    newCurrencyItem.value = value;
    return newCurrencyItem;
}

@end



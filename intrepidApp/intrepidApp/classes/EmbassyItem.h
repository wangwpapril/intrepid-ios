//
//  EmbassyItem.h
//  intrepidApp
//
//  Created by Philip Ojha on 7/28/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmbassyItem : NSObject


@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *contact;
@property (nonatomic, strong) NSString *hours;
@property (nonatomic, strong) NSString *services;
@property (nonatomic, strong) NSString *notice;
@property (nonatomic, strong) NSString *assistance;
@property (nonatomic, strong) NSString *immigration;

+(id)embassyItemOfContinent:(NSString *)continent name:(NSString *)name description:(NSString *)description flag:(NSString *)flag address:(NSString *)address contact:(NSString *)contact hours:(NSString *)hours services:(NSString*)services notice:(NSString *)notice assistance:(NSString*)assistance immigration:(NSString*)immigration;


@end



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
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *fax;
@property (nonatomic, strong) NSString *hours;
@property (nonatomic, strong) NSString *services;
@property (nonatomic, strong) NSString *notice;

+(id)embassyItemOfLocation:(NSString *)location name:(NSString *)name flag:(NSString *)flag address:(NSString *)address tel:(NSString *)tel fax:(NSString*)fax email:(NSString*)email hours:(NSString *)hours services:(NSString*)services notice:(NSString *)notice;


@end



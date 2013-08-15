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

+(id)embassyItemOfContinent:(NSString *)continent name:(NSString *)name description:(NSString *)description flag:(NSString *)flag;


@end



//
//  HealthSearch.h
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-06.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HealthItem : NSObject {
    NSString *category;
    NSString *name;
    BOOL common;
}

@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *name;

@property (nonatomic) BOOL common;

+(id)healthItemOfCategory:(NSString*)category name:(NSString*)name common:(BOOL)common;

@end

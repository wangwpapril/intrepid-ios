//
//  EmbassyDetailedItem.h
//  intrepidApp
//
//  Created by Jon Carr-Harris on 7/30/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmbassyDetailedItem : NSObject {

}
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *description;

+(id)embassyItemOfCategory:(NSString *)category name:(NSString *)name description:(NSString *)description;

@end



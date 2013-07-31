//
//  EmbassyDetailedContent.m
//  intrepidApp
//
//  Created by Jon Carr-Harris on 7/30/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "EmbassyDetailedContent.h"
#import "EmbassyDetailedItem.h"

@implementation EmbassyDetailedContent

-(NSMutableArray *)getContent {
    NSArray *embassy = [NSArray arrayWithObjects:[EmbassyDetailedItem embassyItemOfCategory:@"embassy" name:@"United States" description:@"Nice"],  nil];
    
    NSMutableArray *contentArray = [[NSMutableArray alloc] initWithObjects:embassy, nil];
    return contentArray;
}

@end

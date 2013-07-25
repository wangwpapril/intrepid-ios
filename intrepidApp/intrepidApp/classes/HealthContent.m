//
//  HealthContent.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/25/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "HealthContent.h"
#import "HealthItem.h"

@implementation HealthContent


-(NSMutableArray *)getContent {
    
    NSArray *conditions = [NSArray arrayWithObjects:
                           [HealthItem healthItemOfCategory:@"symptoms" name:@"Arm Fracture" description:@"blah" details:@"bleh" common:TRUE],
                           [HealthItem healthItemOfCategory:@"symptoms" name:@"Heartburn" description:@"aha" details:@"woohoo" common:TRUE],
                            nil];
    
    NSArray *symptoms  = [NSArray arrayWithObjects:
                          [HealthItem healthItemOfCategory:@"prevention" name:@"Arm Fracture" description:@"blah" details:@"bleh" common:TRUE],
                          [HealthItem healthItemOfCategory:@"prevention" name:@"Heartburn" description:@"aha" details:@"woohoo" common:TRUE],
                           nil];
    NSArray *medication  = [NSArray arrayWithObjects:
                          [HealthItem healthItemOfCategory:@"medications" name:@"Arm Fracture" description:@"blah" details:@"bleh" common:TRUE],
                          [HealthItem healthItemOfCategory:@"medications" name:@"Heartburn" description:@"aha" details:@"woohoo" common:TRUE],
                           nil];
    
    NSMutableArray *contentArray = [[NSMutableArray alloc] initWithObjects:conditions, symptoms, medication, nil];
    return contentArray;
    
}
@end

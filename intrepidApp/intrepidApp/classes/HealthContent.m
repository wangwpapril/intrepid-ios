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
    
    NSArray *symptoms = [NSArray arrayWithObjects:
                           [HealthItem healthItemOfCategory:@"symptoms" name:@"Altitude Sickness" description:@"When the alititude exceeds 2,500 metres, the partial pressure of oxygen decreases, causing increased breathing and rapid heartbeat as well as dehydration. This collection of symptoms is called altitude sickness" details:@"Symptoms of latitude Sickness include headaches (50 percent of travellers suffer headaches at 3,500 metres), anusea, vomiting, loss of appetite, shortness of breath, swelling of the face and eyelids, palpitations, anxiety, insomnia" common:TRUE],
                           [HealthItem healthItemOfCategory:@"symptoms" name:@"Heartburn" description:@"aha" details:@"woohoo" common:TRUE],
                            nil];
    
    NSArray *prevention  = [NSArray arrayWithObjects:
                          [HealthItem healthItemOfCategory:@"prevention" name:@"Arm Fracture" description:@"blah" details:@"bleh" common:TRUE],
                          [HealthItem healthItemOfCategory:@"prevention" name:@"Heartburn" description:@"aha" details:@"woohoo" common:TRUE],
                           nil];
    NSArray *medication  = [NSArray arrayWithObjects:
                          [HealthItem healthItemOfCategory:@"medications" name:@"Arm Fracture" description:@"blah" details:@"bleh" common:TRUE],
                          [HealthItem healthItemOfCategory:@"medications" name:@"Heartburn" description:@"aha" details:@"woohoo" common:TRUE],
                           nil];
    
    NSMutableArray *contentArray = [[NSMutableArray alloc] initWithObjects:symptoms, prevention, medication, nil];
    return contentArray;
    
}
@end

//
//  Symptom.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/4/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "Symptom.h"

@implementation Symptom
@synthesize category;
@synthesize name;

+ (id)symptomOfCategory:(NSString *)category name:(NSString *)name
{
    Symptom *newSymptom = [[self alloc] init];
    newSymptom.category = category;
    newSymptom.name = name;
    return newSymptom;
}

@end

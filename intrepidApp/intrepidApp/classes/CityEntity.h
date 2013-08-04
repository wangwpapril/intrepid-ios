//
//  CityEntity.h
//  intrepidApp
//
//  Created by Philip Ojha on 8/3/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CityEntity : NSManagedObject

@property (nonatomic, retain) NSString * alertsURL;
@property (nonatomic, retain) NSString * cityImage;
@property (nonatomic, retain) NSString * cityName;
@property (nonatomic, retain) NSString * clinicsURL;
@property (nonatomic, retain) NSString * continent;
@property (nonatomic, retain) NSString * cultureImage;
@property (nonatomic, retain) NSString * cultureText;
@property (nonatomic, retain) NSString * generalImage;
@property (nonatomic, retain) NSString * generalText;
@property (nonatomic, retain) NSString * localImage;
@property (nonatomic, retain) NSString * localText;
@property (nonatomic, retain) NSString * politicalImage;
@property (nonatomic, retain) NSString * politicalText;
@property (nonatomic, retain) NSString * weatherURL;
@property (nonatomic, retain) NSNumber * cadToNative;
@end


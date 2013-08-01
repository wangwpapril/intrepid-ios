//
//  CityEntity.h
//  intrepidApp
//
//  Created by Philip Ojha on 7/31/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class EmbassyEntity;

@interface CityEntity : NSManagedObject

@property (nonatomic, retain) NSString * cityImage;
@property (nonatomic, retain) NSString * cityName;
@property (nonatomic, retain) NSString * continent;
@property (nonatomic, retain) NSString * cultureImage;
@property (nonatomic, retain) NSString * cultureText;
@property (nonatomic, retain) NSString * generalImage;
@property (nonatomic, retain) NSString * generalText;
@property (nonatomic, retain) NSString * localImage;
@property (nonatomic, retain) NSString * localText;
@property (nonatomic, retain) NSString * politicalImage;
@property (nonatomic, retain) NSString * politicalText;
@property (nonatomic, retain) NSSet *embassyItems;
@end

@interface CityEntity (CoreDataGeneratedAccessors)

- (void)addEmbassyItemsObject:(EmbassyEntity *)value;
- (void)removeEmbassyItemsObject:(EmbassyEntity *)value;
- (void)addEmbassyItems:(NSSet *)values;
- (void)removeEmbassyItems:(NSSet *)values;

@end

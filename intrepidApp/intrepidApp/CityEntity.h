//
//  CityEntity.h
//  
//
//  Created by Madelaine Page on 2014-12-15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class EmbassyEntity, HealthEntity;

@interface CityEntity : NSManagedObject

@property (nonatomic, retain) NSString * alertsURL;
@property (nonatomic, retain) NSNumber * cadToNative;
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
@property (nonatomic, retain) NSString * safetyImage;
@property (nonatomic, retain) NSString * safetyText;
@property (nonatomic, retain) NSString * weatherURL;
@property (nonatomic, retain) NSSet *embassies;
@property (nonatomic, retain) HealthEntity *health;
@end

@interface CityEntity (CoreDataGeneratedAccessors)

- (void)addEmbassiesObject:(EmbassyEntity *)value;
- (void)removeEmbassiesObject:(EmbassyEntity *)value;
- (void)addEmbassies:(NSSet *)values;
- (void)removeEmbassies:(NSSet *)values;

@end

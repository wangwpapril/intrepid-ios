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
@property (nonatomic, retain) NSString * destinationName;
@property (nonatomic, retain) NSString * clinicsURL;
@property (nonatomic, retain) NSString * continent;
@property (nonatomic, retain) NSString * cultureImage;
@property (nonatomic, retain) NSString * cultureText;
@property (nonatomic, retain) NSString * destinationType;
@property (nonatomic, retain) NSNumber * destinationId;
@property (nonatomic, retain) NSString * generalImage;
@property (nonatomic, retain) NSString * generalText;
@property (nonatomic, retain) NSString * introImage1x;
@property (nonatomic, retain) NSString * introImage2x;
@property (nonatomic, retain) NSString * introImage3x;
@property (nonatomic, retain) NSString * localImage;
@property (nonatomic, retain) NSString * localText;
@property (nonatomic, retain) NSString * safetyImage;
@property (nonatomic, retain) NSString * safetyText;
@property (nonatomic, retain) NSString * weatherURL;
@property (nonatomic, retain) NSSet *embassies;
@property (nonatomic, retain) HealthEntity *health;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * climate;
@property (nonatomic, retain) NSString * type_of_government;
@property (nonatomic, retain) NSString * visa_requirements;
@property (nonatomic, retain) NSString * communication_infrastructure;
@property (nonatomic, retain) NSString * electricity;
@property (nonatomic, retain) NSString * development;
@property (nonatomic, retain) NSString * language;
@property (nonatomic, retain) NSString * religion;
@property (nonatomic, retain) NSString * ethnic_makeup;
@property (nonatomic, retain) NSString * cultural_norms;
@property (nonatomic, retain) NSString * safety;
@property (nonatomic, retain) NSString * other_concerns;
@end

@interface CityEntity (CoreDataGeneratedAccessors)

- (void)addEmbassiesObject:(EmbassyEntity *)value;
- (void)removeEmbassiesObject:(EmbassyEntity *)value;
- (void)addEmbassies:(NSSet *)values;
- (void)removeEmbassies:(NSSet *)values;

@end

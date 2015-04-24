//
//  CityEntity.h
//  
//
//  Created by Madelaine Page on 2014-12-15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class EmbassyEntity, HealthEntity, CurrencyEntity;

@interface CityEntity : NSManagedObject

@property (nonatomic, retain) NSString * climate;
@property (nonatomic, retain) NSString * communicationInfrastructure;
@property (nonatomic, retain) NSString * countryCode;
@property (nonatomic, retain) NSString * culturalNorms;
@property (nonatomic, retain) NSString * cultureImage1x;
@property (nonatomic, retain) NSString * cultureImage2x;
@property (nonatomic, retain) NSString * cultureImage3x;
@property (nonatomic, retain) NSString * cultureText;
@property (nonatomic, retain) CurrencyEntity * currency;
@property (nonatomic, retain) NSString * currencyCode;
@property (nonatomic, retain) NSNumber * destinationId;
@property (nonatomic, retain) NSString * destinationName;
@property (nonatomic, retain) NSString * destinationType;
@property (nonatomic, retain) NSString * development;
@property (nonatomic, retain) NSString * electricity;
@property (nonatomic, retain) EmbassyEntity * embassy;
@property (nonatomic, retain) NSString * ethnicMakeup;
@property (nonatomic, retain) NSString * generalImage1x;
@property (nonatomic, retain) NSString * generalImage2x;
@property (nonatomic, retain) NSString * generalImage3x;
@property (nonatomic, retain) NSString * generalText;
@property (nonatomic, retain) HealthEntity * health;
@property (nonatomic, retain) NSString * healthCareQuality;
@property (nonatomic, retain) NSString * healthConditions;
@property (nonatomic, retain) NSString * holidays;
@property (nonatomic, retain) NSString * introImage1x;
@property (nonatomic, retain) NSString * introImage2x;
@property (nonatomic, retain) NSString * introImage3x;
@property (nonatomic, retain) NSString * language;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * medicalImage1x;
@property (nonatomic, retain) NSString * medicalImage2x;
@property (nonatomic, retain) NSString * medicalImage3x;
@property (nonatomic, retain) NSString * money;
@property (nonatomic, retain) NSString * otherConcerns;
@property (nonatomic, retain) NSString * religion;
@property (nonatomic, retain) NSString * safety;
@property (nonatomic, retain) NSString * safetyImage1x;
@property (nonatomic, retain) NSString * safetyImage2x;
@property (nonatomic, retain) NSString * safetyImage3x;
@property (nonatomic, retain) NSString * safetyText;
@property (nonatomic, retain) NSString * transportation;
@property (nonatomic, retain) NSString * typeOfGovernment;
@property (nonatomic, retain) NSString * vaccinationsAndPreTripMedical;
@property (nonatomic, retain) NSString * visaRequirements;

@end

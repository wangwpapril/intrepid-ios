//
//  TripManager.h
//  intrepidApp
//
//  Created by Philip Ojha on 7/31/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityEntity.h"
#import "HealthEntity.h"
#import "CurrencyEntity.h"
#import "DestinationEntity.h"

@interface TripManager : NSObject

// Core Data
@property ( strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSDictionary *currentUser;

+ (TripManager *)getInstance;
- (NSArray *)getSavedCities;
- (NSArray *)getDestinations;
- (void)addUserDict:(NSDictionary *)userDict;


- (CityEntity *)createTripWithCultureText:(NSString *)cultureText
                             withLanguage:(NSString *)language
                             withReligion:(NSString *)religion
                         withethnicMakeup:(NSString *)ethnicMakeup
                        withCulturalNorms:(NSString *)culturalNorms
                       withCultureImage1x:(NSString *)cultureImage1x
                       withCultureImage2x:(NSString *)cultureImage2x
                       withCultureImage3x:(NSString *)cultureImage3x
                      withDestinationName:(NSString *)destinationName
                        withDestinationId:(NSInteger )destinationId
                      withDestinationType:(NSString *)destinationType
                          withGeneralText:(NSString *)generalText
                             withLocation:(NSString *)location
                              withClimate:(NSString *)climate
                     withTypeOfGovernment:(NSString *)typeOfGovernment
                     withVisaRequirements:(NSString *)visaRequirements
          withCommunicationInfrastructure:(NSString *)communicationInfrastructure
                          withElectricity:(NSString *)electricity
                          withDevelopment:(NSString *)development
                       withGeneralImage1x:(NSString *)generalImage1x
                       withGeneralImage2x:(NSString *)generalImage2x
                       withGeneralImage3x:(NSString *)generalImage3x
                         withIntroImage1x:(NSString *)introImage1x
                         withIntroImage2x:(NSString *)introImage2x
                         withIntroImage3x:(NSString *)introImage3x
                           withSafetyText:(NSString *)safetyText
                               withSafety:(NSString *)safety
                        withOtherConcerns:(NSString *)otherConcerns
                        withSafetyImage1x:(NSString *)safetyImage1x
                        withSafetyImage2x:(NSString *)safetyImage2x
                        withSafetyImage3x:(NSString *)safetyImage3x
                           withClinicsURL:(NSString *)clinicsURL
                            withAlertsURL:(NSString *)alertsURL
                          withCADToNative:(float) dollarRatio;

- (DestinationEntity *)createDestinationWithName:(NSString *)name
                               withDestinationId:(NSInteger )destinationId
                                        withType:(NSString *)type;

- (EmbassyEntity *)createEmbassyWithCity:(CityEntity *)city
                    withPhone:(NSString *)phone
                      withFax:(NSString *)fax
                    withEmail:(NSString *)email
                    withHours:(NSString *)hours
                    withNotes:(NSString *)notes
                 withServices:(NSString *)services
                  withAddress:(NSString *)address
                  withCountry:(NSString *)country
                     withFlag:(NSString *)flag
                  withImage1x:(NSString *)image1x
                  withImage2x:(NSString *)image2x
                  withImage3x:(NSString *)image3x;

- (HealthEntity *)createHealthItemWithCity:(CityEntity *)city
                    withCategory:(NSString *)category
                        withName:(NSString *)name
                        withCommon:(BOOL)common
                        withDesc:(NSString *)desc
                    withDetails:(NSString *)details
                    withSymptoms:(NSString *)symptoms
                withImmunizations:(NSString *)immunizations
                        withImportant:(NSString *)important
                        withImage:(NSString *)image;

- (CurrencyEntity *)createCurrencyItemWithCity:(CityEntity *)city
                                       Country:(NSString *)country
                                     withValue:(NSString *)value;

- (NSMutableArray *)getHealthItemsWithCity:(CityEntity *)city;
- (NSMutableArray *)getCurrencyItemsWithCity:(CityEntity *)city;
- (NSMutableArray *)getEmbassyItemsWithCity:(CityEntity *)city;
- (void)deleteAllObjects:(NSString *)entityDescription;
- (void)deleteHealthItemsWithCity:(CityEntity *)city;
- (void)deleteEmbassyItemsWithCity:(CityEntity *)city;
- (void)deleteCurrencyItemsWithCity:(CityEntity *)city;
- (void)saveCity:(NSDictionary *)cityDict;

@end

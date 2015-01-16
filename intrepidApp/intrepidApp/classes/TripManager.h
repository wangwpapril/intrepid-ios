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
@property (strong, nonatomic) NSMutableArray *unsavedCities;

+ (TripManager *)getInstance;
- (NSArray *)getSavedCities;
- (NSArray *)getDestinations;
- (void)addCityDict:(NSDictionary *)cityDict;


- (CityEntity *)createTripWithCityImage:(NSString *)cityImage
                           withCityName:(NSString *)cityName
                          withContinent:(NSString *)continent
                        withCultureText:(NSString *)cultureText
                       withCultureImage:(NSString *)cultureImage
                      withDestinationId:(NSInteger )destinationId
                    withDestinationType:(NSString *)destinationType
                        withGeneralText:(NSString *)generalText
                       withGeneralImage:(NSString *)generalImage
                         withLocalImage:(NSString *)localImage
                          withLocalText:(NSString *)localText
                     withSafetyImage:(NSString *)safetyImage
                      withSafetyText:(NSString *)safetyText
                         withClinicsURL:(NSString *)clinicsURL
                          withAlertsURL:(NSString *)alertsURL
                         withWeatherURL:(NSString *)weatherURL
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
                     withFlag:(NSString *)flag;

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

- (CurrencyEntity *)createCurrencyItemWithCountry:(NSString *)country
                            withValue:(NSString *)value;

- (NSMutableArray *)getHealthItemsWithCity:(CityEntity *)city;
- (NSMutableArray *)getCurrencyItemsWithCity:(CityEntity *)city;
- (NSMutableArray *)getEmbassyItemsWithCity:(CityEntity *)city;
- (void)deleteAllObjects:(NSString *)entityDescription;
- (void)deleteHealthItemsWithCity:(CityEntity *)city;
- (void)deleteEmbassyItemsWithCity:(CityEntity *)city;
- (void)saveCity:(NSDictionary *)cityDict;

@end

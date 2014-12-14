//
//  TripManager.h
//  intrepidApp
//
//  Created by Philip Ojha on 7/31/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityEntity.h"

@interface TripManager : NSObject

// Core Data
@property ( strong, nonatomic) NSManagedObjectContext *managedObjectContext;

+(TripManager *)getInstance;
-(NSArray *) getCities;

- (CityEntity *)createTripWithCityImage:(NSString *)cityImage
                           withCityName:(NSString *)cityName
                          withContinent:(NSString *)continent
                        withCultureText:(NSString *)cultureText
                       withCultureImage:(NSString *)cultureImage
                        withGeneralText:(NSString *)generalText
                       withGeneralImage:(NSString *)generalImage
                         withLocalImage:(NSString *)localImage
                          withLocalText:(NSString *)localText
                     withSafetyImage:(NSString *)safetyImage
                      withSafetytext:(NSString *)safetyText
                         withClinicsURL:(NSString *)clinicsURL
                          withAlertsURL:(NSString *)alertsURL
                         withWeatherURL:(NSString *)weatherURL
                        withCADToNative:(float) dollarRatio;

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

- (void) deleteAllObjects: (NSString *) entityDescription;
@end

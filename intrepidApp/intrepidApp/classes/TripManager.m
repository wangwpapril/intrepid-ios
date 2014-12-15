//
//  TripManager.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/31/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "TripManager.h"
#import "EmbassyEntity.h"
#import "RequestBuilder.h"

@implementation TripManager

@synthesize managedObjectContext;

static TripManager *instance =nil;
+(TripManager *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            // instantiate some global variables
            instance = [[TripManager alloc] init];
        }
    }
    return instance;    
}

-(NSArray *) getCities {
    NSArray *cityArray = [self fetchCityArray];
    if (cityArray.count == 0) {
        cityArray = [self fetchCityArray];
    }
    return cityArray;
}

-(NSArray *)fetchCityArray {
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"CityEntity" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];

    
    NSError *error;
    NSArray *intermediateArray = [managedObjectContext executeFetchRequest:request error:&error];
    return intermediateArray;
}

-(NSMutableArray *)getHealthItemsWithCity:(CityEntity *)city {
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"HealthEntity" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    
    NSError *error;
    NSArray *intermediateArray = [managedObjectContext executeFetchRequest:request error:&error];
    NSMutableArray * diseases = [NSMutableArray new];
    NSMutableArray * medication = [NSMutableArray new];

    for (HealthEntity *healthItem in intermediateArray) {
        NSLog(@"looking for city: %@", city.cityName);
        if ([healthItem.city.cityName isEqualToString:city.cityName]) {
            NSLog(@"name %@ with bool value %d", healthItem.name, healthItem.common);
            if ([healthItem.category isEqualToString:@"medications"]) {
                [medication addObject:healthItem];
            }
            else {
                [diseases addObject:healthItem];
            }
        }
        else {
            NSLog(@"city name was: %@", healthItem.city.cityName);
        }
    }
    
    NSMutableArray * healthArray = [NSMutableArray new];

    [healthArray addObject:diseases];
    [healthArray addObject:medication];
    
    return healthArray;
}

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
{
    EmbassyEntity *embassy = [NSEntityDescription insertNewObjectForEntityForName:@"EmbassyEntity" inManagedObjectContext:managedObjectContext];

    embassy.phone = phone;
    embassy.fax = fax;
    embassy.email = email;
    embassy.hours = hours;
    embassy.notes = notes;
    embassy.services = services;
    embassy.address = address;
    embassy.city = city;
    embassy.country = country;
    embassy.flag = flag;
    [city addEmbassiesObject:embassy];
    
    NSError *error = nil;
    if ([managedObjectContext save:&error]) {
        NSLog(@"saved");
    } else {
        NSLog(@"save failed");
    }
    return embassy;
}

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
                withCADToNative:(float) dollarRatio
{
    CityEntity *city = [NSEntityDescription insertNewObjectForEntityForName:@"CityEntity" inManagedObjectContext:managedObjectContext];

    city.cityImage = cityImage;
    city.cityName = cityName;
    city.continent = continent;
    city.cultureImage = cultureImage;
    city.cultureText = cultureText;
    city.generalImage = generalImage;
    city.generalText = generalText;
    city.localImage = localImage;;
    city.localText = localText;
    city.safetyImage = safetyImage;
    city.safetyText = safetyText;
    city.clinicsURL = clinicsURL;
    city.alertsURL = alertsURL;
    city.weatherURL = weatherURL;
    city.cadToNative = [NSNumber numberWithFloat:dollarRatio];
    
//    city.embassyItems;
//    dispatch_async(dispatch_get_main_queue(), ^{
        NSError *error = nil;
        if ([managedObjectContext save:&error]) {
            NSLog(@"saved");
        } else {
            NSLog(@"save failed");
        }
//    });
    return city;
}

- (HealthEntity *)createHealthItemWithCity:(CityEntity *)city
                              withCategory:(NSString *)category
                                  withName:(NSString *)name
                                withCommon:(BOOL)common
                                  withDesc:(NSString *)desc
                               withDetails:(NSString *)details
                              withSymptoms:(NSString *)symptoms
                         withImmunizations:(NSString *)immunizations
                                 withImage:(NSString *)image{
    HealthEntity *health = [NSEntityDescription insertNewObjectForEntityForName:@"HealthEntity" inManagedObjectContext:managedObjectContext];
    
    
    health.city = city;
    health.category = category;
    health.name = name;
    health.common = common;
    health.desc = desc;
    health.symptoms = symptoms;
    health.details = details;
    health.immunization = immunizations;
    health.image = image;
    
    NSError *error = nil;
    if ([managedObjectContext save:&error]) {
        NSLog(@"saved");
    } else {
        NSLog(@"save failed");
    }
    return health;
    
    
}

- (void) deleteAllObjects: (NSString *) entityDescription  {
    NSLog(@"delete all the things!");
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityDescription inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *items = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *managedObject in items) {
        [managedObjectContext deleteObject:managedObject];
    }
    if (![managedObjectContext save:&error]) {
    }
    
}

@end

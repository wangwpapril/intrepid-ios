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
@synthesize unsavedCities;

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

- (NSArray *)getDestinations {
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"DestinationEntity" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    [request setReturnsObjectsAsFaults:NO];
    
    NSError *error;
    NSArray *intermediateArray = [managedObjectContext executeFetchRequest:request error:&error];
    return intermediateArray;
}

- (NSArray *)getSavedCities {
    NSArray *cityArray = [self fetchCityArray];
    if (cityArray.count == 0) {
        cityArray = [self fetchCityArray];
    }
    return cityArray;
}

- (NSArray *)fetchCityArray {
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"CityEntity" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    
    NSError *error;
    NSArray *intermediateArray = [managedObjectContext executeFetchRequest:request error:&error];
    return intermediateArray;
}

- (void)addCityDict:(NSDictionary *)cityDict {
    [unsavedCities addObject:cityDict];
}

- (NSMutableArray *)getHealthItemsWithCity:(CityEntity *)city {
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"HealthEntity" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setPredicate:[NSPredicate predicateWithFormat:@"city == %@", city]];
    [request setEntity:entityDescription];
    
    NSError *error;
    NSArray *intermediateArray = [managedObjectContext executeFetchRequest:request error:&error];
    NSMutableArray * diseases = [NSMutableArray new];
    NSMutableArray * medication = [NSMutableArray new];
    
    for (HealthEntity *healthItem in intermediateArray) {
        if ([healthItem.category isEqualToString:@"medications"]) {
            [medication addObject:healthItem];
        } else {
            [diseases addObject:healthItem];
        }
    }
    
    NSMutableArray * healthArray = [NSMutableArray new];
    [healthArray addObject:diseases];
    [healthArray addObject:medication];
    return healthArray;
}

- (NSMutableArray *)getEmbassyItemsWithCity:(CityEntity*)city {
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"EmbassyEntity" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setPredicate:[NSPredicate predicateWithFormat:@"city == %@", city]];
    [request setEntity:entityDescription];
    
    NSError *error;
    NSArray *intermediateArray = [managedObjectContext executeFetchRequest:request error:&error];
    NSMutableArray *embassies = [NSMutableArray new];
    
    for (EmbassyEntity *embassyItem in intermediateArray) {
        [embassies addObject:embassyItem];
    }
    
    return embassies;
}

- (NSMutableArray *)getCurrencyItemsWithCity:(CityEntity *)city {
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"CurrencyEntity" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setPredicate:[NSPredicate predicateWithFormat:@"city == %@", city]];
    [request setEntity:entityDescription];
    
    NSError *error;
    NSArray *intermediateArray = [managedObjectContext executeFetchRequest:request error:&error];
    NSMutableArray * currencies = [NSMutableArray new];

    for (CurrencyEntity *currencyItem in intermediateArray) {
        [currencies addObject:currencyItem];
    }
    
    return currencies;
}

- (void)deleteAllObjects:(NSString *)entityDescription  {
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

- (void)deleteHealthItemsWithCity:(CityEntity *)city {
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"HealthEntity" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setPredicate:[NSPredicate predicateWithFormat:@"city == %@", city]];
    [request setEntity:entityDescription];
    
    NSError *error;
    NSArray *items = [managedObjectContext executeFetchRequest:request error:&error];

    for (NSManagedObject *managedObject in items) {
        [managedObjectContext deleteObject:managedObject];
    }
    if (![managedObjectContext save:&error]) {
    }
}

- (void)deleteEmbassyItemsWithCity:(CityEntity *)city {
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"EmbassyEntity" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setPredicate:[NSPredicate predicateWithFormat:@"city == %@", city]];
    [request setEntity:entityDescription];
    
    NSError *error;
    NSArray *items = [managedObjectContext executeFetchRequest:request error:&error];
    
    for (NSManagedObject *managedObject in items) {
        [managedObjectContext deleteObject:managedObject];
    }
    if (![managedObjectContext save:&error]) {
    }
}

- (void)deleteCurrencyItemsWithCity:(CityEntity *)city {
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"CurrencyEntity" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setPredicate:[NSPredicate predicateWithFormat:@"city == %@", city]];
    [request setEntity:entityDescription];
    
    NSError *error;
    NSArray *items = [managedObjectContext executeFetchRequest:request error:&error];
    
    for (NSManagedObject *managedObject in items) {
        [managedObjectContext deleteObject:managedObject];
    }
    if (![managedObjectContext save:&error]) {
    }
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
            withImage1x:(NSString *)image1x
            withImage2x:(NSString *)image2x
            withImage3x:(NSString *)image3x
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
    embassy.image1x = image1x;
    embassy.image2x = image2x;
    embassy.image3x = image3x;
    [city addEmbassiesObject:embassy];
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        NSLog(@"save failed");
    }
    return embassy;
}

- (CityEntity *)createTripWithCultureText:(NSString *)cultureText
                       withCultureImage1x:(NSString *)cultureImage1x
                       withCultureImage2x:(NSString *)cultureImage2x
                       withCultureImage3x:(NSString *)cultureImage3x
                      withDestinationName:(NSString *)destinationName
                        withDestinationId:(NSInteger )destinationId
                      withDestinationType:(NSString *)destinationType
                          withGeneralText:(NSString *)generalText
                       withGeneralImage1x:(NSString *)generalImage1x
                       withGeneralImage2x:(NSString *)generalImage2x
                       withGeneralImage3x:(NSString *)generalImage3x
                         withIntroImage1x:(NSString *)introImage1x
                         withIntroImage2x:(NSString *)introImage2x
                         withIntroImage3x:(NSString *)introImage3x
                        withSafetyImage1x:(NSString *)safetyImage1x
                        withSafetyImage2x:(NSString *)safetyImage2x
                        withSafetyImage3x:(NSString *)safetyImage3x
                           withSafetyText:(NSString *)safetyText
                           withClinicsURL:(NSString *)clinicsURL
                            withAlertsURL:(NSString *)alertsURL
                          withCADToNative:(float) dollarRatio
{
    CityEntity *city = [NSEntityDescription insertNewObjectForEntityForName:@"CityEntity" inManagedObjectContext:managedObjectContext];

    city.cultureImage1x = cultureImage1x;
    city.cultureImage2x = cultureImage2x;
    city.cultureImage3x = cultureImage3x;
    city.cultureText = cultureText;
    city.destinationName = destinationName;
    city.destinationId = [NSNumber numberWithInteger:destinationId];
    city.destinationType = destinationType;
    city.generalImage1x = generalImage1x;
    city.generalImage2x = generalImage2x;
    city.generalImage3x = generalImage3x;
    city.generalText = generalText;
    city.introImage1x = introImage1x;
    city.introImage2x = introImage2x;
    city.introImage3x = introImage3x;
    city.safetyImage1x = safetyImage1x;
    city.safetyImage2x = safetyImage2x;
    city.safetyImage3x = safetyImage3x;
    city.safetyText = safetyText;
    city.clinicsURL = clinicsURL;
    city.alertsURL = alertsURL;
    city.cadToNative = [NSNumber numberWithFloat:dollarRatio];
    
//    city.embassyItems;
//    dispatch_async(dispatch_get_main_queue(), ^{
        NSError *error = nil;
        if (![managedObjectContext save:&error]) {
            NSLog(@"save failed");
        }
//    });
    return city;
}

- (DestinationEntity *)createDestinationWithName:(NSString *)name
                               withDestinationId:(NSInteger )destinationId
                                        withType:(NSString *)type
{
    DestinationEntity *destination = [NSEntityDescription insertNewObjectForEntityForName:@"DestinationEntity" inManagedObjectContext:managedObjectContext];
    
    destination.name = name;
    destination.destinationId = [NSNumber numberWithInteger:destinationId];
    destination.type = type;
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        NSLog(@"save failed");
    }
    
    return destination;
}

- (HealthEntity *)createHealthItemWithCity:(CityEntity *)city
                              withCategory:(NSString *)category
                                  withName:(NSString *)name
                                withCommon:(BOOL)common
                                  withDesc:(NSString *)desc
                               withDetails:(NSString *)details
                              withSymptoms:(NSString *)symptoms
                         withImmunizations:(NSString *)immunizations
                             withImportant:(NSString *)important
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
    health.important = important;
    health.image = image;
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        NSLog(@"save failed");
    }
    
    return health;
}

- (CurrencyEntity *)createCurrencyItemWithCity:(CityEntity *)city
                                       Country:(NSString *)country
                                     withValue:(NSString *)value {
    CurrencyEntity *currency = [NSEntityDescription insertNewObjectForEntityForName:@"CurrencyEntity" inManagedObjectContext:managedObjectContext];
    
    currency.city = city;
    currency.country = country;
    currency.value = value;
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        NSLog(@"save failed");
    }

    return currency;
}

- (void)saveCity:(NSDictionary *)cityDict {
    NSString *cultureText, *destinationName, *destinationType, *generalText, *safetyText, *clinicsURL, *alertsURL, *location, *climate, *type_of_government, *visa_requirements, *communication_infrastructure, *electricity, *development, *language, *religion, *ethnic_makeup, *cultural_norms, *safety, *other_concerns;
    NSString *cultureImage1x, *cultureImage2x, *cultureImage3x, *introImage1x, *introImage2x, *introImage3x, *generalImage1x, *generalImage2x, *generalImage3x, *safetyImage1x, *safetyImage2x, *safetyImage3x;
    NSInteger destinationId;
    float dollarRatio;
    
    NSString *name, *category, *desc, *details, *symptoms, *immunizations, *important, *image;
    Boolean common;
    
    destinationName = cityDict[@"name"];
    destinationId = [cityDict[@"id"] integerValue];
    destinationType = cityDict[@"type"];
    
    NSDictionary *contentDict = cityDict[@"content"];
    
    //General Description Subtext
    location = contentDict[@"location"];
    climate = contentDict[@"climate"];
    type_of_government = contentDict[@"type_of_government"];
    visa_requirements = contentDict[@"visa_map_attributes"];
    communication_infrastructure = contentDict[@"communication_infrastructure"];
    electricity = contentDict[@"electricity"];
    development = contentDict[@"development"];
    
    //Culture Description Subtext
    language = contentDict[@"language"];
    religion = contentDict[@"religion"];
    ethnic_makeup = contentDict[@"ethnic_makeup"];
    cultural_norms = contentDict[@"cultural_norms"];
    
    //Security Description Subtext
    safety = contentDict[@"safety"];
    other_concerns = contentDict[@"other_concerns"];
    
    generalText = [NSString stringWithFormat:@"Location \n%@ \n\nClimate \n%@ \n\nType of Government \n%@ \n\nVisa Requirements \n%@ \n\nCommunication Infrastructure \n%@ \n\nElectricity \n%@ \n\nDevelopment \n%@",location, climate,type_of_government, visa_requirements, communication_infrastructure, electricity, development];
    cultureText = [NSString stringWithFormat:@"Language \n%@ \n\nReligion \n%@ \n\nEthnic Makeup \n%@ \n\nCultural Norms \n%@",language,religion,ethnic_makeup, cultural_norms];
    safetyText = [NSString stringWithFormat:@"Safety \n%@ \n\nOther Concerns \n%@",safety,other_concerns];
    
    if (cityDict[@"images"] != [NSNull null]) {
        cultureImage1x = cityDict[@"images"][@"culture"][@"versions"][@"1x"][@"source_url"];
        cultureImage2x = cityDict[@"images"][@"culture"][@"versions"][@"2x"][@"source_url"];
        cultureImage3x = cityDict[@"images"][@"culture"][@"versions"][@"3x"][@"source_url"];
        introImage1x = cityDict[@"images"][@"intro"][@"versions"][@"1x"][@"source_url"];
        introImage2x = cityDict[@"images"][@"intro"][@"versions"][@"2x"][@"source_url"];
        introImage3x = cityDict[@"images"][@"intro"][@"versions"][@"3x"][@"source_url"];
        generalImage1x = cityDict[@"images"][@"overview"][@"versions"][@"1x"][@"source_url"];
        generalImage2x = cityDict[@"images"][@"overview"][@"versions"][@"2x"][@"source_url"];
        generalImage3x = cityDict[@"images"][@"overview"][@"versions"][@"3x"][@"source_url"];
        safetyImage1x = cityDict[@"images"][@"security"][@"versions"][@"1x"][@"source_url"];
        safetyImage2x = cityDict[@"images"][@"security"][@"versions"][@"2x"][@"source_url"];
        safetyImage3x = cityDict[@"images"][@"security"][@"versions"][@"3x"][@"source_url"];
    } else {
        cultureImage1x = @"";
        cultureImage2x = @"";
        cultureImage3x = @"";
        introImage1x = @"";
        introImage2x = @"";
        introImage3x = @"";
        generalImage1x = @"";
        generalImage2x = @"";
        generalImage3x = @"";
        safetyImage1x = @"";
        safetyImage2x = @"";
        safetyImage3x = @"";
    }

    clinicsURL= @"";
    alertsURL = @"";
    dollarRatio = 6.0;
    
    CityEntity *city = [[TripManager getInstance] createTripWithCultureText:cultureText
                                                         withCultureImage1x:cultureImage1x
                                                         withCultureImage2x:cultureImage2x
                                                         withCultureImage3x:cultureImage3x
                                                        withDestinationName:destinationName
                                                          withDestinationId:destinationId
                                                        withDestinationType:destinationType
                                                            withGeneralText:generalText
                                                         withGeneralImage1x:generalImage1x
                                                         withGeneralImage2x:generalImage2x
                                                         withGeneralImage3x:generalImage3x
                                                           withIntroImage1x:introImage1x
                                                           withIntroImage2x:introImage2x
                                                           withIntroImage3x:introImage3x
                                                          withSafetyImage1x:safetyImage1x
                                                          withSafetyImage2x:safetyImage2x
                                                          withSafetyImage3x:safetyImage3x
                                                             withSafetyText:safetyText
                                                             withClinicsURL:clinicsURL
                                                              withAlertsURL:alertsURL
                                                            withCADToNative:dollarRatio];
    
    [RequestBuilder fetchEmbassy:cityDict withCity:city];
    [RequestBuilder fetchCurrency:cityDict withCity:city];
    
    for (NSDictionary *medDict in cityDict[@"medications"]) {
        name = medDict[@"name"];
        category = @"medications";
        common = [medDict[@"common"] boolValue];
        
        NSDictionary *medContent = medDict[@"content"];
        desc = medContent[@"brand_names"];
        details = medContent[@"description"];
        symptoms = medContent[@"side_effects"];
        immunizations = medContent[@"storage"];
        important = medContent[@"notes"];
        
//        NSDictionary *medImage = medDict[@"images"];
        //for debugging purposes
        image = @"";
        
        [[TripManager getInstance] createHealthItemWithCity:city withCategory:category withName:name withCommon:common withDesc:desc withDetails:details withSymptoms:symptoms withImmunizations:immunizations withImportant:important withImage:image];
    }
    
    for (NSDictionary *healthDict in cityDict[@"health_conditions"]) {
        category = @"conditions";
        name = healthDict[@"name"];
        common = [healthDict[@"common"] boolValue];
        
        NSDictionary *healthContent = healthDict[@"content"];
        desc = healthContent[@"description"];
        details = @"";
        symptoms = healthContent[@"symptoms"];
        immunizations = healthContent[@"prevention"];
        //test to see if it works when there is no important field
        important = healthContent[@"important"];
        
//        NSDictionary *healthImage = healthDict[@"images"];
        //for debugging purposes
        image = @"";
        
        [[TripManager getInstance] createHealthItemWithCity:city withCategory:category withName:name withCommon:common withDesc:desc withDetails:details withSymptoms:symptoms withImmunizations:immunizations withImportant:important withImage:image];
    }
}

@end

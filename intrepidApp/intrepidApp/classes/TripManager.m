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

- (NSMutableArray *)getHealthItemsWithCity:(CityEntity *)city {
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"HealthEntity" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setPredicate:[NSPredicate predicateWithFormat:@"city == %@", city]];
    [request setEntity:entityDescription];
    
    NSError *error;
    NSArray *intermediateArray = [managedObjectContext executeFetchRequest:request error:&error];
    NSMutableArray *diseases = [NSMutableArray new];
    NSMutableArray *medication = [NSMutableArray new];
    
    for (HealthEntity *healthItem in intermediateArray) {
        if ([healthItem.category isEqualToString:@"medications"]) {
            [medication addObject:healthItem];
        } else {
            [diseases addObject:healthItem];
        }
    }
    
    NSMutableArray * healthArray = [NSMutableArray new];
    // hack for HealthViewController tables
    [healthArray addObject:[NSMutableArray new]];
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

- (NSMutableArray *)getPPNList {
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"PPNEntity" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];

    NSError *error;
    NSArray *intermediateArray = [managedObjectContext executeFetchRequest:request error:&error];
    NSMutableArray *ppn = [NSMutableArray new];

    for (PPNEntity *ppnItem in intermediateArray) {
        [ppn addObject:ppnItem];
    }
    
    return ppn;
    
}

- (NSMutableArray *)getAlertItemsWithCity:(CityEntity *)city {
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"AlertEntity" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setPredicate:[NSPredicate predicateWithFormat:@"city == %@", city]];
    [request setEntity:entityDescription];
    
    NSError *error;
    NSArray *intermediateArray = [managedObjectContext executeFetchRequest:request error:&error];
    NSMutableArray *alerts = [NSMutableArray new];
    
    for (AlertEntity *alertItem in intermediateArray) {
        [alerts addObject:alertItem];
    }
    
    return alerts;
}

- (CurrencyEntity *)getCurrencyItemWithCity:(CityEntity *)city {
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"CurrencyEntity" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setPredicate:[NSPredicate predicateWithFormat:@"city == %@", city]];
    [request setEntity:entityDescription];
    [request setFetchLimit:1];
    
    NSError *error;
    NSArray *intermediateArray = [managedObjectContext executeFetchRequest:request error:&error];
    CurrencyEntity *currency;
    if (intermediateArray.count > 0) {
        currency = intermediateArray[0];
    }
    
    return currency;
}

- (DestinationEntity *)getDestinationItemWithCurrencyCode:(NSString *)currencyCode {
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"DestinationEntity" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setPredicate:[NSPredicate predicateWithFormat:@"currencyCode == %@", currencyCode]];
    [request setEntity:entityDescription];
    [request setFetchLimit:1];
    
    NSError *error;
    NSArray *intermediateArray = [managedObjectContext executeFetchRequest:request error:&error];
    DestinationEntity *destination;
    if (intermediateArray.count > 0) {
        destination = intermediateArray[0];
    }
    return destination;
}

- (DestinationEntity *)getDestinationItemWithCountryName:(NSString *)countryName {
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"DestinationEntity" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setPredicate:[NSPredicate predicateWithFormat:@"name == %@", countryName]];
    [request setEntity:entityDescription];
    [request setFetchLimit:1];
    
    NSError *error;
    NSArray *intermediateArray = [managedObjectContext executeFetchRequest:request error:&error];
    DestinationEntity *destination;
    if (intermediateArray.count > 0) {
        destination = intermediateArray[0];
    }
    return destination;
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

- (void)deleteAlertItemsWithCity:(CityEntity *)city {
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"AlertEntity" inManagedObjectContext:managedObjectContext];
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
            withWebsite:(NSString *)website
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
    embassy.website = website;
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        NSLog(@"save failed");
    }
    return embassy;
}

- (CityEntity *)createTripWithLanguage:(NSString *)language
                          withReligion:(NSString *)religion
                      withethnicMakeup:(NSString *)ethnicMakeup
                     withCulturalNorms:(NSString *)culturalNorms
                    withCultureImage1x:(NSString *)cultureImage1x
                    withCultureImage2x:(NSString *)cultureImage2x
                    withCultureImage3x:(NSString *)cultureImage3x
                   withDestinationName:(NSString *)destinationName
                     withDestinationId:(NSInteger )destinationId
                   withDestinationType:(NSString *)destinationType
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
                            withSafety:(NSString *)safety
                     withOtherConcerns:(NSString *)otherConcerns
                     withSafetyImage1x:(NSString *)safetyImage1x
                     withSafetyImage2x:(NSString *)safetyImage2x
                     withSafetyImage3x:(NSString *)safetyImage3x
                       withCountryCode:(NSString *)countryCode
                      withCurrencyCode:(NSString *)currencyCode
                             withMoney:(NSString *)money
                    withTransportation:(NSString *)transportation
                          withHolidays:(NSString *)holidays
                 withHealthCareQuality:(NSString *)healthCareQuality
     withVaccinationsAndPreTripMedical:(NSString *)vaccinationsAndPreTripMedical
                  withHealthConditions:(NSString *)healthConditions
                    withMedicalImage1x:(NSString *)medicalImage1x
                    withMedicalImage2x:(NSString *)medicalImage2x
                    withMedicalImage3x:(NSString *)medicalImage3x
                  withEmergencyNumbers:(NSString *)emergencyNumbers
{
    CityEntity *city = [NSEntityDescription insertNewObjectForEntityForName:@"CityEntity" inManagedObjectContext:managedObjectContext];

    city.language = language;
    city.religion = religion;
    city.ethnicMakeup = ethnicMakeup;
    city.culturalNorms = culturalNorms;
    city.cultureImage1x = cultureImage1x;
    city.cultureImage2x = cultureImage2x;
    city.cultureImage3x = cultureImage3x;
    city.destinationName = destinationName;
    city.destinationId = [NSNumber numberWithInteger:destinationId];
    city.destinationType = destinationType;
    city.location = location;
    city.climate = climate;
    city.typeOfGovernment = typeOfGovernment;
    city.visaRequirements = visaRequirements;
    city.communicationInfrastructure = communicationInfrastructure;
    city.electricity = electricity;
    city.development = development;
    city.generalImage1x = generalImage1x;
    city.generalImage2x = generalImage2x;
    city.generalImage3x = generalImage3x;
    city.introImage1x = introImage1x;
    city.introImage2x = introImage2x;
    city.introImage3x = introImage3x;
    city.safety = safety;
    city.otherConcerns = otherConcerns;
    city.safetyImage1x = safetyImage1x;
    city.safetyImage2x = safetyImage2x;
    city.safetyImage3x = safetyImage3x;
    city.countryCode = countryCode;
    city.currencyCode = currencyCode;
    city.money = money;
    city.transportation = transportation;
    city.holidays = holidays;
    city.healthCareQuality = healthCareQuality;
    city.vaccinationsAndPreTripMedical = vaccinationsAndPreTripMedical;
    city.healthConditions = healthConditions;
    city.medicalImage1x = medicalImage1x;
    city.medicalImage2x = medicalImage2x;
    city.medicalImage3x = medicalImage3x;
    city.emergencyNumbers = emergencyNumbers;
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        NSLog(@"save failed");
    }
    
    return city;
}

- (DestinationEntity *)createDestinationWithName:(NSString *)name
                               withDestinationId:(NSInteger )destinationId
                                        withType:(NSString *)type
                                 withFlagImage1x:(NSString *)flagImage1x
                                 withFlagImage2x:(NSString *)flagImage2x
                                 withFlagImage3x:(NSString *)flagImage3x
                             withCurrencyImage1x:(NSString *)currencyImage1x
                             withCurrencyImage2x:(NSString *)currencyImage2x
                             withCurrencyImage3x:(NSString *)currencyImage3x
                                withCurrencyCode:(NSString *)currencyCode
{
    DestinationEntity *destination = [NSEntityDescription insertNewObjectForEntityForName:@"DestinationEntity" inManagedObjectContext:managedObjectContext];
    
    destination.name = name;
    destination.destinationId = [NSNumber numberWithInteger:destinationId];
    destination.type = type;
    destination.flagImage1x = flagImage1x;
    destination.flagImage2x = flagImage2x;
    destination.flagImage3x = flagImage3x;
    destination.currencyImage1x = currencyImage1x;
    destination.currencyImage2x = currencyImage2x;
    destination.currencyImage3x = currencyImage3x;
    destination.currencyCode = currencyCode;
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        NSLog(@"save failed");
    }
    
    return destination;
}

- (PPNEntity *)createPPNWithId:(NSString *)id withName:(NSString *)name withType:(NSString *)type withContent:(NSString *)content withLongitude:(NSString *)longitude withLatitude:(NSString *)latitude withPostal:(NSString *)postal withAddress:(NSString *)address withContact:(NSString *)contact withStaffName:(NSString *)staffname
{
    if (longitude == [NSNull null])
        longitude = @"";
    
    if(latitude == [NSNull null])
        latitude = @"";
    
    PPNEntity *ppn = [NSEntityDescription insertNewObjectForEntityForName:@"PPNEntity" inManagedObjectContext:managedObjectContext];
    ppn.id = id;
    ppn.name = name;
    ppn.type = type;
    ppn.content = content;
    ppn.longitude = longitude;
    ppn.latitude = latitude;
    ppn.postal = postal;
    ppn.address = address;
    ppn.contact = contact;
    ppn.staffName = staffname;
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        NSLog(@"save failed");
    }
    
    return ppn;
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
                               withImage1x:(NSString *)image1x
                               withImage2x:(NSString *)image2x
                               withImage3x:(NSString *)image3x
{
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
    health.image1x = image1x;
    health.image2x = image2x;
    health.image3x = image3x;
    
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

- (AlertEntity *)createAlertItemWithCity:(CityEntity *)city
                            withCategory:(NSString *)category
                                withLink:(NSString *)link
                                withText:(NSString *)text
                           withStartDate:(NSDate *)startDate
                             withEndDate:(NSDate *)endDate {
    AlertEntity *alert = [NSEntityDescription insertNewObjectForEntityForName:@"AlertEntity" inManagedObjectContext:managedObjectContext];
    
    alert.city = city;
    alert.category = category;
    alert.link = link;
    alert.text = text;
    alert.startDate = startDate;
    alert.endDate = endDate;
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        NSLog(@"save failed");
    }
    
    return alert;
}

- (void)saveCity:(NSDictionary *)cityDict {
    NSString *location, *climate, *typeOfGovernment, *visaRequirements, *communicationInfrastructure, *electricity, *development, *money, *transportation, *holidays;
    NSString *language, *religion, *ethnicMakeup, *culturalNorms;
    NSString *safety, *otherConcerns, *emergencyNumbers;
    NSString *healthCareQuality, *vaccinationsAndPreTripMedical, *healthConditions;
    NSString *cultureImage1x, *cultureImage2x, *cultureImage3x, *introImage1x, *introImage2x, *introImage3x, *generalImage1x, *generalImage2x, *generalImage3x, *safetyImage1x, *safetyImage2x, *safetyImage3x, *medicalImage1x, *medicalImage2x, *medicalImage3x;
    NSString *destinationName, *destinationType, *countryCode, *currencyCode;
    NSInteger destinationId;
    
    NSString *name, *category, *desc, *details, *symptoms, *immunizations, *important, *image1x, *image2x, *image3x;
    Boolean common;
    
    destinationName = cityDict[@"name"];
    destinationId = [cityDict[@"id"] integerValue];
    destinationType = cityDict[@"type"];
    countryCode = cityDict[@"country"][@"country_code"];
    currencyCode = cityDict[@"country"][@"currency_code"];
    
    NSDictionary *contentDict = cityDict[@"content"];
    
    //General Description Subtext
    location = contentDict[@"location"];
    climate = contentDict[@"climate"];
    typeOfGovernment = contentDict[@"type_of_government"];
    visaRequirements = contentDict[@"visa_requirements"];
    communicationInfrastructure = contentDict[@"communication_infrastructure"];
    electricity = contentDict[@"electricity"];
    development = contentDict[@"development"];
    money = contentDict[@"currency"];
    transportation = contentDict[@"transportation"];
    holidays = contentDict[@"holidays"];
    
    //Culture Description Subtext
    language = contentDict[@"language"];
    religion = contentDict[@"religion"];
    ethnicMakeup = contentDict[@"ethnic_makeup"];
    culturalNorms = contentDict[@"cultural_norms"];
    
    //Safety Description Subtext
    safety = contentDict[@"safety"];
    otherConcerns = contentDict[@"other_concerns"];
    emergencyNumbers = contentDict[@"emergency_numbers"];
    
    //Medical Description Subtext
    healthCareQuality = contentDict[@"health_care_quality"];
    vaccinationsAndPreTripMedical = contentDict[@"vaccinations_and_pre_trip_medical"];
    healthConditions = contentDict[@"health_conditions"];
    
    if (cityDict[@"images"] != [NSNull null] && ![cityDict[@"images"] isEqual:@""]) {
        if (cityDict[@"images"][@"culture"] != [NSNull null] && ![cityDict[@"images"][@"culture"] isEqual:@""]) {
            cultureImage1x = [cityDict[@"images"][@"culture"][@"versions"][@"1x"][@"source_url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            cultureImage2x = [cityDict[@"images"][@"culture"][@"versions"][@"2x"][@"source_url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            cultureImage3x = [cityDict[@"images"][@"culture"][@"versions"][@"3x"][@"source_url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        } else {
            cultureImage1x = @"";
            cultureImage2x = @"";
            cultureImage3x = @"";
        }
        
        if (cityDict[@"images"][@"intro"] != [NSNull null] && ![cityDict[@"images"][@"intro"] isEqual:@""]) {
            introImage1x = [cityDict[@"images"][@"intro"][@"versions"][@"1x"][@"source_url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            introImage2x = [cityDict[@"images"][@"intro"][@"versions"][@"2x"][@"source_url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            introImage3x = [cityDict[@"images"][@"intro"][@"versions"][@"3x"][@"source_url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        } else {
            introImage1x = @"";
            introImage2x = @"";
            introImage3x = @"";
        }
        
        if (cityDict[@"images"][@"overview"] != [NSNull null] && ![cityDict[@"images"][@"overview"] isEqual:@""]) {
            generalImage1x = [cityDict[@"images"][@"overview"][@"versions"][@"1x"][@"source_url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            generalImage2x = [cityDict[@"images"][@"overview"][@"versions"][@"2x"][@"source_url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            generalImage3x = [cityDict[@"images"][@"overview"][@"versions"][@"3x"][@"source_url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        } else {
            generalImage1x = @"";
            generalImage2x = @"";
            generalImage3x = @"";
        }
        
        if (cityDict[@"images"][@"security"] != [NSNull null] && ![cityDict[@"images"][@"security"] isEqual:@""]) {
            safetyImage1x = [cityDict[@"images"][@"security"][@"versions"][@"1x"][@"source_url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            safetyImage2x = [cityDict[@"images"][@"security"][@"versions"][@"2x"][@"source_url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            safetyImage3x = [cityDict[@"images"][@"security"][@"versions"][@"3x"][@"source_url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        } else {
            safetyImage1x = @"";
            safetyImage2x = @"";
            safetyImage3x = @"";
        }
        
        if (cityDict[@"images"][@"medical"] != [NSNull null] && ![cityDict[@"images"][@"medical"] isEqual:@""]) {
            medicalImage1x = [cityDict[@"images"][@"medical"][@"versions"][@"1x"][@"source_url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            medicalImage2x = [cityDict[@"images"][@"medical"][@"versions"][@"2x"][@"source_url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            medicalImage3x = [cityDict[@"images"][@"medical"][@"versions"][@"3x"][@"source_url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        } else {
            medicalImage1x = @"";
            medicalImage2x = @"";
            medicalImage3x = @"";
        }
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
        medicalImage1x = @"";
        medicalImage2x = @"";
        medicalImage3x = @"";
    }
    
    CityEntity *city = [[TripManager getInstance] createTripWithLanguage:language
                                                           withReligion:religion
                                                       withethnicMakeup:ethnicMakeup
                                                      withCulturalNorms:culturalNorms
                                                     withCultureImage1x:cultureImage1x
                                                     withCultureImage2x:cultureImage2x
                                                     withCultureImage3x:cultureImage3x
                                                    withDestinationName:destinationName
                                                      withDestinationId:destinationId
                                                    withDestinationType:destinationType
                                                           withLocation:location
                                                            withClimate:climate
                                                   withTypeOfGovernment:typeOfGovernment
                                                   withVisaRequirements:visaRequirements
                                        withCommunicationInfrastructure:communicationInfrastructure
                                                        withElectricity:electricity
                                                        withDevelopment:development
                                                     withGeneralImage1x:generalImage1x
                                                     withGeneralImage2x:generalImage2x
                                                     withGeneralImage3x:generalImage3x
                                                       withIntroImage1x:introImage1x
                                                       withIntroImage2x:introImage2x
                                                       withIntroImage3x:introImage3x
                                                             withSafety:safety
                                                      withOtherConcerns:otherConcerns
                                                      withSafetyImage1x:safetyImage1x
                                                      withSafetyImage2x:safetyImage2x
                                                      withSafetyImage3x:safetyImage3x
                                                         withCountryCode:countryCode
                                                        withCurrencyCode:currencyCode
                                                               withMoney:money
                                                      withTransportation:transportation
                                                            withHolidays:holidays
                                                   withHealthCareQuality:healthCareQuality
                                       withVaccinationsAndPreTripMedical:vaccinationsAndPreTripMedical
                                                    withHealthConditions:healthConditions
                                                      withMedicalImage1x:medicalImage1x
                                                      withMedicalImage2x:medicalImage2x
                                                      withMedicalImage3x:medicalImage3x
                                                    withEmergencyNumbers:emergencyNumbers];
    
    [RequestBuilder fetchEmbassy:cityDict withCity:city];
    [RequestBuilder fetchAlert:cityDict withCity:city];    
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
        
        if (medDict[@"images"] != [NSNull null] && ![medDict[@"images"] isEqual:@""]) {
            if (medDict[@"images"][@"general"] != [NSNull null] && ![medDict[@"images"][@"general"] isEqual:@""]) {
                image1x = [medDict[@"images"][@"general"][@"versions"][@"1x"][@"source_url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                image2x = [medDict[@"images"][@"general"][@"versions"][@"2x"][@"source_url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                image3x = [medDict[@"images"][@"general"][@"versions"][@"3x"][@"source_url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            } else {
                image1x = @"";
                image2x = @"";
                image3x = @"";
            }
        } else {
            image1x = @"";
            image2x = @"";
            image3x = @"";
        }
        
        [[TripManager getInstance] createHealthItemWithCity:city withCategory:category withName:name withCommon:common withDesc:desc withDetails:details withSymptoms:symptoms withImmunizations:immunizations withImportant:important withImage1x:image1x withImage2x:image2x withImage3x:image3x];
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
        
        if (healthDict[@"images"] != [NSNull null] && ![healthDict[@"images"] isEqual:@""]) {
            if (healthDict[@"images"][@"general"] != [NSNull null] && ![healthDict[@"images"][@"general"] isEqual:@""]) {
                image1x = [healthDict[@"images"][@"general"][@"versions"][@"1x"][@"source_url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                image2x = [healthDict[@"images"][@"general"][@"versions"][@"2x"][@"source_url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                image3x = [healthDict[@"images"][@"general"][@"versions"][@"3x"][@"source_url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            } else {
                image1x = @"";
                image2x = @"";
                image3x = @"";
            }
        } else {
            image1x = @"";
            image2x = @"";
            image3x = @"";
        }
        
        [[TripManager getInstance] createHealthItemWithCity:city withCategory:category withName:name withCommon:common withDesc:desc withDetails:details withSymptoms:symptoms withImmunizations:immunizations withImportant:important withImage1x:image1x withImage2x:image2x withImage3x:image3x];
    }
}

@end

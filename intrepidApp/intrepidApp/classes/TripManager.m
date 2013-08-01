//
//  TripManager.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/31/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "TripManager.h"
#import "CityEntity.h"

@implementation TripManager

@synthesize managedObjectContext;
//@synthesize persistentStoreCoordinator;

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
        [self populateTrips];
        cityArray = [self fetchCityArray];
    }
    NSLog(@"city Array count: %i", cityArray.count);
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

-(void) populateTrips {
    NSLog(@"POP TRIPS IS CALLED");
    // mexico
    [self createTripWithCityImage:@"NMexico.png" withCityName:@"Mexico" withContinent:@"South America" withCultureText:@"culture so good" withCultureImage:@"NMexico.png" withGeneralText:@"general description" withGeneralImage:@"NMexico.png" withLocalImage:@"NMexico.png" withLocalText:@"Local Mexicooo" withPoliticalImage:@"NMexico.png" withPoliticaltext:@"politics r fun"];
    
    // other trips!
}

-(void) createTripWithCityImage:(NSString *)cityImage
withCityName:(NSString *)cityName
withContinent:(NSString *)continent
withCultureText:(NSString *)cultureText
withCultureImage:(NSString *)cultureImage
withGeneralText:(NSString *)generalText
withGeneralImage:(NSString *)generalImage
withLocalImage:(NSString *)localImage
withLocalText:(NSString *)localText
withPoliticalImage:(NSString *)politicalImage
withPoliticaltext:(NSString *)politicalText
{
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CityEntity" inManagedObjectContext:managedObjectContext];
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
    city.politicalImage = politicalImage;
    city.politicalText = politicalText;
//    city.embassyItems;
//    dispatch_async(dispatch_get_main_queue(), ^{
        NSError *error = nil;
        if ([managedObjectContext save:&error]) {
            NSLog(@"saved");
        } else {
            NSLog(@"save failed");
        }
//    });

    
}

@end

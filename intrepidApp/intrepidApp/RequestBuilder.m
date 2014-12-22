//
//  RequestBuilder.m
//  intrepidApp
//
//  Created by Philip on 2014-12-04.
//  Copyright (c) 2014 JonCarrHarris Consulting. All rights reserved.
//

#import "RequestBuilder.h"
#import "TripManager.h"
#import "CityEntity.h"

@implementation RequestBuilder
static NSString * token = @"UIcodif8e0";
static NSString * baseURL = @"https://staging.intrepid247.com/v1/";


+ (void)buildRequestWithURL:(NSString *)url {
    url = @"destinations"; // temp
    
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@destinations?token=%@", baseURL, token]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestURL];
    request.HTTPMethod = @"GET";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error) {
            NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            [[TripManager getInstance] deleteAllObjects:@"CityEntity"];
            [[TripManager getInstance] deleteAllObjects:@"HealthEntity"];
            
            for (NSDictionary *cityDict in responseObject[@"destinations"]) {
                
                //CityEntity
                NSString *cityName, *cityImage, *continent, *cultureText, *cultureImage;
                NSString *generalText, *generalImage, *localText, *localImage;
                NSString *safetyImage, *safetyText, *clinicsURL, *weatherURL, *alertsURL;
                float dollarRatio;
                
                //EmbassyEntity
                NSString *phone, *fax, *email, *hours, *notes, *services, *address, *country, *flag;
                
                NSString *name, *category, *desc, *details, *symptoms, *immunizations, *important, *image;
                Boolean common;
                
                cityName = cityDict[@"name"];
                
                NSDictionary *contentDict = cityDict[@"content"];
                
                generalText = contentDict[@"general_description"];
                cultureText = contentDict[@"culture_description"];
                localText = @"";
                safetyText = contentDict[@"security_description"];
                
                
                NSDictionary *imageDict = cityDict[@"images"];
                generalImage = @"";
                localImage = imageDict[@"other_image"];
                cultureImage = imageDict[@"culture_image"];
                safetyImage = imageDict[@"safety_image"];
                
                
                cityImage = @"";
                continent = @"";
                clinicsURL= @"";
                weatherURL = @"";
                alertsURL = @"";
                dollarRatio = 6.0;
                
                CityEntity *city = [[TripManager getInstance] createTripWithCityImage:cityImage withCityName:cityName withContinent:continent withCultureText:cultureText withCultureImage:cultureImage withGeneralText:generalText withGeneralImage:generalImage withLocalImage:localImage withLocalText:localText withSafetyImage:safetyImage withSafetytext:safetyText withClinicsURL:clinicsURL withAlertsURL:alertsURL withWeatherURL:weatherURL withCADToNative:dollarRatio];
                
                for (NSDictionary *embassyDict in cityDict[@"diplomatic_offices"]) {
                    country = embassyDict[@"name"];
                    
                    NSDictionary *embassyContent = embassyDict[@"content"];
                    if (![embassyContent count] == 0) {
                        phone = embassyContent[@"telephone"];
                        fax = embassyContent[@"fax"];
                        email = embassyContent[@"email"];
                        hours = embassyContent[@"hours_of_operation"];
                        address = embassyContent[@"address"];
                        notes = embassyContent[@"notes"];
                        services = embassyContent[@"services_offered"];
                    }
                    flag = @"";
                    [[TripManager getInstance] createEmbassyWithCity:city withPhone:phone withFax:fax withEmail:email withHours:hours withNotes:notes withServices:services withAddress:address withCountry:country withFlag:flag];
                }
                
                for (NSDictionary *medDict in cityDict[@"medications"]) {
                    name = medDict[@"name"];
                    category = @"medications";
                    common = [medDict[@"common"] boolValue];
                    
                    NSDictionary *medContent = medDict[@"content"];
                    desc = medContent[@"general_description"];
                    details = medContent[@"details"];
                    symptoms = medContent[@"symptoms"];
                    immunizations = medContent[@"immunization"];
                    important = @"this is a test to see if the box works, I am writing a lot to test this, my favourite colour is blue and my favourite day of the week is friday";
                    
                    NSDictionary *medImage = medDict[@"images"];
                    //for debugging purposes
                    image = medImage[@"other_image"];
                    
                    [[TripManager getInstance] createHealthItemWithCity:city withCategory:category withName:name withCommon:common withDesc:desc withDetails:details withSymptoms:symptoms withImmunizations:immunizations withImportant:important withImage:image];
                }
                
                for (NSDictionary *healthDict in cityDict[@"health_conditions"]) {
                    category = @"conditions";
                    name = healthDict[@"name"];
                    common = [healthDict[@"common"] boolValue];
                    
                    NSDictionary *healthContent = healthDict[@"content"];
                    desc = healthContent[@"general_description"];
                    details = @"";
                    symptoms = healthContent[@"symptom_description"];
                    immunizations = healthContent[@"prevention_description"];
                    //test to see if it works when there is no important field
                    important = @"";
                    
                    NSDictionary *healthImage = healthDict[@"images"];
                    //for debugging purposes
                    image = healthImage[@"other_image"];
                    
                    [[TripManager getInstance] createHealthItemWithCity:city withCategory:category withName:name withCommon:common withDesc:desc withDetails:details withSymptoms:symptoms withImmunizations:immunizations withImportant:important withImage:image];
                }
                
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TRIP_UPDATE" object:nil];
        } else {
            NSLog(@"error: %@", error.localizedDescription);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TRIP_UPDATE" object:nil];
        }
    }];
}

@end

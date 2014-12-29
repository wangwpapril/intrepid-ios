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
static NSString * currencyURL = @"http://api.fixer.io/latest?base=CAD";


+ (void)buildRequestWithURL:(NSString *)url {
    
    if ([url isEqual:@"currency"]) {
        NSURL *requestURL = [NSURL URLWithString:currencyURL];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestURL];
        request.HTTPMethod = @"GET";
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            if (!error) {
                NSDictionary *currencyObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                [[TripManager getInstance] deleteAllObjects:@"CurrencyEntity"];
                
                NSDictionary *currencyDict = currencyObject[@"rates"];
                for (NSString *country in currencyDict) {

                    NSString *value = [[currencyDict objectForKey:country] stringValue];
                    [[TripManager getInstance] createCurrencyItemWithCountry:country withValue:value];
                }
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"TRIP_UPDATE" object:nil];
            } else
                {
                NSLog(@"error: %@", error.localizedDescription);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"TRIP_UPDATE" object:nil];
            }
        }];
    }
    else {
        url = @"destinations"; // temp
        
        NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@destinations?token=%@", baseURL, token]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestURL];
        request.HTTPMethod = @"GET";
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            if (!error) {
                NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//                [[TripManager getInstance] deleteAllObjects:@"CityEntity"];
                [[TripManager getInstance] deleteAllObjects:@"HealthEntity"];
                
                bool found;
                NSArray *savedCities = [[TripManager getInstance] getSavedCities];
                [TripManager getInstance].unsavedCities = [NSMutableArray new];

                // update existing entries
                for (NSDictionary *cityDict in responseObject[@"destinations"]) {
                    found = false;
                    for (CityEntity *city in savedCities) {
                        if ([city.cityName isEqualToString:cityDict[@"name"]]) {
                            
                            # warning move this functionality to TripManager
                            [[TripManager getInstance].managedObjectContext deleteObject:city]; // delete object
                            [[TripManager getInstance] saveCity:cityDict]; // replace it
                            found = true;
                        }
                    }
                    
                    // add a city to all cities
                    if (!found) {
                        [[TripManager getInstance] addCityDict:cityDict];
                    }
                    
                }
            } else {
                NSLog(@"error: %@", error.localizedDescription);
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TRIP_UPDATE" object:nil];

        }];
    }
}

@end

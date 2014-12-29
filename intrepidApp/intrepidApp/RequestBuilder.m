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
static NSString * currencyURL = @"http://api.fixer.io/latest?base=";


+ (void)buildRequestWithURL:(NSString *)url {
    
        url = @"destinations"; // temp
        
        NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@destinations?token=%@", baseURL, token]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestURL];
        request.HTTPMethod = @"GET";
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            if (!error) {
                NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
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
                    
                    [self fetchCurrency:cityDict];
                }
            } else {
                NSLog(@"error: %@", error.localizedDescription);
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TRIP_UPDATE" object:nil];
            
        }];
}

+ (void)fetchCurrency:(NSDictionary *)cityDict {
    NSLog(@"fetch currency called");
    
    NSDictionary *currencyDict = cityDict[@"country"];
    
    //this is currently to demonstrate, remove once testing completed
    NSString *currencyCode = @"EUR"; //currencyDict[@"currency_code"];
    
    NSURL *currencyRequestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",currencyURL, @"CAD"]];
    NSMutableURLRequest *currencyRequest = [[NSMutableURLRequest alloc] initWithURL:currencyRequestURL];
    
    [NSURLConnection sendAsynchronousRequest:currencyRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error) {
            NSDictionary *currencyObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            [[TripManager getInstance] deleteAllObjects:@"CurrencyEntity"];
            NSDictionary *currencyDict = currencyObject[@"rates"];
            for (NSString *country in currencyDict) {
                NSString *value;
                float valueConv;
                if ([country isEqualToString:currencyCode]) {
                    value = [[currencyDict objectForKey:country] stringValue];
                    NSString *slicedValue = [value substringToIndex:4];
                    [[TripManager getInstance] createCurrencyItemWithCountry:country withValue:slicedValue];
                    
                    valueConv = [value floatValue];
                    float cityToCad = (1/valueConv);
                    
                    NSString *cityToCadStr = [NSString stringWithFormat:@"%.2f", cityToCad];
                    [[TripManager getInstance] createCurrencyItemWithCountry:@"CAD" withValue:cityToCadStr];
                }
            }
        } else {
            NSLog(@"got an error: %@", error);
        }
    }];
}

@end

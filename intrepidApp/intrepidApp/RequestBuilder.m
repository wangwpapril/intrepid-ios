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
#import "DestinationEntity.h"

@implementation RequestBuilder
static NSString * token = @"UIcodif8e0";
static NSString * baseURL = @"https://staging.intrepid247.com/v1/";
static NSString * currencyURL = @"http://api.fixer.io/latest?base=";
static NSString * embassyURL = @" https://staging.intrepid247.com/v1/diplomatic-offices/";
static NSDictionary * userDict;
static NSDictionary * cityDict;

+ (void)fetchUser:(NSDictionary *)user {
    userDict = user;
}

+ (void)fetchDestinations {
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@destinations?short_list=true&token=%@", baseURL, userDict[@"user"][@"token"]]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestURL];
    request.HTTPMethod = @"GET";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error) {
            NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            [[TripManager getInstance] deleteAllObjects:@"DestinationEntity"];
            for (NSDictionary *destinationDict in responseObject[@"destinations"]) {
                [[TripManager getInstance] createDestinationWithName:destinationDict[@"name"] withDestinationId:[destinationDict[@"id"] integerValue] withType:destinationDict[@"type"]];
            }
        } else {
            NSLog(@"error: %@", error.localizedDescription);
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DESTINATION_UPDATE" object:nil];
    }];
}

+ (void)buildRequestWithURL:(NSString *)url {
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@destinations/%@?token=%@", baseURL, url, userDict[@"user"][@"token"]]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestURL];
    request.HTTPMethod = @"GET";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error) {
            NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"got %@: %@", responseObject[@"destination"][@"id"], responseObject[@"destination"][@"name"]);
            NSArray *savedCities = [[TripManager getInstance] getSavedCities];

            // update existing entries
            CityEntity *city;
            cityDict = responseObject[@"destination"];
            
            for (city in savedCities) {
                if ([city.destinationId isEqualToNumber:cityDict[@"id"]]) {
                    [[TripManager getInstance] deleteHealthItemsWithCity:city];
                    [[TripManager getInstance] deleteEmbassyItemsWithCity:city];
                    [[TripManager getInstance].managedObjectContext deleteObject:city]; // delete object
                }
            }
            
            [[TripManager getInstance] saveCity:cityDict]; // replace it
            [self fetchCurrency:cityDict];
        } else {
            NSLog(@"error: %@", error.localizedDescription);
            NSLog(@"request trip update");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TRIP_UPDATE" object:nil];
        }
    }];
}

+ (void)fetchEmbassy:(NSDictionary *)cityDict withCity:(CityEntity *)city {
    NSURL *embassyRequestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@diplomatic-offices/%@?origin_country=%@&token=%@", baseURL, cityDict[@"country"][@"country_code"], userDict[@"user"][@"country_code"], userDict[@"user"][@"token"]]];
    NSMutableURLRequest *currencyRequest = [[NSMutableURLRequest alloc] initWithURL:embassyRequestURL];
    currencyRequest.HTTPMethod = @"GET";
    [currencyRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:currencyRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error) {
            //EmbassyEntity
            NSDictionary *embassyObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            NSString *phone, *fax, *email, *hours, *notes, *services, *address, *country, *flag;
            
            for (NSDictionary *embassy in embassyObject[@"diplomatic_office"]) {
                country = embassy[@"name"];
                NSDictionary *embassyContent = embassy[@"content"];
                
                phone = embassyContent[@"telephone"];
                fax = embassyContent[@"fax"];
                email = embassyContent[@"email"];
                hours = embassyContent[@"hours_of_operation"];
                address = embassyContent[@"address"];
                notes = embassyContent[@"notes"];
                services = embassyContent[@"services_offered"];
                
                flag = @"";
                [[TripManager getInstance] createEmbassyWithCity:city withPhone:phone withFax:fax withEmail:email withHours:hours withNotes:notes withServices:services withAddress:address withCountry:country withFlag:flag];
            }
        } else {
            NSLog(@"error: %@", error.localizedDescription);
        }
        NSLog(@"embassy trip update");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TRIP_UPDATE" object:nil];
    }];
}

+ (void)fetchCurrency:(NSDictionary *)cityDict {
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

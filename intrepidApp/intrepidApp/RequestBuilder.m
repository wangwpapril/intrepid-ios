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
static NSString * baseURL = @"https://staging.intrepid247.com/v1/";
static NSString * currencyURL = @"https://openexchangerates.org/api/latest.json?app_id=14073d8e6b8c4687951ed926cbbd3589";
static NSDictionary * userDict;
static NSDictionary * cityDict;

+ (void)fetchUser:(NSDictionary *)user {
    userDict = user;
    [[TripManager getInstance] addUserDict:user];
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
                
                NSString *image1x, *image2x, *image3x;
                
                if (destinationDict[@"flag"] != [NSNull null]) {
                    image1x = destinationDict[@"flag"][@"versions"][@"1x"][@"source_url"];
                    image2x = destinationDict[@"flag"][@"versions"][@"2x"][@"source_url"];
                    image3x = destinationDict[@"flag"][@"versions"][@"3x"][@"source_url"];
                } else {
                    image1x = @"";
                    image2x = @"";
                    image3x = @"";
                }
                
                [[TripManager getInstance] createDestinationWithName:destinationDict[@"name"] withDestinationId:[destinationDict[@"id"] integerValue] withType:destinationDict[@"type"] withImage1x:image1x withImage2x:image2x withImage3x:image3x];
            }
        } else {
            NSLog(@"error: %@", error.localizedDescription);
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DESTINATION_UPDATE" object:nil];
    }];
}

+ (void)fetchTrip:(NSString *)trip {
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@destinations/%@?token=%@", baseURL, trip, userDict[@"user"][@"token"]]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestURL];
    request.HTTPMethod = @"GET";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error) {
            NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *savedCities = [[TripManager getInstance] getSavedCities];

            // update existing entries
            CityEntity *city;
            cityDict = responseObject[@"destination"];
            
            for (city in savedCities) {
                if ([city.destinationId isEqualToNumber:cityDict[@"id"]]) {
                    [[TripManager getInstance] deleteHealthItemsWithCity:city];
                    [[TripManager getInstance] deleteEmbassyItemsWithCity:city];
                    [[TripManager getInstance] deleteCurrencyItemsWithCity:city];
                    [[TripManager getInstance] deleteAlertItemsWithCity:city];
                    [[TripManager getInstance].managedObjectContext deleteObject:city]; // delete object
                }
            }
            
            [[TripManager getInstance] saveCity:cityDict]; // replace it
        } else {
            NSLog(@"error: %@", error.localizedDescription);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TRIP_UPDATE" object:nil];
        }
    }];
}

+ (void)fetchEmbassy:(NSDictionary *)cityDict withCity:(CityEntity *)city {
    NSURL *embassyRequestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@diplomatic-offices/%@?origin_country=%@&token=%@", baseURL, cityDict[@"country"][@"country_code"], userDict[@"user"][@"country_code"], userDict[@"user"][@"token"]]];
    NSMutableURLRequest *embassyRequest = [[NSMutableURLRequest alloc] initWithURL:embassyRequestURL];
    embassyRequest.HTTPMethod = @"GET";
    [embassyRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:embassyRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error) {
            NSDictionary *embassyObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            NSString *phone, *fax, *email, *hours, *notes, *services, *address, *country, *flag;
            NSString *image1x, *image2x, *image3x;
            
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

                if (embassy[@"images"] != [NSNull null]) {
                    image1x = embassy[@"images"][@"embassy"][@"versions"][@"1x"][@"source_url"];
                    image2x = embassy[@"images"][@"embassy"][@"versions"][@"2x"][@"source_url"];
                    image3x = embassy[@"images"][@"embassy"][@"versions"][@"3x"][@"source_url"];
                } else {
                    image1x = @"";
                    image2x = @"";
                    image3x = @"";
                }
                
                flag = @"";
                [[TripManager getInstance] createEmbassyWithCity:city withPhone:phone withFax:fax withEmail:email withHours:hours withNotes:notes withServices:services withAddress:address withCountry:country withFlag:flag withImage1x:image1x withImage2x:image2x withImage3x:image3x];
            }
        } else {
            NSLog(@"error: %@", error.localizedDescription);
        }
    }];
}

+ (void)fetchCurrency:(NSDictionary *)cityDict withCity:(CityEntity *)city {
    NSString *currencyCode = cityDict[@"country"][@"currency_code"];
    NSURL *currencyRequestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@&base=%@&symbols=%@", currencyURL, userDict[@"user"][@"currency_code"], currencyCode]];
    NSMutableURLRequest *currencyRequest = [[NSMutableURLRequest alloc] initWithURL:currencyRequestURL];
    
    [NSURLConnection sendAsynchronousRequest:currencyRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error) {
            NSDictionary *currencyObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            for (NSString *country in currencyObject[@"rates"]) {
                if ([country isEqualToString:currencyCode]) {
                    float value = [currencyObject[@"rates"][country] floatValue];
                    NSString *slicedValue = [NSString stringWithFormat:@"%.2f", value];
                    [[TripManager getInstance] createCurrencyItemWithCity:city Country:country withValue:slicedValue];
                    
                    float inverseValue = (1/value);
                    NSString *inverseSlicedValue = [NSString stringWithFormat:@"%.2f", inverseValue];
                    [[TripManager getInstance] createCurrencyItemWithCity:city Country:userDict[@"user"][@"currency_code"] withValue:inverseSlicedValue];
                }
            }
        } else {
            NSLog(@"got an error: %@", error);
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TRIP_UPDATE" object:nil];
    }];
}

+ (void)fetchAlert:(NSDictionary *)cityDict withCity:(CityEntity *)city {
    NSURL *alertRequestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@alerts/%@?token=%@", baseURL, cityDict[@"country"][@"country_code"], userDict[@"user"][@"token"]]];
    NSMutableURLRequest *alertRequest = [[NSMutableURLRequest alloc] initWithURL:alertRequestURL];
    alertRequest.HTTPMethod = @"GET";
    [alertRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:alertRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error) {
            NSDictionary *alertObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            NSString *category, *link, *text;
            NSDate *startDate, *endDate;
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MM/dd/yyyy"];
            
            for (NSDictionary *alert in alertObject[@"content"]) {
                category = alert[@"category"];
                link = alert[@"link"];
                text = alert[@"description"];
                startDate = [formatter dateFromString:alert[@"start"]];
                endDate = [formatter dateFromString:alert[@"end"]];

                [[TripManager getInstance] createAlertItemWithCity:city withCategory:category withLink:link withText:text withStartDate:startDate withEndDate:endDate];
            }
        } else {
            NSLog(@"error: %@", error.localizedDescription);
        }
    }];
}

@end

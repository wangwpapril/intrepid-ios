//
//  RequestBuilder.m
//  intrepidApp
//
//  Created by Philip on 2014-12-04.
//  Copyright (c) 2014 JonCarrHarris Consulting. All rights reserved.
//

#import "RequestBuilder.h"
#import <AFNetworking.h>
#import "TripManager.h"
#import "CityEntity.h"

@implementation RequestBuilder
static NSString * token = @"UIcodif8e0";
static NSString * baseURL = @"https://staging.intrepid247.com/v1/";


+ (void)buildRequestWithURL:(NSString *)url {
    
    url = @"destinations"; // temp
    
    NSString *requestURL = [NSString stringWithFormat:@"%@destinations?token=%@", baseURL, token];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:requestURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[TripManager getInstance] deleteAllObjects:@"CityEntity"];
        
        for (NSDictionary *cityDict in responseObject[@"destinations"]) {
            //CityEntity
            NSString *cityName, *cityImage, *continent, *cultureText, *cultureImage;
            NSString *generalText, *generalImage, *localText, *localImage;
            NSString *safetyImage, *safetyText, *clinicsURL, *weatherURL, *alertsURL;
            float dollarRatio;
            
            //EmbassyEntity
            NSString *phone, *fax, *email, *hours, *notes, *services, *address, *country, *flag;
            
            cityName = cityDict[@"name"];
            NSLog(@"city name: %@", cityName);
            
            NSDictionary *contentDict = cityDict[@"content"];
            
                NSLog(@"content dict: %@", contentDict);
                generalText = contentDict[@"general_description"];
                cultureText = contentDict[@"culture_description"];
                localText = @"local text";
                safetyText = contentDict[@"security_description"];
            
            
            NSDictionary *imageDict = cityDict[@"images"];
                NSLog(@"image dict: %@", imageDict);
                generalImage = @"embassy-icon";
                localImage = imageDict[@"other_image"];
                cultureImage = imageDict[@"culture_image"];
                safetyImage = imageDict[@"safety_image"];
            
            
            cityImage = @"embassy-icon";
            continent = @"the continent";
            clinicsURL= @"";
            weatherURL = @"";
            alertsURL = @"";
            dollarRatio = 6.0;
            
            //This doesn't exist yet, set up when ready
            //NSDictionary *embassyDict = cityDict[@""];
            
            
            [[TripManager getInstance] createTripWithCityImage:cityImage withCityName:cityName withContinent:continent withCultureText:cultureText withCultureImage:cultureImage withGeneralText:generalText withGeneralImage:generalImage withLocalImage:localImage withLocalText:localText withSafetyImage:safetyImage withSafetytext:safetyText withClinicsURL:clinicsURL withAlertsURL:alertsURL withWeatherURL:weatherURL withCADToNative:dollarRatio];
        
        }
        NSLog(@"firing note");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TRIP_UPDATE" object:nil];
    
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end

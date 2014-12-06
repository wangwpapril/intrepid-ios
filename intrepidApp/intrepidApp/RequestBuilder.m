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
        for (NSDictionary *cityDict in responseObject[@"destinations"]) {
            NSString *cityName, *cityImage, *continent, *cultureText, *cultureImage;
            NSString *generalText, *generalImage, *localText, *localImage;
            NSString *politicalImage, *politicalText, *clinicsURL, *weatherURL, *alertsURL;
            float dollarRatio;
            
            cityName = cityDict[@"name"];
            NSLog(@"city name: %@", cityName);
            
            NSDictionary *contentDict = cityDict[@"content"];
            
                NSLog(@"content dict: %@", contentDict);
                generalText = contentDict[@"general_description"];
                cultureText = contentDict[@"culture_description"];
                localText = @"local text";
                politicalText = @"poli text";
            
            
            NSDictionary *imageDict = cityDict[@"images"];
                NSLog(@"image dict: %@", imageDict);
                generalImage = @"embassy-icon";
                localImage = @"embassy-icon";
                cultureImage = imageDict[@"culture_image"];
                politicalImage = @"embassy-icon";
            
            
            cityImage = @"embassy-icon";
            continent = @"the continent";
            clinicsURL= @"";
            weatherURL = @"";
            alertsURL = @"";
            dollarRatio = 6.0;
            
//            for (NSDictionary *medications in cityDict[@"medications"]) {
//                
//            }
            
            [[TripManager getInstance] createTripWithCityImage:cityImage withCityName:cityName withContinent:continent withCultureText:cultureText withCultureImage:cultureImage withGeneralText:generalText withGeneralImage:generalImage withLocalImage:localImage withLocalText:localText withPoliticalImage:politicalImage withPoliticaltext:politicalText withClinicsURL:clinicsURL withAlertsURL:alertsURL withWeatherURL:weatherURL withCADToNative:dollarRatio];
        
        }
    
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

//- (CityEntity *)createTripWithCityImage:(NSString *)cityImage
//                           withCityName:(NSString *)cityName
//                          withContinent:(NSString *)continent
//                        withCultureText:(NSString *)cultureText
//                       withCultureImage:(NSString *)cultureImage
//                        withGeneralText:(NSString *)generalText
//                       withGeneralImage:(NSString *)generalImage
//                         withLocalImage:(NSString *)localImage
//                          withLocalText:(NSString *)localText
//                     withPoliticalImage:(NSString *)politicalImage
//                      withPoliticaltext:(NSString *)politicalText
//                         withClinicsURL:(NSString *)clinicsURL
//                          withAlertsURL:(NSString *)alertsURL
//                         withWeatherURL:(NSString *)weatherURL
//                        withCADToNative:(float) dollarRatio;

@end

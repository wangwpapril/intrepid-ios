//
//  RequestBuilder.h
//  intrepidApp
//
//  Created by Philip on 2014-12-04.
//  Copyright (c) 2014 JonCarrHarris Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestBuilder : NSObject

+ (void)fetchUser:(NSDictionary *)user;
+ (void)buildRequestWithURL:(NSString *)url;

@end

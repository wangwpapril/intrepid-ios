//
//  CurrencyItem.h
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-23.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrencyItem: NSObject {
    NSString *flag;
    NSString *country;
    NSString *value;
}

@property (nonatomic) NSString *flag;
@property (nonatomic, copy) NSString *country;

@property (nonatomic, strong) NSString *value;

+(id)currencyItemOfCountry:(NSString*)country flag:(NSString*)flag value:(NSString*)value;


@end

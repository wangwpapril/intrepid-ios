//
//  CurrencyCell.h
//  intrepidApp
//
//  Created by Philip Ojha on 7/23/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrencyCell : UITableViewCell

@property (nonatomic, strong) UIImageView *flagLabel;
@property (nonatomic, strong) UILabel *countryLabel;
@property (nonatomic, strong) UILabel *valueLabel;

- (void)setupWithImageName:(NSString *)image withCountry:(NSString *)country withValue:(NSString *)value;
@end

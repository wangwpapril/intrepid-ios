//
//  CurrencyCell.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/23/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "CurrencyCell.h"
#import "UIImageView+WebCache.h"

@implementation CurrencyCell

@synthesize flagLabel;
@synthesize countryLabel;
@synthesize valueLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeViews];
    }
    return self;
}

- (void)initializeViews {
    // flag
    flagLabel = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 30, 30)];
    flagLabel.layer.cornerRadius = 5;
    flagLabel.layer.masksToBounds = YES;
    [self addSubview:flagLabel];
    
    // country
    countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 2, 150, 40)];
    countryLabel.font = [UIFont fontWithName:APP_FONT size:16];
    countryLabel.textColor = APP_TEXT_COLOR;
    [self addSubview:countryLabel];
    
    // value
    valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 0, 70, 40)];
    valueLabel.font = [UIFont fontWithName:APP_FONT size:16];
    valueLabel.textColor = APP_TEXT_COLOR;
    valueLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:valueLabel];
}

- (void)setupWithCurrency:(CurrencyEntity *)currency withDestination:(DestinationEntity *)destination {
    if (destination) {
        double scaleFactor = [UIScreen mainScreen].scale;
        if (scaleFactor > 2.9 && ![destination.currencyImage3x isEqualToString:@""]) {
            [flagLabel sd_setImageWithURL:[NSURL URLWithString:destination.currencyImage3x] placeholderImage:[UIImage imageNamed:@"world"]];
        } else if (![destination.currencyImage2x isEqualToString:@""]) {
            [flagLabel sd_setImageWithURL:[NSURL URLWithString:destination.currencyImage2x] placeholderImage:[UIImage imageNamed:@"world"]];
        } else if (![destination.currencyImage1x isEqualToString:@""]) {
            [flagLabel sd_setImageWithURL:[NSURL URLWithString:destination.currencyImage1x] placeholderImage:[UIImage imageNamed:@"world"]];
        } else {
            flagLabel.image = [UIImage imageNamed:@"world"];
        }
    } else {
        flagLabel.image = [UIImage imageNamed:@"world"];
    }
    
    countryLabel.text = currency.country;
    valueLabel.text = currency.value;
}

@end

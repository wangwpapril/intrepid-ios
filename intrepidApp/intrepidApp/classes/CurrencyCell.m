//
//  CurrencyCell.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/23/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "CurrencyCell.h"
#import "Constants.h"

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
    flagLabel = [[UIImageView alloc] initWithFrame:CGRectMake(10, 2, 30, 30)];
    [self addSubview:flagLabel];
    
    // country
    countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 0, 150, 40)];
    countryLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:16];
    countryLabel.textColor = APP_TEXT_COLOR;
    [self addSubview:countryLabel];
    
    // value
    valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 0, 70, 40)];
    valueLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:16];
    valueLabel.textColor = APP_TEXT_COLOR;
    [self addSubview:valueLabel];
}

- (void)setupWithImageName:(NSString *)image withCountry:(NSString *)country withValue:(NSString *)value {
    flagLabel.image = [UIImage imageNamed:image];
    countryLabel.text = country;
    valueLabel.text = value;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
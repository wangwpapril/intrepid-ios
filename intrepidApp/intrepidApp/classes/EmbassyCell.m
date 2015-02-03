//
//  EmbassyCell.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/28/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "EmbassyCell.h"
#import "UIImageView+WebCache.h"
#import "TripManager.h"

@implementation EmbassyCell

@synthesize flagLabel;
@synthesize countryLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator; // arrow
        [self initializeViews];
    }
    return self;
}

- (void)initializeViews {
    // flag
    flagLabel = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 30, 30)];
    flagLabel.layer.cornerRadius = 5;
    flagLabel.layer.masksToBounds = YES;
    [self addSubview:flagLabel];
    
    // country
    countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 150, 40)];
    countryLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:17];
    countryLabel.textColor = APP_TEXT_COLOR;
    [self addSubview:countryLabel];
}

- (void)setupWithEmbassy:(EmbassyEntity *)embassy {
    DestinationEntity *destination = [[TripManager getInstance] getDestinationItemWithCountryName:embassy.country];
    
    if (destination) {
        double scaleFactor = [UIScreen mainScreen].scale;
        if (scaleFactor > 2.9 && ![destination.flagImage3x isEqualToString:@""]) {
            [flagLabel sd_setImageWithURL:[NSURL URLWithString:destination.flagImage3x] placeholderImage:[UIImage imageNamed:@"unused"]];
        } else if (![destination.flagImage2x isEqualToString:@""]) {
            [flagLabel sd_setImageWithURL:[NSURL URLWithString:destination.flagImage2x] placeholderImage:[UIImage imageNamed:@"unused"]];
        } else if (![destination.flagImage1x isEqualToString:@""]) {
            [flagLabel sd_setImageWithURL:[NSURL URLWithString:destination.flagImage1x] placeholderImage:[UIImage imageNamed:@"unused"]];
        } else {
            flagLabel.image = [UIImage imageNamed:@"unused"];
        }
    } else {
        flagLabel.image = [UIImage imageNamed:@"unused"];
    }
    
    countryLabel.text = embassy.country;
}

@end

//
//  EmbassyCell.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/28/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "EmbassyCell.h"
#import "Constants.h"

@implementation EmbassyCell

@synthesize flagLabel;
@synthesize countryLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator; // arrow
        [self initializeViews];
        // Initialization code
    }
    return self;
}

- (void)initializeViews {
    // flag
    flagLabel = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 30, 30)];
    [self addSubview:flagLabel];
    
    // country
    countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 2, 150, 40)];
    countryLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:16];
    countryLabel.textColor = APP_TEXT_COLOR;
    [self addSubview:countryLabel];
    
}

- (void)setupWithImageName:(NSString *)image withCountry:(NSString *)country{
    flagLabel.image = [UIImage imageNamed:image];
    countryLabel.text = country;
//    valueLabel.text = value;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

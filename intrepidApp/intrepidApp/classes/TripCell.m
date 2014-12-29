//
//  TripCell.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/28/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "TripCell.h"
#import "TripItem.h"  
#import "Constants.h"
#import "QuartzCore/QuartzCore.h"

@implementation TripCell

@synthesize continentLabel;
@synthesize tripImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        continentLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 0, 140, 40)];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.textLabel.font = [UIFont fontWithName:@"ProximaNova-Light" size:17];
        self.textLabel.textColor = APP_TEXT_COLOR;
        continentLabel.font = [UIFont fontWithName:@"ProximaNova-Light" size:13];
        continentLabel.textColor = [UIColor colorWithRed:71/255.0 green:184/255.0 blue:200/255.0 alpha:1];
        continentLabel.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:continentLabel];
    }
    return self;
}

-(void)setupWithHealthItem:(CityEntity *)city {

    
    UIImage *image = [UIImage imageNamed:city.cityImage];
    self.imageView.image = image;
    self.imageView.layer.cornerRadius = 5;
    self.imageView.layer.masksToBounds = YES;
    
    self.textLabel.text = city.cityName;
    continentLabel.text = @"Europe";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end

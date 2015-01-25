//
//  TripCell.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/28/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "TripCell.h"
#import "TripItem.h"
#import "QuartzCore/QuartzCore.h"
#import "UIImageView+WebCache.h"

@implementation TripCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

-(void)setupWithTripItem:(DestinationEntity *)destination {
    self.imageView.layer.cornerRadius = 5;
    self.imageView.layer.masksToBounds = YES;
    
    double scaleFactor = [UIScreen mainScreen].scale;
    if (scaleFactor > 2.9 && ![destination.flagImage3x isEqualToString:@""]) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:destination.flagImage3x] placeholderImage:[UIImage imageNamed:@"world"]];
    } else if (![destination.flagImage2x isEqualToString:@""]) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:destination.flagImage2x] placeholderImage:[UIImage imageNamed:@"world"]];
    } else if (![destination.flagImage1x isEqualToString:@""]) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:destination.flagImage1x] placeholderImage:[UIImage imageNamed:@"world"]];
    } else {
        self.imageView.image = [UIImage imageNamed:@"world"];
    }
    
    self.textLabel.text = destination.name;
}

@end
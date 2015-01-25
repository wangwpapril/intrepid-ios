//
//  HealthCell.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/4/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "HealthCell.h"
#import "HealthEntity.h"
#import "QuartzCore/QuartzCore.h"
#import "UIImageView+WebCache.h"

@implementation HealthCell

@synthesize commonImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        commonImage = [[UIImageView alloc] initWithFrame:CGRectMake(205, 16, 106, 13)];
    }
    return self;
}

-(void)setupWithHealthItem:(HealthEntity *)healthItem {
    self.imageView.layer.cornerRadius = 5;
    self.imageView.layer.masksToBounds = YES;
    
    double scaleFactor = [UIScreen mainScreen].scale;
    if (scaleFactor > 2.9 && ![healthItem.image3x isEqualToString:@""]) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:healthItem.image3x] placeholderImage:[UIImage imageNamed:@"unused"]];
    } else if (![healthItem.image2x isEqualToString:@""]) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:healthItem.image2x] placeholderImage:[UIImage imageNamed:@"unused"]];
    } else if (![healthItem.image1x isEqualToString:@""]) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:healthItem.image1x] placeholderImage:[UIImage imageNamed:@"unused"]];
    } else {
        self.imageView.image = [UIImage imageNamed:@"unused"];
    }
    
    self.textLabel.text = healthItem.name;
    self.textLabel.font = [UIFont fontWithName:@"ProximaNova-Light" size:17];
    self.textLabel.textColor = APP_TEXT_COLOR;
    
//    [self addSubview:commonImage];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.textLabel.backgroundColor = [UIColor clearColor];
}

@end

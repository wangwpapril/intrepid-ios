//
//  HealthCell.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/4/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "HealthCell.h"
#import "HealthEntity.h"
#import "Constants.h"
#import "QuartzCore/QuartzCore.h"


@implementation HealthCell

@synthesize commonImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        commonImage = [[UIImageView alloc] initWithFrame:CGRectMake(205, 16, 106, 13)];
    }
    return self;
}

-(void)setupWithHealthItem:(HealthEntity *)healthItem {
    
    UIImage *image = [UIImage imageNamed:healthItem.image];
    self.imageView.image = image;
    self.imageView.layer.cornerRadius = 5;
    self.imageView.layer.masksToBounds = YES;
    
    self.textLabel.text = healthItem.name;
    self.textLabel.font = [UIFont fontWithName:@"ProximaNova-Light" size:17];
    self.textLabel.textColor = APP_TEXT_COLOR;
    
    [self addSubview:commonImage];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.textLabel.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

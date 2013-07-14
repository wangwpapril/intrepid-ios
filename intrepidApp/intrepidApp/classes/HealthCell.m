//
//  HealthCell.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/4/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "HealthCell.h"
#import "HealthItem.h"
#import "Constants.h"
#import "QuartzCore/QuartzCore.h"

@implementation HealthCell

@synthesize commonImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        commonImage = [[UIImageView alloc] initWithFrame:CGRectMake(200, 0, 107, 42)];
    }
    return self;
}

-(void)setupWithHealthItem:(HealthItem *)healthItem {
    
    // common image
    NSString *commonImageName;
    
    if (healthItem.common == TRUE) {
        commonImageName = @"common.png";
    }
    
    else {
        commonImageName = @"uncommon.png";
    }
    commonImage.image = [UIImage imageNamed:commonImageName];
    
    UIImage *image = [UIImage imageNamed:@"samplePic.png"];
    self.imageView.image = image;
    self.imageView.layer.cornerRadius = 5;
    self.imageView.layer.masksToBounds = YES;
    
    self.textLabel.text = healthItem.name;
    self.textLabel.font = [UIFont fontWithName:APP_FONT size:PARA_SMALL];
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

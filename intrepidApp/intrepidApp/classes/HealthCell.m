//
//  HealthCell.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/4/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "HealthCell.h"

@implementation HealthCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setupWithName:(NSString *)name withStatus:(BOOL)common withImageURL:(NSString *)url {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 0, 107, 42)];
    NSString *imageName;
    if (common)
        imageName = @"common.png";
    else
        imageName = @"uncommon.png";
    imageView.image = [UIImage imageNamed:imageName];
    [self addSubview:imageView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

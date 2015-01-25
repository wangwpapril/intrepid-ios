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
    if (scaleFactor > 2.9 && ![destination.image3x isEqualToString:@""]) {
        self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[destination.image3x stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]] scale:3.0];
    } else if (![destination.image2x isEqualToString:@""]) {
        self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[destination.image2x stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]] scale:2.0];
    } else if (![destination.image1x isEqualToString:@""]) {
        self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[destination.image1x stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]] scale:1.0];
    } else {
        self.imageView.image = [UIImage imageNamed:@"worldmap"];
    }
    
    self.textLabel.text = destination.name;
}

@end
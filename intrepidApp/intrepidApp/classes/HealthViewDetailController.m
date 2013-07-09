//
//  HealthViewDetailController.m
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-09.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import "HealthViewDetailController.h"
#import "HealthViewController.h"
#import "HealthItem.h"
#import "Constants.h"

@implementation HealthViewDetailController

@synthesize healthItemNameLabel;
@synthesize healthItemName;
@synthesize healthItemCategory;

@synthesize descriptionLabel;
@synthesize descriptionDesignationLabel;

@synthesize sideEffectsLabel;
@synthesize sideEffectsDesignationLabel;

@synthesize descriptionText;
@synthesize sideEffectsText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addDescription];
    [self addSideEffects];
    
    healthItemNameLabel.text = healthItemName;
    healthItemNameLabel.font = [UIFont fontWithName:APP_FONT size:20];
    healthItemNameLabel.textAlignment = NSTextAlignmentCenter;
    
    //change background colour of header label
    if ([healthItemCategory isEqual: @"symptoms"]) {
        healthItemNameLabel.backgroundColor = UIColorFromRGB(0xfbedeb);
    }

    else if (([healthItemCategory isEqual: @"conditions"])) {
        healthItemNameLabel.backgroundColor = UIColorFromRGB(0xecebeb);
    }
    
    else {
        healthItemNameLabel.backgroundColor = UIColorFromRGB(0xecf8f9);
    }    
    
	// Do any additional setup after loading the view.
}

- (void)addDescription {
    
    descriptionLabel.font = [UIFont fontWithName:APP_FONT size:17];
    
    descriptionDesignationLabel.font = [UIFont fontWithName:APP_FONT size:12];
    [descriptionDesignationLabel setAlpha:0.3];
    descriptionDesignationLabel.textAlignment = NSTextAlignmentRight;
    
    //Set descriptionDesignationName in UILabel
    NSString *descriptionDesignationName;    
    descriptionDesignationName = [healthItemCategory substringToIndex:[healthItemCategory length]-1];
    descriptionDesignationLabel.text = descriptionDesignationName;
    
    //Set descriptionText to auto-fit content
    descriptionText.font = [UIFont fontWithName:APP_FONT size:12];
    [descriptionText setAlpha:0.4];
    descriptionText.frame = CGRectMake(descriptionText.frame.origin.x, descriptionText.frame.origin.y, descriptionText.frame.size.width, descriptionText.contentSize.height + descriptionText.contentInset.top + descriptionText.contentInset.bottom);
//    CGRect frame = descriptionText.frame;
//    UIEdgeInsets inset = descriptionText.contentInset;
//    frame.size.height = descriptionText.contentSize.height + inset.top + inset.bottom;
//    descriptionText.frame = frame;
}


- (void)addSideEffects {
    
    sideEffectsLabel.font = [UIFont fontWithName:APP_FONT size:17];
    sideEffectsDesignationLabel.font = [UIFont fontWithName:APP_FONT size:12];
    [sideEffectsDesignationLabel setAlpha:0.3];
    sideEffectsDesignationLabel.textAlignment = NSTextAlignmentRight;
    
    sideEffectsDesignationLabel.text = descriptionDesignationLabel.text;
    
    sideEffectsText.font = [UIFont fontWithName:APP_FONT size:12];
    [sideEffectsText setAlpha:0.4];
    CGRect frame = sideEffectsText.frame;
    UIEdgeInsets inset = sideEffectsText.contentInset;
    frame.size.height = sideEffectsText.contentSize.height + inset.top + inset.bottom;
    sideEffectsText.frame = frame;
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

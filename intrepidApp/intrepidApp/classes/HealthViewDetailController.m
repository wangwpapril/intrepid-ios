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
#import <QuartzCore/QuartzCore.h>

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

@synthesize descriptionImageLabel;
@synthesize sideEffectsImageLabel;

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
    
    descriptionImageLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"descriptionAndSideEffectLogo.png"]];
    descriptionImageLabel.text = NULL;
    
    sideEffectsImageLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"descriptionAndSideEffectLogo.png"]];
    sideEffectsImageLabel.text = NULL;

    
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    
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
    descriptionLabel.backgroundColor = UIColorFromRGB(0xffffff);
    descriptionLabel.textAlignment = NSTextAlignmentRight;
    
    descriptionDesignationLabel.font = [UIFont fontWithName:APP_FONT size:12];
    descriptionDesignationLabel.backgroundColor = UIColorFromRGB(0xffffff);
    [descriptionDesignationLabel setAlpha:0.3];
    descriptionDesignationLabel.textAlignment = NSTextAlignmentRight;
    
    //Set descriptionDesignationName in UILabel
    NSString *descriptionDesignationName;    
    descriptionDesignationName = [healthItemCategory substringToIndex:[healthItemCategory length]-1];
    descriptionDesignationLabel.text = descriptionDesignationName;
    
    //Set descriptionText to auto-fit content
    descriptionText.font = [UIFont fontWithName:APP_FONT size:12];
    descriptionText.backgroundColor = UIColorFromRGB(0xffffff);
    [descriptionText setAlpha:0.4];
    
//    CGRect frame = descriptionText.frame;
//    UIEdgeInsets inset = descriptionText.contentInset;
//    frame.size.height = descriptionText.contentSize.height + inset.top + inset.bottom;
//    descriptionText.frame = frame;
}


- (void)addSideEffects {
    
    sideEffectsLabel.font = [UIFont fontWithName:APP_FONT size:17];
    sideEffectsLabel.backgroundColor = UIColorFromRGB(0xffffff);
    sideEffectsLabel.textAlignment = NSTextAlignmentRight;
    
    sideEffectsDesignationLabel.font = [UIFont fontWithName:APP_FONT size:12];
    sideEffectsDesignationLabel.backgroundColor = UIColorFromRGB(0xffffff);
    [sideEffectsDesignationLabel setAlpha:0.3];
    sideEffectsDesignationLabel.textAlignment = NSTextAlignmentRight;
    
    sideEffectsDesignationLabel.text = descriptionDesignationLabel.text;
    
    sideEffectsText.font = [UIFont fontWithName:APP_FONT size:12];
    sideEffectsText.backgroundColor = UIColorFromRGB(0xffffff);
    [sideEffectsText setAlpha:0.4];
    
//    CGRect frame = sideEffectsText.frame;
//    UIEdgeInsets inset = sideEffectsText.contentInset;
//    frame.size.height = sideEffectsText.contentSize.height + inset.top + inset.bottom;
//    sideEffectsText.frame = frame;
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

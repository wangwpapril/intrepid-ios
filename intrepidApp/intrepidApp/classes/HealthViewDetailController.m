//
//  HealthViewDetailController.m
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-09.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//
#import "HealthViewDetailController.h"
#import "HealthViewController.h"
#import "HealthItem.h"
#import "Constants.h"
#import <QuartzCore/QuartzCore.h>

@implementation HealthViewDetailController

@synthesize healthItemNameLabel;
@synthesize healthItemTitleLabel;
@synthesize healthItem;

@synthesize descriptionDesignationLabel;

@synthesize sideEffectsDesignationLabel;


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
    
    UIImage *backgroundImage = [UIImage imageNamed:@"mexicoBackBigger.png"];
    CGRect imageFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    CGRect whiteFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    UIImageView *myImageView = [[UIImageView alloc] initWithFrame:imageFrame];
    [myImageView setImage:backgroundImage];
    [self.view addSubview:myImageView];
    UIView *whiteLayer = [[UIView alloc] initWithFrame:whiteFrame];
    whiteLayer.backgroundColor = [UIColor whiteColor];
    whiteLayer.alpha = 0.9;
    [self.view addSubview:whiteLayer];
    
    CGRect rect=CGRectMake(0, 0, 320, 520);
    scrollView = [[UIScrollView alloc] initWithFrame:rect];
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.scrollEnabled = YES;
    
    [self addContent];

    //Description and Side Effects images
    UIImageView  *descriptionImageLabel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stethoscope-pic.png"]];
    descriptionImageLabel.frame = CGRectMake(5, 40, 25, 25);
    [scrollView addSubview:descriptionImageLabel];

    
    // Set Header label    
    healthItemTitleLabel.backgroundColor = NAVIGATION_BG_COLOR;
    healthItemTitleLabel.text = NULL;
    
    NSString *uppercaseString = [healthItem.name uppercaseString];
    healthItemNameLabel.text = uppercaseString;
    healthItemNameLabel.backgroundColor = [UIColor clearColor];
    healthItemNameLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:16];
    healthItemNameLabel.textColor = UIColorFromRGB(0xeaf0e6);
    
    [healthItemTitleLabel addSubview:healthItemNameLabel];
    [self.view addSubview:healthItemTitleLabel];
    [self.view addSubview:scrollView];
    
	// Do any additional setup after loading the view.
}

- (void)addContent {
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, -5, 120, 120)];
    descriptionLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:18];
    descriptionLabel.backgroundColor = [UIColor clearColor];
    descriptionLabel.textColor = UIColorFromRGB(0x423a38);
    descriptionLabel.text = @"Description";
    
    //Set descriptionText to auto-fit content
    CGSize size = [healthItem.description sizeWithFont:[UIFont systemFontOfSize:15]
                      constrainedToSize:CGSizeMake(320, self.view.bounds.size.height-100)
                          lineBreakMode:UILineBreakModeWordWrap];
    UITextView *descriptionText = [[UITextView alloc] initWithFrame:CGRectMake(0, 70,  320, size.height)];
    descriptionText.font = [UIFont fontWithName:@"ProximaNova-Regular" size:15];
    descriptionText.backgroundColor = UIColorFromRGB(0xffffff);
    descriptionText.textColor = UIColorFromRGB(0x423a38);
    descriptionText.text = healthItem.description;
    [descriptionText setAlpha:0.6];
    descriptionText.scrollEnabled = NO;
    descriptionText.editable = NO;
    descriptionText.layer.borderWidth = 1.0f;
    descriptionText.layer.borderColor = [[UIColor grayColor] CGColor];
    
    [scrollView addSubview:descriptionLabel];
    [scrollView addSubview: descriptionText];
    
    UIImageView  *sideEffectsImageLabel = [[UIImageView alloc] init];
    
    if ([healthItem.category isEqualToString:@"symptoms"]) {
        [sideEffectsImageLabel setImage:[UIImage imageNamed:@"heart-rate-pic.png"]];
    }
    else if ([healthItem.category isEqualToString:@"prevention"]) {
        [sideEffectsImageLabel setImage:[UIImage imageNamed:@"conditions-pic.png"]];
    }
    else {
        [sideEffectsImageLabel setImage:[UIImage imageNamed:@"medication-pic.png"]];
    }
    sideEffectsImageLabel.frame = CGRectMake(7, size.height + 75, 25, 25);
    [scrollView addSubview:sideEffectsImageLabel];
    
    UILabel *sideEffectsLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, size.height + 30, 120, 120)];
    sideEffectsLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:18];
    sideEffectsLabel.backgroundColor = [UIColor clearColor];
    sideEffectsLabel.textColor = UIColorFromRGB(0x423a38);
    
    if ([healthItem.category isEqualToString:@"symptoms"]) {
        sideEffectsLabel.text = @"Transmission";
    }
    else if ([healthItem.category isEqualToString:@"prevention"]) {
        sideEffectsLabel.text = @"Immunization";
    }
    else {
        sideEffectsLabel.text = @"Side Effects";
    }
    
    CGSize sideEffectsSize = [healthItem.details sizeWithFont:[UIFont systemFontOfSize:15]
                                     constrainedToSize:CGSizeMake(320, self.view.bounds.size.height - 100)
                                         lineBreakMode:UILineBreakModeWordWrap];
    UITextView *sideEffectsText = [[UITextView alloc] initWithFrame:CGRectMake(0, size.height + 105,  320, sideEffectsSize.height)];
    sideEffectsText.font = [UIFont fontWithName:@"ProximaNova-Regular" size:15];
    sideEffectsText.backgroundColor = UIColorFromRGB(0xffffff);
    sideEffectsText.textColor = UIColorFromRGB(0x423a38);
    sideEffectsText.text = healthItem.details;
    [sideEffectsText setAlpha:0.6];
    sideEffectsText.scrollEnabled = NO;
    sideEffectsText.editable = NO;
    sideEffectsText.layer.borderWidth = 1.0f;
    sideEffectsText.layer.borderColor = [[UIColor grayColor] CGColor];
    
    [scrollView addSubview: sideEffectsLabel];
    [scrollView addSubview: sideEffectsText];
    scrollView.contentSize = CGSizeMake(320, size.height + 115 + sideEffectsSize.height);
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

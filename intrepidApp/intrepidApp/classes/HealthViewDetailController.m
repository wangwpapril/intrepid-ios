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
    
    CGRect rect=CGRectMake(0, 36, 320, self.view.frame.size.height - 44);
    scrollView = [[UIScrollView alloc] initWithFrame:rect];
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.scrollEnabled = YES;
    
    [self addContent];
    
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
    UIImageView  *descriptionImageLabel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stethoscope-pic.png"]];
    descriptionImageLabel.frame = CGRectMake(5, 10, 25, 25);
    [scrollView addSubview:descriptionImageLabel];
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 120, 25)];
    descriptionLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:18];
    descriptionLabel.backgroundColor = [UIColor clearColor];
    descriptionLabel.textColor = UIColorFromRGB(0x423a38);
    descriptionLabel.text = @"Description";
    
    //Set descriptionText to auto-fit content
    CGSize size = [healthItem.description sizeWithFont:[UIFont fontWithName:@"ProximaNova-Light" size:15]
                      constrainedToSize:CGSizeMake(290, 15000)
                          lineBreakMode:NSLineBreakByWordWrapping];
    UILabel *descriptionText = [[UILabel alloc] initWithFrame:CGRectMake(15, 5,  290, size.height + 5)];
    descriptionText.font = [UIFont fontWithName:@"ProximaNova-Light" size:15];
    descriptionText.backgroundColor = UIColorFromRGB(0xffffff);
    descriptionText.textColor = APP_TEXT_COLOR;
    descriptionText.text = healthItem.description;
    descriptionText.lineBreakMode = NSLineBreakByWordWrapping;
    descriptionText.numberOfLines = 0;
    
    UILabel *descriptionTextContainer = [[UILabel alloc] initWithFrame:CGRectMake(0, 45,  320, size.height + 15)];
    descriptionTextContainer.layer.borderWidth = 1.0f;
    descriptionTextContainer.layer.borderColor = [[UIColor grayColor] CGColor];
    
    [scrollView addSubview:descriptionLabel];
    [descriptionTextContainer addSubview: descriptionText];
    [scrollView addSubview:descriptionTextContainer];
    
    //begin creating sideEffects title label    
    UIImageView  *sideEffectsImageLabel = [[UIImageView alloc] init];
    
    [sideEffectsImageLabel setImage:[UIImage imageNamed:@"medication-pic.png"]];
    sideEffectsImageLabel.frame = CGRectMake(7, descriptionTextContainer.frame.origin.y + size.height + 20, 25, 25);
    [scrollView addSubview:sideEffectsImageLabel];
    
    UILabel *sideEffectsLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, descriptionTextContainer.frame.origin.y + size.height + 20, 120, 25)];
    sideEffectsLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:18];
    sideEffectsLabel.backgroundColor = [UIColor clearColor];
    sideEffectsLabel.textColor = UIColorFromRGB(0x423a38);
    
    NSString *secondTitle = @"Side Effects";
    if ([healthItem.category isEqualToString:@"conditions"]) {
        secondTitle = @"Symptoms";
    }
    sideEffectsLabel.text = secondTitle;
    
    //Begin sizing sideEffects text container
    CGSize sideEffectsSize = [healthItem.details sizeWithFont:[UIFont fontWithName:@"ProximaNova-Light" size:15]
                                     constrainedToSize:CGSizeMake(290, 15000)
                                         lineBreakMode:NSLineBreakByWordWrapping];    
    UILabel *sideEffectsText = [[UILabel alloc] initWithFrame:CGRectMake(15, 5,  290, sideEffectsSize.height + 5)];
    sideEffectsText.font = [UIFont fontWithName:@"ProximaNova-Light" size:15];
    sideEffectsText.backgroundColor = UIColorFromRGB(0xffffff);
    sideEffectsText.textColor = APP_TEXT_COLOR;
    sideEffectsText.text = healthItem.details;
    sideEffectsText.lineBreakMode = NSLineBreakByWordWrapping;
    sideEffectsText.numberOfLines = 0;
    
    UILabel *sideEffectsTextContainer = [[UILabel alloc] initWithFrame:CGRectMake(0, descriptionTextContainer.frame.origin.y + size.height + 55,  320, sideEffectsSize.height + 15)];
    sideEffectsTextContainer.layer.borderWidth = 1.0f;
    sideEffectsTextContainer.layer.borderColor = [[UIColor grayColor] CGColor];
    
    [scrollView addSubview: sideEffectsLabel];
    [sideEffectsTextContainer addSubview: sideEffectsText];
    [scrollView  addSubview:sideEffectsTextContainer];
    
        
    //begin creating transmission description box and text box containers
    UILabel *transmissionTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, sideEffectsTextContainer.frame.origin.y + sideEffectsSize.height + 20, 120, 25)];
    transmissionTitleLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:18];
    transmissionTitleLabel.backgroundColor = [UIColor clearColor];
    transmissionTitleLabel.textColor = UIColorFromRGB(0x423a38);
    transmissionTitleLabel.text = @"Transmission";
    [scrollView addSubview:transmissionTitleLabel];

    UIImageView  *transmissionImageLabel = [[UIImageView alloc] init];
    [transmissionImageLabel setImage:[UIImage imageNamed:@"heart-rate-pic.png"]];
    transmissionImageLabel.frame = CGRectMake(7, sideEffectsTextContainer.frame.origin.y + sideEffectsSize.height + 20, 20, 25);
    [scrollView addSubview:transmissionImageLabel];

    CGSize transmissionSize = [healthItem.symptoms sizeWithFont:[UIFont fontWithName:@"ProximaNova-Light" size:15]
                                              constrainedToSize:CGSizeMake(290, 15000)
                                                lineBreakMode:NSLineBreakByWordWrapping];

    UILabel *transmissionText = [[UILabel alloc] initWithFrame:CGRectMake(15, 5,  290, transmissionSize.height + 5)];
    transmissionText.font = [UIFont fontWithName:@"ProximaNova-Light" size:15];
    transmissionText.backgroundColor = UIColorFromRGB(0xffffff);
    transmissionText.textColor = APP_TEXT_COLOR;
    transmissionText.text = healthItem.symptoms;
    transmissionText.lineBreakMode = NSLineBreakByWordWrapping;
    transmissionText.numberOfLines = 0;
    
    
    UILabel *transmissionTextContainer = [[UILabel alloc] initWithFrame:CGRectMake(0, sideEffectsTextContainer.frame.origin.y + sideEffectsSize.height + 55,  320, transmissionSize.height + 15)];
    transmissionTextContainer.layer.borderWidth = 1.0f;
    transmissionTextContainer.layer.borderColor = [[UIColor grayColor] CGColor];        
    
    [transmissionTextContainer addSubview:transmissionText];
    [scrollView addSubview:transmissionTextContainer];

    //begin creating immunization text header and text container

    UILabel *immunizationTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, transmissionTextContainer.frame.origin.y + transmissionSize.height + 20, 250, 25)];
    immunizationTitleLabel .font = [UIFont fontWithName:@"ProximaNova-Semibold" size:18];
    immunizationTitleLabel.backgroundColor = [UIColor clearColor];
    immunizationTitleLabel.textColor = UIColorFromRGB(0x423a38);
    immunizationTitleLabel.text = @"Immunization";
    [scrollView addSubview:immunizationTitleLabel];

    UIImageView  *immunizationImageLabel = [[UIImageView alloc] init];
    [immunizationImageLabel setImage:[UIImage imageNamed:@"conditions-pic.png"]];
    immunizationImageLabel.frame = CGRectMake(7, transmissionTextContainer.frame.origin.y + transmissionSize.height + 20, 20, 25);
    [scrollView addSubview:immunizationImageLabel];

    CGSize immunizationSize = [healthItem.immunization sizeWithFont:[UIFont fontWithName:@"ProximaNova-Light" size:15]
                                                  constrainedToSize:CGSizeMake(290, 15000)
                                                 lineBreakMode:NSLineBreakByWordWrapping];
    UILabel *immunizationText = [[UILabel alloc] initWithFrame:CGRectMake(15, 5,  290, immunizationSize.height + 5)];
    immunizationText.font = [UIFont fontWithName:@"ProximaNova-Light" size:15];
    immunizationText.backgroundColor = UIColorFromRGB(0xffffff);
    immunizationText.textColor = APP_TEXT_COLOR;
    immunizationText.text = healthItem.immunization;
    immunizationText.lineBreakMode = NSLineBreakByWordWrapping;
    immunizationText.numberOfLines = 0;
    
    UILabel *immunizationTextContainer = [[UILabel alloc] initWithFrame:CGRectMake(0, transmissionTextContainer.frame.origin.y + transmissionSize.height + 55,  320, immunizationSize.height + 15)];
    immunizationTextContainer.layer.borderWidth = 1.0f;
    immunizationTextContainer.layer.borderColor = [[UIColor grayColor] CGColor];
    
    
    [immunizationTextContainer addSubview:immunizationText];
    [scrollView addSubview:immunizationTextContainer];
    
    if ([healthItem.category isEqualToString:@"medications"]) {
        sideEffectsLabel.text = @"Side Effects";
        transmissionTitleLabel.text = @"Storage";
        immunizationTitleLabel.text = @"General Information";
    }
    
    if (([healthItem.category isEqualToString:@"conditions"]) || ([healthItem.category isEqualToString:@"symptoms"])) {
        sideEffectsLabel.text = @"Details";
        transmissionTitleLabel.text = @"Symptoms";
        immunizationTitleLabel.text = @"Immunization";
        
    }
    
    scrollView.contentSize = CGSizeMake(320, immunizationTextContainer.frame.origin.y + immunizationTextContainer.frame.size.height + 36);
    
}

- (void)AddTextBlockWithOffset:(NSInteger)offset withImageName:(NSString *)imageName withText:(NSString *)text {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

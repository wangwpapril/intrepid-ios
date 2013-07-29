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
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, -5, 120, 120)]; // rly
    descriptionLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:18];
    descriptionLabel.backgroundColor = [UIColor clearColor];
    descriptionLabel.textColor = UIColorFromRGB(0x423a38);
    descriptionLabel.text = @"Description";
    
    //Set descriptionText to auto-fit content
    CGSize size = [healthItem.description sizeWithFont:[UIFont systemFontOfSize:15]
                      constrainedToSize:CGSizeMake(320, self.view.bounds.size.height-100)
                          lineBreakMode:NSLineBreakByWordWrapping];
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
    
    //begin creating sideEffects title label    
    UIImageView  *sideEffectsImageLabel = [[UIImageView alloc] init];
    
    [sideEffectsImageLabel setImage:[UIImage imageNamed:@"medication-pic.png"]];
    sideEffectsImageLabel.frame = CGRectMake(7, size.height + 75, 25, 25);
    [scrollView addSubview:sideEffectsImageLabel];
    
    UILabel *sideEffectsLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, size.height + 30, 120, 120)];
    sideEffectsLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:18];
    sideEffectsLabel.backgroundColor = [UIColor clearColor];
    sideEffectsLabel.textColor = UIColorFromRGB(0x423a38);
    sideEffectsLabel.text = @"Side Effects";
    
    //Begin sizing sideEffects text container
    CGSize sideEffectsSize = [healthItem.details sizeWithFont:[UIFont systemFontOfSize:15]
                                     constrainedToSize:CGSizeMake(320, self.view.bounds.size.height - 100)
                                         lineBreakMode:NSLineBreakByWordWrapping];
    
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
    
    
    if ([healthItem.category isEqualToString:@"conditions"]) {
        //begin creating transmission description box and text box containers
        UILabel *transmissionTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, sideEffectsText.frame.origin.y + sideEffectsSize.height - 42, 120, 120)];
        transmissionTitleLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:18];
        transmissionTitleLabel.backgroundColor = [UIColor clearColor];
        transmissionTitleLabel.textColor = UIColorFromRGB(0x423a38);
        transmissionTitleLabel.text = @"Transmission";
        [scrollView addSubview:transmissionTitleLabel];

        UIImageView  *transmissionImageLabel = [[UIImageView alloc] init];
        [transmissionImageLabel setImage:[UIImage imageNamed:@"heart-rate-pic.png"]];
        transmissionImageLabel.frame = CGRectMake(7, sideEffectsText.frame.origin.y + sideEffectsSize.height + 5, 20, 20);
        [scrollView addSubview:transmissionImageLabel];

        CGSize transmissionSize = [healthItem.details sizeWithFont:[UIFont systemFontOfSize:15]
                                                constrainedToSize:CGSizeMake(320, self.view.bounds.size.height - 100)
                                                    lineBreakMode:NSLineBreakByWordWrapping];

        UITextView *transmissionTextContainer = [[UITextView alloc] initWithFrame:CGRectMake(0, sideEffectsText.frame.origin.y + transmissionSize.height + 35,  320, sideEffectsSize.height)];
        transmissionTextContainer.font = [UIFont fontWithName:@"ProximaNova-Regular" size:15];
        transmissionTextContainer.backgroundColor = UIColorFromRGB(0xffffff);
        transmissionTextContainer.textColor = UIColorFromRGB(0x423a38);
        transmissionTextContainer.text = healthItem.details;
        [transmissionTextContainer setAlpha:0.6];
        transmissionTextContainer.scrollEnabled = NO;
        transmissionTextContainer.editable = NO;
        transmissionTextContainer.layer.borderWidth = 1.0f;
        transmissionTextContainer.layer.borderColor = [[UIColor grayColor] CGColor];    
        [scrollView addSubview:transmissionTextContainer];

        //begin creating immunization text header and text container

        UILabel *immunizationTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, transmissionTextContainer.frame.origin.y + transmissionSize.height - 42, 120, 120)];
        immunizationTitleLabel .font = [UIFont fontWithName:@"ProximaNova-Semibold" size:18];
        immunizationTitleLabel.backgroundColor = [UIColor clearColor];
        immunizationTitleLabel.textColor = UIColorFromRGB(0x423a38);
        immunizationTitleLabel.text = @"Immunization";
        [scrollView addSubview:immunizationTitleLabel];

        UIImageView  *immunizationImageLabel = [[UIImageView alloc] init];
        [immunizationImageLabel setImage:[UIImage imageNamed:@"conditions-pic.png"]];
        immunizationImageLabel.frame = CGRectMake(7, transmissionTextContainer.frame.origin.y + transmissionSize.height + 5, 20, 20);
        [scrollView addSubview:immunizationImageLabel];

        CGSize immunizationSize = [healthItem.details sizeWithFont:[UIFont systemFontOfSize:15]
                                                 constrainedToSize:CGSizeMake(320, self.view.bounds.size.height - 100)
                                                     lineBreakMode:NSLineBreakByWordWrapping];

        UITextView *immunizationTextContainer = [[UITextView alloc] initWithFrame:CGRectMake(0, transmissionTextContainer.frame.origin.y + immunizationSize.height + 35,  320, immunizationSize.height)];
        immunizationTextContainer.font = [UIFont fontWithName:@"ProximaNova-Regular" size:15];
        immunizationTextContainer.backgroundColor = UIColorFromRGB(0xffffff);
        immunizationTextContainer.textColor = UIColorFromRGB(0x423a38);
        immunizationTextContainer.text = healthItem.details;
        [immunizationTextContainer setAlpha:0.6];
        immunizationTextContainer.scrollEnabled = NO;
        immunizationTextContainer.editable = NO;
        immunizationTextContainer.layer.borderWidth = 1.0f;
        immunizationTextContainer.layer.borderColor = [[UIColor grayColor] CGColor];
        [scrollView addSubview:immunizationTextContainer];

        scrollView.contentSize = CGSizeMake(320, immunizationTextContainer.frame.origin.y + immunizationSize.height +10);
        
    }
    else {
        scrollView.contentSize = CGSizeMake(320, sideEffectsText.frame.origin.y + sideEffectsSize.height + 10);
    }
    
    //description side effects transmission immunization
        
}

- (void)AddTextBlockWithOffset:(NSInteger)offset withImageName:(NSString *)imageName withText:(NSString *)text {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

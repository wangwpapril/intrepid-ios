//
//  HealthViewDetailController.m
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-09.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//
#import "HealthViewDetailController.h"
#import "HealthViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MenuButton.h"

@implementation HealthViewDetailController

@synthesize healthItem;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    UIImage *backgroundImage = [UIImage imageNamed:@"mexicoBackBigger"];
//    CGRect imageFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    CGRect whiteFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    UIImageView *myImageView = [[UIImageView alloc] initWithFrame:imageFrame];
//    [myImageView setImage:backgroundImage];
//    [self.view addSubview:myImageView];
//    UIView *whiteLayer = [[UIView alloc] initWithFrame:whiteFrame];
//    whiteLayer.backgroundColor = [UIColor whiteColor];
//    whiteLayer.alpha = 0.9;
//    [self.view addSubview:whiteLayer];
    
    CGRect rect=CGRectMake(0, 0, 320, self.view.frame.size.height);
    scrollView = [[UIScrollView alloc] initWithFrame:rect];
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.scrollEnabled = YES;
    
    // Set Header label
//    healthItemTitleLabel.backgroundColor = NAVIGATION_BG_COLOR;
//    healthItemTitleLabel.text = NULL;
//    
//    NSString *uppercaseString = [healthItem.name uppercaseString];
//    healthItemNameLabel.text = uppercaseString;
//    healthItemNameLabel.backgroundColor = [UIColor clearColor];
//    healthItemNameLabel.font = [UIFont fontWithName:APP_FONT size:16];
//    healthItemNameLabel.textColor = [UIColor whiteColor];
//    
//    [healthItemTitleLabel addSubview:healthItemNameLabel];
//    [self.view addSubview:healthItemTitleLabel];
    
    self.navigationItem.title = healthItem.name;
    [self addContent];
    [self.view addSubview:scrollView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[SEGAnalytics sharedAnalytics] screen:@"Health Detail"];
    [MenuButton getInstance].hidden = true;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [MenuButton getInstance].hidden = false;
}

- (void)addContent {
    int y = 0;
    UIImageView  *descriptionImageLabel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stethoscope-icon"]];
    descriptionImageLabel.frame = CGRectMake(17, 10, 25, 25);
    [scrollView addSubview:descriptionImageLabel];
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 250, 25)];
    descriptionLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:18];
    descriptionLabel.backgroundColor = [UIColor clearColor];
    descriptionLabel.textColor = APP_TEXT_COLOR;
    
    if ([healthItem.category isEqualToString:@"conditions"]) {
        descriptionLabel.text = @"Description";
    } else {
        descriptionLabel.text = @"Brand Name";
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    //Set descriptionText to auto-fit content
    CGSize size = [healthItem.desc boundingRectWithSize:CGSizeMake(290, 15000)
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:@{NSParagraphStyleAttributeName:paragraphStyle.copy, NSFontAttributeName:[UIFont fontWithName:@"ProximaNova-Light" size:15]}
                                                       context:nil].size;
    UILabel *descriptionText = [[UILabel alloc] initWithFrame:CGRectMake(17, 5,  290, size.height + 5)];
    descriptionText.font = [UIFont fontWithName:@"ProximaNova-Light" size:15];
    descriptionText.backgroundColor = [UIColor clearColor];
    descriptionText.textColor = APP_TEXT_COLOR;
    descriptionText.text = healthItem.desc;
    descriptionText.lineBreakMode = NSLineBreakByWordWrapping;
    descriptionText.numberOfLines = 0;
    
    UILabel *descriptionTextContainer = [[UILabel alloc] initWithFrame:CGRectMake(0, 45,  320, size.height + 15)];
    descriptionTextContainer.layer.borderWidth = 1.0f;
    descriptionTextContainer.layer.borderColor = APP_BORDER_COLOR;
    descriptionTextContainer.backgroundColor = [UIColor clearColor];

    
    [scrollView addSubview:descriptionLabel];
    [descriptionTextContainer addSubview: descriptionText];
    [scrollView addSubview:descriptionTextContainer];
    
    //begin creating sideEffects title label
    
    if ([healthItem.category isEqualToString:@"medications"]) {
        UIImageView  *sideEffectsImageLabel = [[UIImageView alloc] init];

        [sideEffectsImageLabel setImage:[UIImage imageNamed:@"medication-icon"]];
        sideEffectsImageLabel.frame = CGRectMake(17, descriptionTextContainer.frame.origin.y + size.height + 22, 25, 25);
        [scrollView addSubview:sideEffectsImageLabel];

        UILabel *sideEffectsLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, descriptionTextContainer.frame.origin.y + size.height + 22, 120, 25)];
        sideEffectsLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:18];
        sideEffectsLabel.backgroundColor = [UIColor clearColor];
        sideEffectsLabel.text = @"Side Effects";
        sideEffectsLabel.textColor = APP_TEXT_COLOR;

        NSString *secondTitle = @"Description";
        if ([healthItem.category isEqualToString:@"conditions"]) {
            secondTitle = @"Symptoms";
        }
        sideEffectsLabel.text = secondTitle;

        //Begin sizing sideEffects text container
        CGSize sideEffectsSize = [healthItem.details boundingRectWithSize:CGSizeMake(290, 15000)
                                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                                               attributes:@{NSParagraphStyleAttributeName:paragraphStyle.copy, NSFontAttributeName:[UIFont fontWithName:@"ProximaNova-Light" size:15]}
                                                                  context:nil].size;
        UILabel *sideEffectsText = [[UILabel alloc] initWithFrame:CGRectMake(17, 5,  290, sideEffectsSize.height + 5)];
        sideEffectsText.font = [UIFont fontWithName:@"ProximaNova-Light" size:15];
        sideEffectsText.backgroundColor = [UIColor clearColor];
        sideEffectsText.textColor = APP_TEXT_COLOR;
        sideEffectsText.text = healthItem.details;
        sideEffectsText.lineBreakMode = NSLineBreakByWordWrapping;
        sideEffectsText.numberOfLines = 0;

        UILabel *sideEffectsTextContainer = [[UILabel alloc] initWithFrame:CGRectMake(0, descriptionTextContainer.frame.origin.y + size.height + 55,  320, sideEffectsSize.height + 15)];
        sideEffectsTextContainer.layer.borderWidth = 1.0f;
        sideEffectsTextContainer.layer.borderColor = APP_BORDER_COLOR;
        sideEffectsText.backgroundColor = [UIColor clearColor];


        [scrollView addSubview: sideEffectsLabel];
        [sideEffectsTextContainer addSubview: sideEffectsText];
        [scrollView  addSubview:sideEffectsTextContainer];
        
        y = sideEffectsTextContainer.frame.origin.y + sideEffectsSize.height + 20;
        
    }
    
    if ([healthItem.category isEqualToString:@"medications"]) {
    }
    
    else {
        y = descriptionTextContainer.frame.origin.y + size.height + 20;
    }
    
    //begin creating transmission description box and text box containers
    UILabel *transmissionTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, y, 120, 25)];
    transmissionTitleLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:18];
    transmissionTitleLabel.backgroundColor = [UIColor clearColor];
    transmissionTitleLabel.textColor = APP_TEXT_COLOR;
    transmissionTitleLabel.text = @"Transmission";
    [scrollView addSubview:transmissionTitleLabel];
    
    UIImageView  *transmissionImageLabel = [[UIImageView alloc] init];
    [transmissionImageLabel setImage:[UIImage imageNamed:@"heart-rate-icon"]];
    transmissionImageLabel.frame = CGRectMake(17, y, 20, 25);
    [scrollView addSubview:transmissionImageLabel];
    
    CGSize transmissionSize = [healthItem.symptoms boundingRectWithSize:CGSizeMake(290, 15000)
                                                                options:NSStringDrawingUsesLineFragmentOrigin
                                                             attributes:@{NSParagraphStyleAttributeName:paragraphStyle.copy, NSFontAttributeName:[UIFont fontWithName:@"ProximaNova-Light" size:15]}
                                                                context:nil].size;
    UILabel *transmissionText = [[UILabel alloc] initWithFrame:CGRectMake(15, 5,  290, transmissionSize.height + 5)];
    transmissionText.font = [UIFont fontWithName:@"ProximaNova-Light" size:15];
    transmissionText.backgroundColor = [UIColor clearColor];
    transmissionText.textColor = APP_TEXT_COLOR;
    transmissionText.text = healthItem.symptoms;
    transmissionText.lineBreakMode = NSLineBreakByWordWrapping;
    transmissionText.numberOfLines = 0;
    
    
    UILabel *transmissionTextContainer = [[UILabel alloc] initWithFrame:CGRectMake(0, y + 35,  320, transmissionSize.height + 15)];
    transmissionTextContainer.layer.borderWidth = 1.0f;
    transmissionTextContainer.backgroundColor = [UIColor clearColor];

    transmissionTextContainer.layer.borderColor = APP_BORDER_COLOR;
    
    [transmissionTextContainer addSubview:transmissionText];
    [scrollView addSubview:transmissionTextContainer];

    //begin creating immunization text header and text container

    UILabel *immunizationTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, transmissionTextContainer.frame.origin.y + transmissionSize.height + 22, 250, 25)];
    immunizationTitleLabel .font = [UIFont fontWithName:@"ProximaNova-Semibold" size:18];
    immunizationTitleLabel.backgroundColor = [UIColor clearColor];
    immunizationTitleLabel.textColor = APP_TEXT_COLOR;
    immunizationTitleLabel.text = @"Immunization";
    [scrollView addSubview:immunizationTitleLabel];

    UIImageView  *immunizationImageLabel = [[UIImageView alloc] init];
    [immunizationImageLabel setImage:[UIImage imageNamed:@"conditions-icon"]];
    immunizationImageLabel.frame = CGRectMake(17, transmissionTextContainer.frame.origin.y + transmissionSize.height + 22, 20, 25);
    [scrollView addSubview:immunizationImageLabel];

    CGSize immunizationSize = [healthItem.immunization boundingRectWithSize:CGSizeMake(290, 15000)
                                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                                 attributes:@{NSParagraphStyleAttributeName:paragraphStyle.copy, NSFontAttributeName:[UIFont fontWithName:@"ProximaNova-Light" size:15]}
                                                                    context:nil].size;
    UILabel *immunizationText = [[UILabel alloc] initWithFrame:CGRectMake(15, 5,  290, immunizationSize.height + 5)];
    immunizationText.font = [UIFont fontWithName:@"ProximaNova-Light" size:15];
    immunizationText.backgroundColor = [UIColor clearColor];
    immunizationText.textColor = APP_TEXT_COLOR;
    immunizationText.text = healthItem.immunization;
    immunizationText.lineBreakMode = NSLineBreakByWordWrapping;
    immunizationText.numberOfLines = 0;
    
    UILabel *immunizationTextContainer = [[UILabel alloc] initWithFrame:CGRectMake(0, transmissionTextContainer.frame.origin.y + transmissionSize.height + 55,  320, immunizationSize.height + 15)];
    immunizationTextContainer.layer.borderWidth = 1.0f;
    immunizationTextContainer.layer.borderColor = APP_BORDER_COLOR;
    immunizationTextContainer.backgroundColor = [UIColor clearColor];
    
    [immunizationTextContainer addSubview:immunizationText];
    [scrollView addSubview:immunizationTextContainer];
    
    if ([healthItem.category isEqualToString:@"medications"]) {
        transmissionTitleLabel.text = @"Side Effects";
        immunizationTitleLabel.text = @"Storage";
        [immunizationImageLabel setImage:[UIImage imageNamed:@"storage-icon"]];
    }
    
    if (([healthItem.category isEqualToString:@"conditions"]) || ([healthItem.category isEqualToString:@"symptoms"])) {
        transmissionTitleLabel.text = @"Symptoms";
        immunizationTitleLabel.text = @"Prevention/Treatment";
        
    }
    
    // THE IMPORTANT FIELD
    if (healthItem.important) {
        //there is an important field, must add
        UILabel *importantTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, immunizationTextContainer.frame.origin.y + immunizationSize.height + 22, 250, 25)];
        importantTitleLabel .font = [UIFont fontWithName:@"ProximaNova-Semibold" size:18];
        importantTitleLabel.backgroundColor = [UIColor clearColor];
        importantTitleLabel.textColor = APP_TEXT_COLOR;
        importantTitleLabel.text = @"Notes";
        [scrollView addSubview:importantTitleLabel];
        
        UIImageView  *importantImageLabel = [[UIImageView alloc] init];
        [importantImageLabel setImage:[UIImage imageNamed:@"conditions-icon"]];
        importantImageLabel.frame = CGRectMake(17, immunizationTextContainer.frame.origin.y + immunizationSize.height + 22, 20, 25);
        [scrollView addSubview:importantImageLabel];
        
        CGSize importantSize = [healthItem.important boundingRectWithSize:CGSizeMake(290, 15000)
                                                                        options:NSStringDrawingUsesLineFragmentOrigin
                                                                     attributes:@{NSParagraphStyleAttributeName:paragraphStyle.copy, NSFontAttributeName:[UIFont fontWithName:@"ProximaNova-Light" size:15]}
                                                                        context:nil].size;
        UILabel *importantText = [[UILabel alloc] initWithFrame:CGRectMake(15, 5,  290, importantSize.height + 5)];
        importantText.font = [UIFont fontWithName:@"ProximaNova-Light" size:15];
        importantText.backgroundColor = [UIColor clearColor];
        importantText.textColor = APP_TEXT_COLOR;
        importantText.text = healthItem.important;
        importantText.lineBreakMode = NSLineBreakByWordWrapping;
        importantText.numberOfLines = 0;
        
        UILabel *importantTextContainer = [[UILabel alloc] initWithFrame:CGRectMake(0, immunizationTextContainer.frame.origin.y + immunizationSize.height + 55,  320, importantSize.height + 15)];
        importantTextContainer.layer.borderWidth = 1.0f;
        importantTextContainer.layer.borderColor = APP_BORDER_COLOR;
        importantTextContainer.backgroundColor = [UIColor clearColor];
        
        [importantTextContainer addSubview:importantText];
        [scrollView addSubview:importantTextContainer];
        
        scrollView.contentSize = CGSizeMake(320, importantTextContainer.frame.origin.y + importantTextContainer.frame.size.height + 50);
        
    }
    else {
        scrollView.contentSize = CGSizeMake(320, immunizationTextContainer.frame.origin.y + immunizationTextContainer.frame.size.height + 50);
    }
    
}

- (void)AddTextBlockWithOffset:(NSInteger)offset withImageName:(NSString *)imageName withText:(NSString *)text {
    
}

@end

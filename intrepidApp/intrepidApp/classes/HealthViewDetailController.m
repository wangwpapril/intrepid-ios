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

    [self.view addSubview:scrollView];
    [self.view addSubview:healthItemNameLabel];
    
    [self addDescription];
    [self addSideEffects];
    
    [scrollView setScrollEnabled:YES];
    [scrollView setContentSize:CGSizeMake(320, 530)];
    
    //Change appearance of backbutton
    self.navigationItem.hidesBackButton=YES;
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(15, 7, 49, 29)];
    [back setImage:[UIImage imageNamed:@"back-button.png"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *back1 = [[UIBarButtonItem alloc] initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = back1;

    //Description and Side Effects images
    descriptionImageLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"stethoscope-pic.png"]];
    descriptionImageLabel.text = NULL;
    
    //Check which type of sideEffect it is
    if ([healthItemCategory isEqualToString:@"symptoms"]) {
        sideEffectsImageLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"heart-rate-pic.png"]];
    }
    else if ([healthItemCategory isEqualToString:@"conditions"]) {
        sideEffectsImageLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"conditions-pic.png"]];
    }
    else {
    sideEffectsImageLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"medication-pic.png"]];
    }
    sideEffectsImageLabel.text = NULL;

    
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    // Set Header label
    NSString *uppercaseString = [healthItemName uppercaseString];
    healthItemNameLabel.text = uppercaseString;
    healthItemNameLabel.font = [UIFont fontWithName:APP_FONT size:16];
    healthItemNameLabel.textAlignment = NSTextAlignmentCenter;
    healthItemNameLabel.backgroundColor = UIColorFromRGB(0x5f5957);
    healthItemNameLabel.textColor = UIColorFromRGB(0xeaf0e6);
    

    
	// Do any additional setup after loading the view.
}

-(void)back {
    // Tell the controller to go back
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addDescription {
    
    descriptionLabel.font = [UIFont fontWithName:APP_FONT size:17];
    descriptionLabel.backgroundColor = UIColorFromRGB(0xffffff);
    
    //Set descriptionText to auto-fit content
    descriptionText.font = [UIFont fontWithName:APP_FONT size:13];
    descriptionText.backgroundColor = UIColorFromRGB(0xffffff);
    [descriptionText setAlpha:0.5];
    descriptionText.layer.borderWidth = 1.0f;
    descriptionText.layer.borderColor = [[UIColor grayColor] CGColor];
    
    //Inset the descriptionText content
    descriptionText.contentInset = UIEdgeInsetsMake(0, 15.0f, 0, 0);
    
    CGRect frame = descriptionText.frame;
    UIEdgeInsets inset = descriptionText.contentInset;
    frame.size.height = descriptionText.contentSize.height + inset.top + inset.bottom;
    descriptionText.frame = frame;

}


- (void)addSideEffects {
    
    sideEffectsLabel.font = [UIFont fontWithName:APP_FONT size:17];
    sideEffectsLabel.backgroundColor = UIColorFromRGB(0xffffff);
    
    sideEffectsText.font = [UIFont fontWithName:APP_FONT size:13];
    sideEffectsText.backgroundColor = UIColorFromRGB(0xffffff);
    [sideEffectsText setAlpha:0.5];
    sideEffectsText.layer.borderWidth = 1.0f;
    sideEffectsText.layer.borderColor = [[UIColor grayColor] CGColor];
    
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

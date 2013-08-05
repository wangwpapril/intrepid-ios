

//
//  EmbassyDetailedViewViewController.m
//  intrepidApp
//
//  Created by Jon Carr-Harris on 7/30/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "EmbassyDetailedViewController.h"
#import "Constants.h"
#import <QuartzCore/QuartzCore.h>

@implementation EmbassyDetailedViewController


@synthesize embassyItem;
//@synthesize embassyDetailedItemNameLabel;
//@synthesize embassyDetailedItemTitleLabel;
//@synthesize embassyDetailedItem;



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.        
    CGRect imageFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    CGRect whiteFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    UIImageView *myImageView = [[UIImageView alloc] initWithFrame:imageFrame];
    [self.view addSubview: myImageView];
    UIView *whiteLayer = [[UIView alloc] initWithFrame:whiteFrame];
    whiteLayer.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteLayer];
    
    CGRect rect=CGRectMake(0, 37, 320, 520);
    scrollView = [[UIScrollView alloc] initWithFrame:rect];
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.scrollEnabled = YES;
    
    //Description and Side Effects images
    UIImageView  *descriptionImageLabel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"embassy-icon.png"]];
    descriptionImageLabel.frame = CGRectMake(5, 5, 25, 25);
    [scrollView addSubview:descriptionImageLabel];
    
    // Set Header label
    UILabel *embassyDetailedItemTitleLabel = [[UILabel alloc] init];
    embassyDetailedItemTitleLabel.frame = CGRectMake(0, 0, 320, 36);
    embassyDetailedItemTitleLabel.backgroundColor = [UIColor colorWithRed:66/255.0f green:58/255.0f blue:56/255.0f alpha:1];

    
    NSString *uppercaseString = [embassyItem.name uppercaseString];
    UILabel *embassyDetailedItemNameLabel = [[UILabel alloc] init];
    embassyDetailedItemNameLabel.frame = CGRectMake(20, 7, 275, 21);
    embassyDetailedItemNameLabel.text = uppercaseString;
    embassyDetailedItemNameLabel.backgroundColor = [UIColor clearColor];
    embassyDetailedItemNameLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:16];
    embassyDetailedItemNameLabel.textColor = [UIColor whiteColor];
    [embassyDetailedItemTitleLabel addSubview:embassyDetailedItemNameLabel];
    
    [self.view addSubview:embassyDetailedItemTitleLabel];
    [self addContent];
    [self.view addSubview:scrollView];
 
	// Do any additional setup after loading the view.
}

- (void)addContent {
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, -40, 120, 120)];
    descriptionLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:18];
    descriptionLabel.backgroundColor = [UIColor clearColor];
//    descriptionLabel.textColor = UIColorFromRGB(0x423a38);
    descriptionLabel.text = @"Description";
    
    //Set descriptionText to auto-fit content
    CGSize size = [embassyItem.description sizeWithFont:[UIFont fontWithName:@"ProximaNova-Light" size:14] constrainedToSize:CGSizeMake(280, 15000) lineBreakMode:NSLineBreakByWordWrapping];
    UILabel *descriptionText = [[UILabel alloc] initWithFrame:CGRectMake(20, 0,  280, size.height)];
    descriptionText.font = [UIFont fontWithName:@"ProximaNova-Light" size:14];
    descriptionText.backgroundColor = [UIColor clearColor];
    descriptionText.textColor = [UIColor blackColor];
    descriptionText.text = embassyItem.description;
    descriptionText.lineBreakMode = NSLineBreakByWordWrapping;
    descriptionText.numberOfLines = 0;
    
    UILabel *descriptionTextContainer = [[UILabel alloc] initWithFrame:CGRectMake(0, 40,  320, size.height + 5)];
    
    [scrollView addSubview:descriptionLabel];
    [descriptionTextContainer addSubview: descriptionText];
    [scrollView addSubview:descriptionTextContainer];
    
    scrollView.contentSize = CGSizeMake(320, descriptionTextContainer.frame.origin.y + 1000);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end



//
//  EmbassyDetailedViewViewController.m
//  intrepidApp
//
//  Created by Jon Carr-Harris on 7/30/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//



#import "EmbassyDetailedViewController.h"
#import "EmbassyDetailedItem.h"
#import "EmbassyDetailedContent.h"
#import "Constants.h"
#import <QuartzCore/QuartzCore.h>

@implementation EmbassyDetailedViewController

@synthesize embassyDetailedItemNameLabel;
@synthesize embassyDetailedItemTitleLabel;
@synthesize embassyDetailedItem;


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
    
    CGRect rect=CGRectMake(0, 35, 320, 520);
    scrollView = [[UIScrollView alloc] initWithFrame:rect];
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.scrollEnabled = YES;
    
    //Description and Side Effects images
    UIImageView  *descriptionImageLabel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"embassy-icon.png"]];
    descriptionImageLabel.frame = CGRectMake(5, 40, 25, 25);
    [scrollView addSubview:descriptionImageLabel];
    
    [self addContent];
    
    // Set Header label
    embassyDetailedItemTitleLabel.frame = CGRectMake(0, 0, 320, 35);
    embassyDetailedItemTitleLabel.backgroundColor = [UIColor darkGrayColor];
    embassyDetailedItemTitleLabel.text = NULL;
    
    NSString *uppercaseString = [embassyDetailedItem.name uppercaseString];
    embassyDetailedItemNameLabel.text = uppercaseString;
    embassyDetailedItemNameLabel.backgroundColor = [UIColor clearColor];
    embassyDetailedItemNameLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:16];
    embassyDetailedItemNameLabel.textColor = [UIColor blackColor];    
    [embassyDetailedItemTitleLabel addSubview:embassyDetailedItemNameLabel];
    [scrollView addSubview:embassyDetailedItemTitleLabel];
    [self.view addSubview:scrollView];

    
	// Do any additional setup after loading the view.
}

- (void)addContent {
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, -5, 120, 120)];    descriptionLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:18];
    descriptionLabel.backgroundColor = [UIColor clearColor];
//    descriptionLabel.textColor = UIColorFromRGB(0x423a38);
    descriptionLabel.text = @"Description";
    
    //Set descriptionText to auto-fit content
//    CGSize size = [embassyDetailedItem.description sizeWithFont:[UIFont systemFontOfSize:14]
//                                     constrainedToSize:CGSizeMake(320, 250)
//                                         lineBreakMode:NSLineBreakByWordWrapping];
    UITextView *descriptionText = [[UITextView alloc] initWithFrame:CGRectMake(0, 70,  320, self.view.frame.size.height)];
    descriptionText.font = [UIFont fontWithName:@"ProximaNova-Light" size:13];
//    descriptionText.backgroundColor = UIColorFromRGB(0xffffff);
//    descriptionText.textColor = APP_TEXT_COLOR;//UIColorFromRGB(0x423a38);
    descriptionText.textColor = [UIColor blackColor];
    descriptionText.text = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.\n\n\nExcepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium";
    descriptionText.scrollEnabled = NO;
    descriptionText.editable = NO;
    
    [scrollView addSubview:descriptionLabel];
    [scrollView addSubview:descriptionText];
    scrollView.contentSize = CGSizeMake(320, descriptionText.frame.origin.y + 10);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end



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
    [self.view addSubview:myImageView];
    UIView *whiteLayer = [[UIView alloc] initWithFrame:whiteFrame];
    whiteLayer.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteLayer];
    
    CGRect rect=CGRectMake(0, 0, 320, 520);
    scrollView = [[UIScrollView alloc] initWithFrame:rect];
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.scrollEnabled = YES;
    
    [self addContent];
    
    //Description and Side Effects images
    UIImageView  *descriptionImageLabel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"embassy-icon.png"]];
    descriptionImageLabel.frame = CGRectMake(5, 40, 25, 25);
    [scrollView addSubview:descriptionImageLabel];
    
    
    // Set Header label
//    embassyDetailedItemTitleLabel.backgroundColor = NAVIGATION_BG_COLOR;
    embassyDetailedItemTitleLabel.text = NULL;
    
    NSString *uppercaseString = [embassyDetailedItem.name uppercaseString];
    embassyDetailedItemNameLabel.text = uppercaseString;
    embassyDetailedItemNameLabel.backgroundColor = [UIColor clearColor];
    embassyDetailedItemNameLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:16];
//    embassyDetailedItemNameLabel.textColor = UIColorFromRGB(0xeaf0e6);
    
    [embassyDetailedItemTitleLabel addSubview:embassyDetailedItemNameLabel];
    [self.view addSubview:embassyDetailedItemTitleLabel];
    [self.view addSubview:scrollView];
    
	// Do any additional setup after loading the view.
}

- (void)addContent {
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, -5, 120, 120)]; // rly
    descriptionLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:18];
    descriptionLabel.backgroundColor = [UIColor clearColor];
//    descriptionLabel.textColor = UIColorFromRGB(0x423a38);
    descriptionLabel.text = @"Description";
    
    //Set descriptionText to auto-fit content
    CGSize size = [embassyDetailedItem.description sizeWithFont:[UIFont systemFontOfSize:15]
                                     constrainedToSize:CGSizeMake(320, self.view.bounds.size.height-100)
                                         lineBreakMode:NSLineBreakByWordWrapping];
    UITextView *descriptionText = [[UITextView alloc] initWithFrame:CGRectMake(0, 70,  320, size.height)];
    descriptionText.font = [UIFont fontWithName:@"ProximaNova-Light" size:14];
//    descriptionText.backgroundColor = UIColorFromRGB(0xffffff);
//    descriptionText.textColor = APP_TEXT_COLOR;//UIColorFromRGB(0x423a38);
    descriptionText.text = embassyDetailedItem.description;
    descriptionText.scrollEnabled = NO;
    descriptionText.editable = NO;
    descriptionText.layer.borderWidth = 1.0f;
    descriptionText.layer.borderColor = [[UIColor grayColor] CGColor];
    
    [scrollView addSubview:descriptionLabel];
    [scrollView addSubview: descriptionText];
    
    scrollView.contentSize = CGSizeMake(320, descriptionText.frame.origin.y + size.height +10);
    

//    if ([healthItem.category isEqualToString:@"embassy"]) {
//            
}
//
//- (void)AddTextBlockWithOffset:(NSInteger)offset withImageName:(NSString *)imageName withText:(NSString *)text {
//    
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

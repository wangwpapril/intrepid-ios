

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
    
    //ADDRESS
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 120, 120)];
    addressLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:16];
    addressLabel.backgroundColor = [UIColor clearColor];
    addressLabel.text = @"Address";
    
    CGSize size = [embassyItem.address sizeWithFont:[UIFont fontWithName:@"ProximaNova-Light" size:14] constrainedToSize:CGSizeMake(280, 15000) lineBreakMode:NSLineBreakByWordWrapping];
    UILabel *addressText = [[UILabel alloc] initWithFrame:CGRectMake(20, 121,  280, size.height)];
    addressText.font = [UIFont fontWithName:@"ProximaNova-Light" size:14];
    addressText.backgroundColor = [UIColor clearColor];
    addressText.textColor = [UIColor blackColor];
    addressText.text = embassyItem.address;
    addressText.lineBreakMode = NSLineBreakByWordWrapping;
    addressText.numberOfLines = 0;
    
    //TELEPHONE/FAX/EMAIL
    
    UILabel *contactLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 120, 120)];
    contactLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:16];
    contactLabel.backgroundColor = [UIColor clearColor];
    contactLabel.text = @"Telephone/Fax/Email";
    
    //what is the size?
    CGSize contactSize = [embassyItem.tel sizeWithFont:[UIFont fontWithName:@"ProximaNova-Light" size:14] constrainedToSize:CGSizeMake(280, 15000) lineBreakMode:NSLineBreakByWordWrapping];
    UILabel *contactText = [[UILabel alloc] initWithFrame:CGRectMake(20, 121,  280, size.height)];
    contactText.font = [UIFont fontWithName:@"ProximaNova-Light" size:14];
    contactText.backgroundColor = [UIColor clearColor];
    contactText.textColor = [UIColor blackColor];
    contactText.text = [NSString stringWithFormat:@"Tel:%@ Email:%@ Fax:%@", embassyItem.tel, embassyItem.fax, embassyItem.email];
    contactText.lineBreakMode = NSLineBreakByWordWrapping;
    contactText.numberOfLines = 0;
    
    //HOURS OF OPERATION
    
    UILabel *hoursLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 120, 120)];
    hoursLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:16];
    hoursLabel.backgroundColor = [UIColor clearColor];
    hoursLabel.text = @"Hours of Operation";
    
    CGSize hoursSize = [embassyItem.hours sizeWithFont:[UIFont fontWithName:@"ProximaNova-Light" size:14] constrainedToSize:CGSizeMake(280, 15000) lineBreakMode:NSLineBreakByWordWrapping];
    UILabel *hoursText = [[UILabel alloc] initWithFrame:CGRectMake(20, 121,  280, hoursSize.height)];
    hoursText.font = [UIFont fontWithName:@"ProximaNova-Light" size:14];
    hoursText.backgroundColor = [UIColor clearColor];
    hoursText.textColor = [UIColor blackColor];
    hoursText.text = embassyItem.hours;
    hoursText.lineBreakMode = NSLineBreakByWordWrapping;
    hoursText.numberOfLines = 0;
    
    //SERVICES OFFERED
    
    UILabel *servicesLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 120, 120)];
    servicesLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:16];
    servicesLabel.backgroundColor = [UIColor clearColor];
    servicesLabel.text = @"Services Offered";
    
    //this needs to be fixed once content is fixed
    CGSize servicesSize = [embassyItem.description sizeWithFont:[UIFont fontWithName:@"ProximaNova-Light" size:14] constrainedToSize:CGSizeMake(280, 15000) lineBreakMode:NSLineBreakByWordWrapping];
    UILabel *servicesText = [[UILabel alloc] initWithFrame:CGRectMake(20, 121,  280, servicesSize.height)];
    servicesText.font = [UIFont fontWithName:@"ProximaNova-Light" size:14];
    servicesText.backgroundColor = [UIColor clearColor];
    servicesText.textColor = [UIColor blackColor];
    servicesText.text = embassyItem.address;
    servicesText.lineBreakMode = NSLineBreakByWordWrapping;
    servicesText.numberOfLines = 0;
    
    //NOTES
    
    UILabel *notesLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 120, 120)];
    notesLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:16];
    notesLabel.backgroundColor = [UIColor clearColor];
    notesLabel.text = @"Notes";
    
    CGSize notesSize = [embassyItem.notice sizeWithFont:[UIFont fontWithName:@"ProximaNova-Light" size:14] constrainedToSize:CGSizeMake(280, 15000) lineBreakMode:NSLineBreakByWordWrapping];
    UILabel *notesText = [[UILabel alloc] initWithFrame:CGRectMake(20, 121,  280, notesSize.height)];
    notesText.font = [UIFont fontWithName:@"ProximaNova-Light" size:14];
    notesText.backgroundColor = [UIColor clearColor];
    notesText.textColor = [UIColor blackColor];
    notesText.text = embassyItem.notice;
    notesText.lineBreakMode = NSLineBreakByWordWrapping;
    notesText.numberOfLines = 0;
        
    //add all subviews to large container
    UILabel *embassyTextContainer = [[UILabel alloc] initWithFrame:CGRectMake(0, 40,  320, size.height + 5)];
    
    [embassyTextContainer addSubview:addressLabel];
    [embassyTextContainer addSubview: addressText];
    [scrollView addSubview:embassyTextContainer];
    
    scrollView.contentSize = CGSizeMake(320, embassyTextContainer.frame.origin.y + 1000);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end



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

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

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
    
    CGRect rect=CGRectMake(0, 36, 320, self.view.frame.size.height);
    scrollView = [[UIScrollView alloc] initWithFrame:rect];
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.scrollEnabled = YES;
    
    // Set Header label
    UILabel *embassyDetailedItemTitleLabel = [[UILabel alloc] init];
    embassyDetailedItemTitleLabel.frame = CGRectMake(0, 0, 320, 36);
    embassyDetailedItemTitleLabel.backgroundColor = [UIColor colorWithRed:66/255.0f green:58/255.0f blue:56/255.0f alpha:1];

    
    NSString *uppercaseString = [embassyItem.country uppercaseString];
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
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        
    } else {
        [self moveAllSubviewsDown];
    }
 
	// Do any additional setup after loading the view.
}

- (void)addContent {
    
    //ADDRESS
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 300, 30)];
    addressLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:16];
    addressLabel.backgroundColor = [UIColor clearColor];
    addressLabel.text = @"Address";
    
    CGSize size = [embassyItem.address sizeWithFont:[UIFont fontWithName:@"ProximaNova-Light" size:13] constrainedToSize:CGSizeMake(280, 15000) lineBreakMode:NSLineBreakByWordWrapping];
    UILabel *addressText = [[UILabel alloc] initWithFrame:CGRectMake(20, 30,  280, size.height + 30)];
    addressText.font = [UIFont fontWithName:@"ProximaNova-Light" size:15];
    addressText.backgroundColor = [UIColor clearColor];
    addressText.textColor = [UIColor blackColor];
    addressText.text = embassyItem.address;
    addressText.lineBreakMode = NSLineBreakByWordWrapping;
    addressText.numberOfLines = 0;
    
    //TELEPHONE/FAX/EMAIL

    UILabel *contactLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, addressText.frame.origin.y + size.height + 30, 300, 30)];
    contactLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:16];
    contactLabel.backgroundColor = [UIColor clearColor];
    contactLabel.text = @"Telephone/Fax/Email";
    
    NSString *contactLength = [NSString stringWithFormat:@"%@\nFax:%@\nEmail:%@", embassyItem.phone,
                               embassyItem.fax, embassyItem.email];
    
    CGSize contactSize = [contactLength sizeWithFont:[UIFont fontWithName:@"ProximaNova-Light" size:13] constrainedToSize:CGSizeMake(280, 15000) lineBreakMode:NSLineBreakByWordWrapping];
    UILabel *contactText = [[UILabel alloc] initWithFrame:CGRectMake(20, contactLabel.frame.origin.y + 30,  280, contactSize.height + 30)];
    contactText.font = [UIFont fontWithName:@"ProximaNova-Light" size:15];
    contactText.backgroundColor = [UIColor clearColor];
    contactText.textColor = [UIColor blackColor];
    contactText.text = [NSString stringWithFormat:@"%@\nFax: %@\nEmail: %@", embassyItem.phone, embassyItem.fax, embassyItem.email];
    contactText.lineBreakMode = NSLineBreakByWordWrapping;
    contactText.numberOfLines = 0;
    
    //HOURS OF OPERATION
    
    UILabel *hoursLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, contactText.frame.origin.y + contactSize.height + 30, 300, 30)];
    hoursLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:16];
    hoursLabel.backgroundColor = [UIColor clearColor];
    hoursLabel.text = @"Hours of Operation";
    
    CGSize hoursSize = [embassyItem.hours sizeWithFont:[UIFont fontWithName:@"ProximaNova-Light" size:13] constrainedToSize:CGSizeMake(280, 15000) lineBreakMode:NSLineBreakByWordWrapping];
    UILabel *hoursText = [[UILabel alloc] initWithFrame:CGRectMake(20, hoursLabel.frame.origin.y + 30,  280, hoursSize.height + 30)];
    hoursText.font = [UIFont fontWithName:@"ProximaNova-Light" size:15];
    hoursText.backgroundColor = [UIColor clearColor];
    hoursText.textColor = [UIColor blackColor];
    hoursText.text = embassyItem.hours;
    hoursText.lineBreakMode = NSLineBreakByWordWrapping;
    hoursText.numberOfLines = 0;
    
    //SERVICES OFFERED
    
    UILabel *servicesLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, hoursText.frame.origin.y + hoursSize.height + 30, 300, 30)];
    servicesLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:16];
    servicesLabel.backgroundColor = [UIColor clearColor];
    servicesLabel.text = @"Services Offered";
    
    //this needs to be fixed once content is fixed
    CGSize servicesSize = [embassyItem.services sizeWithFont:[UIFont fontWithName:@"ProximaNova-Light" size:13] constrainedToSize:CGSizeMake(280, 15000) lineBreakMode:NSLineBreakByWordWrapping];
    UILabel *servicesText = [[UILabel alloc] initWithFrame:CGRectMake(20, servicesLabel.frame.origin.y - 60,  280, servicesSize.height + 250)];
    servicesText.font = [UIFont fontWithName:@"ProximaNova-Light" size:15];
    servicesText.backgroundColor = [UIColor clearColor];
    servicesText.textColor = [UIColor blackColor];
    servicesText.text = embassyItem.services;
    servicesText.lineBreakMode = NSLineBreakByWordWrapping;
    servicesText.numberOfLines = 0;
    
    //NOTES
    
    UILabel *notesLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, servicesText.frame.origin.y + servicesSize.height + 160, 300, 30)];
    notesLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:16];
    notesLabel.backgroundColor = [UIColor clearColor];
    notesLabel.text = @"Notes";
    
    CGSize notesSize = [embassyItem.notes sizeWithFont:[UIFont fontWithName:@"ProximaNova-Light" size:14] constrainedToSize:CGSizeMake(280, 15000) lineBreakMode:NSLineBreakByWordWrapping];
    UILabel *notesText = [[UILabel alloc] initWithFrame:CGRectMake(20, notesLabel.frame.origin.y + 20,  280, notesSize.height + 30)];
    notesText.font = [UIFont fontWithName:@"ProximaNova-Light" size:15];
    notesText.backgroundColor = [UIColor clearColor];
    notesText.textColor = [UIColor blackColor];
    notesText.text = embassyItem.notes;
    notesText.lineBreakMode = NSLineBreakByWordWrapping;
    notesText.numberOfLines = 0;
        
    //add all subviews to large container
    UILabel *embassyTextContainer = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,  320, notesText.frame.origin.y + notesSize.height + 50)];
    
    [embassyTextContainer addSubview:addressLabel];
    [embassyTextContainer addSubview:addressText];
    [embassyTextContainer addSubview:contactLabel];
    [embassyTextContainer addSubview:contactText];
    [embassyTextContainer addSubview:hoursLabel];
    [embassyTextContainer addSubview:hoursText];
    [embassyTextContainer addSubview:servicesLabel];
    [embassyTextContainer addSubview:servicesText];
    [embassyTextContainer addSubview:notesLabel];
    [embassyTextContainer addSubview:notesText];
    [scrollView addSubview:embassyTextContainer];
    
    scrollView.contentSize = CGSizeMake(320, notesText.frame.origin.y + notesSize.height + 115);
}

- (void) moveAllSubviewsDown{
    float barHeight = 45.0;
    for (UIView *view in self.view.subviews) {
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + barHeight, view.frame.size.width, view.frame.size.height - barHeight);
        } else {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + barHeight, view.frame.size.width, view.frame.size.height);
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

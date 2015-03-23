

//
//  EmbassyDetailedViewViewController.m
//  intrepidApp
//
//  Created by Jon Carr-Harris on 7/30/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "EmbassyDetailedViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation EmbassyDetailedViewController

@synthesize embassyItem;

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
    
    CGRect rect = CGRectMake(0, 0, 320, self.view.frame.size.height);
    scrollView = [[UIScrollView alloc] initWithFrame:rect];
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.scrollEnabled = YES;
    
    // Set Header label
    // UILabel *embassyDetailedItemTitleLabel = [[UILabel alloc] init];
    //embassyDetailedItemTitleLabel.frame = CGRectMake(0, 0, 320, 36);
    // embassyDetailedItemTitleLabel.backgroundColor = [UIColor colorWithRed:66/255.0f green:58/255.0f blue:56/255.0f alpha:1];
    
    // NSString *uppercaseString = [embassyItem.country uppercaseString];
    // UILabel *embassyDetailedItemNameLabel = [[UILabel alloc] init];
    // embassyDetailedItemNameLabel.frame = CGRectMake(20, 7, 275, 21);
    // embassyDetailedItemNameLabel.text = uppercaseString;
    // embassyDetailedItemNameLabel.backgroundColor = [UIColor clearColor];
    // embassyDetailedItemNameLabel.font = [UIFont fontWithName:APP_FONT size:16];
    // embassyDetailedItemNameLabel.textColor = [UIColor whiteColor];
    // [embassyDetailedItemTitleLabel addSubview:embassyDetailedItemNameLabel];
    // [self.view addSubview:embassyDetailedItemTitleLabel];
    
    self.navigationItem.title = embassyItem.country;
    [self addContent];
    [self.view addSubview:scrollView];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    } else {
        [self moveAllSubviewsDown];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[SEGAnalytics sharedAnalytics] screen:@"Embassy Detail"];
}

- (void)addContent {
    int y = 10;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    
    if (![embassyItem.address isEqualToString:@""]) {
        UIImageView  *embassyImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"embassy-icon"]];
        embassyImageView.frame = CGRectMake(14, y + 4, 25, 25);
        
        UILabel *embassyLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, y + 5, 250, 25)];
        embassyLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:18];
        embassyLabel.backgroundColor = [UIColor clearColor];
        embassyLabel.textColor = APP_TEXT_COLOR;
        embassyLabel.text = @"Address";
        
        NSString *content = embassyItem.address;
        CGSize size = [content boundingRectWithSize:CGSizeMake(290, 15000)
                                                        options:NSStringDrawingUsesLineFragmentOrigin
                                                     attributes:@{NSParagraphStyleAttributeName:paragraphStyle.copy, NSFontAttributeName:[UIFont fontWithName:@"ProximaNova-Light" size:15]}
                                                        context:nil].size;
        UILabel *embassyText = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 290, size.height + 5)];
        embassyText.font = [UIFont fontWithName:@"ProximaNova-Light" size:15];
        embassyText.backgroundColor = [UIColor clearColor];
        embassyText.textColor = APP_TEXT_COLOR;
        embassyText.text = content;
        embassyText.lineBreakMode = NSLineBreakByWordWrapping;
        embassyText.numberOfLines = 0;
        
        UIView *embassyTextContainer = [[UIView alloc] initWithFrame:CGRectMake(0, y + 35, 320, size.height + 15)];
        embassyTextContainer.layer.borderWidth = 1.0f;
        embassyTextContainer.layer.borderColor = APP_BORDER_COLOR;
        embassyTextContainer.backgroundColor = [UIColor clearColor];
        
        [scrollView addSubview:embassyImageView];
        [scrollView addSubview:embassyLabel];
        [embassyTextContainer addSubview:embassyText];
        [scrollView addSubview:embassyTextContainer];
        y = embassyTextContainer.frame.origin.y + size.height + 20;
    }
    
    if (![embassyItem.phone isEqualToString:@""] || ![embassyItem.fax isEqualToString:@""] || ![embassyItem.email isEqualToString:@""] || ![embassyItem.website isEqualToString:@""]) {
        UIImageView  *embassyImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"contact_icon"]];
        embassyImageView2.frame = CGRectMake(14, y + 4, 25, 25);
        
        UILabel *embassyLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(50, y + 5, 250, 25)];
        embassyLabel2.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:18];
        embassyLabel2.backgroundColor = [UIColor clearColor];
        embassyLabel2.text = @"Contact Info";
        embassyLabel2.textColor = APP_TEXT_COLOR;
        y += 35;
        
        UIView *contactContainer = [[UIView alloc] initWithFrame:CGRectMake(0, y, 320, 1)];
        contactContainer.layer.borderWidth = 1.0f;
        contactContainer.layer.borderColor = APP_BORDER_COLOR;
        contactContainer.backgroundColor = [UIColor clearColor];
        
        NSMutableArray *contactArray = [NSMutableArray new];
        if (![embassyItem.phone isEqualToString:@""]) {
            [contactArray addObject:[NSString stringWithFormat:@"Phone: %@", embassyItem.phone]];
        }
        if (![embassyItem.fax isEqualToString:@""]) {
            [contactArray addObject:[NSString stringWithFormat:@"Fax: %@", embassyItem.fax]];
        }
        if (![embassyItem.email isEqualToString:@""]) {
            [contactArray addObject:[NSString stringWithFormat:@"Email: %@", embassyItem.email]];
        }
        if (![embassyItem.website isEqualToString:@""]) {
            [contactArray addObject:[NSString stringWithFormat:@"Website: %@", embassyItem.website]];
        }
        
        for (id item in contactArray) {
            UITextView *contactView = [[UITextView alloc] initWithFrame:CGRectMake(15, y, 290, 25)];
            contactView.font = [UIFont fontWithName:@"ProximaNova-Light" size:15];
            contactView.backgroundColor = [UIColor clearColor];
            contactView.textColor = APP_TEXT_COLOR;
            contactView.editable = NO;
            contactView.scrollEnabled = NO;
            contactView.selectable = YES;
            contactView.dataDetectorTypes = UIDataDetectorTypeAll;
            contactView.text = item;
            [contactView sizeToFit];
            [contactView layoutIfNeeded];
            [scrollView addSubview:contactView];
            y += contactView.frame.size.height;
        }
        
        UIView *contactContainer2 = [[UIView alloc] initWithFrame:CGRectMake(0, y + 15, 320, 1)];
        contactContainer2.layer.borderWidth = 1.0f;
        contactContainer2.layer.borderColor = APP_BORDER_COLOR;
        contactContainer2.backgroundColor = [UIColor clearColor];
        
        [scrollView addSubview:embassyImageView2];
        [scrollView addSubview:embassyLabel2];
        [scrollView addSubview:contactContainer];
        [scrollView addSubview:contactContainer2];
        y += 20;
    }
    
    if (![embassyItem.hours isEqualToString:@""]) {
        UIImageView  *embassyImageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hours_icon"]];
        embassyImageView3.frame = CGRectMake(14, y + 4, 25, 25);
        
        UILabel *embassyLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(50, y + 5, 250, 25)];
        embassyLabel3.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:18];
        embassyLabel3.backgroundColor = [UIColor clearColor];
        embassyLabel3.text = @"Hours of Operation";
        embassyLabel3.textColor = APP_TEXT_COLOR;
        
        NSString *content3 = embassyItem.hours;
        CGSize size3 = [content3 boundingRectWithSize:CGSizeMake(290, 15000)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{NSParagraphStyleAttributeName:paragraphStyle.copy, NSFontAttributeName:[UIFont fontWithName:@"ProximaNova-Light" size:15]}
                                              context:nil].size;
        UILabel *embassyText3 = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 290, size3.height + 5)];
        embassyText3.font = [UIFont fontWithName:@"ProximaNova-Light" size:15];
        embassyText3.backgroundColor = [UIColor clearColor];
        embassyText3.textColor = APP_TEXT_COLOR;
        embassyText3.text = content3;
        embassyText3.lineBreakMode = NSLineBreakByWordWrapping;
        embassyText3.numberOfLines = 0;
        
        UIView *embassyTextContainer3 = [[UIView alloc] initWithFrame:CGRectMake(0, y + 35, 320, size3.height + 15)];
        embassyTextContainer3.layer.borderWidth = 1.0f;
        embassyTextContainer3.layer.borderColor = APP_BORDER_COLOR;
        embassyTextContainer3.backgroundColor = [UIColor clearColor];
        
        [scrollView addSubview:embassyImageView3];
        [scrollView addSubview:embassyLabel3];
        [embassyTextContainer3 addSubview:embassyText3];
        [scrollView addSubview:embassyTextContainer3];
        y = embassyTextContainer3.frame.origin.y + size3.height + 20;
    }

    if (![embassyItem.services isEqualToString:@""]) {
        UIImageView  *embassyImageView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"embassy-icon"]];
        embassyImageView4.frame = CGRectMake(14, y + 4, 25, 25);
        
        UILabel *embassyLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(50, y + 5, 250, 25)];
        embassyLabel4.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:18];
        embassyLabel4.backgroundColor = [UIColor clearColor];
        embassyLabel4.text = @"Services Offered";
        embassyLabel4.textColor = APP_TEXT_COLOR;
        
        NSString *content4 = embassyItem.services;
        CGSize size4 = [content4 boundingRectWithSize:CGSizeMake(290, 15000)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{NSParagraphStyleAttributeName:paragraphStyle.copy, NSFontAttributeName:[UIFont fontWithName:@"ProximaNova-Light" size:15]}
                                              context:nil].size;
        UILabel *embassyText4 = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 290, size4.height + 5)];
        embassyText4.font = [UIFont fontWithName:@"ProximaNova-Light" size:15];
        embassyText4.backgroundColor = [UIColor clearColor];
        embassyText4.textColor = APP_TEXT_COLOR;
        embassyText4.text = content4;
        embassyText4.lineBreakMode = NSLineBreakByWordWrapping;
        embassyText4.numberOfLines = 0;
        
        UIView *embassyTextContainer4 = [[UIView alloc] initWithFrame:CGRectMake(0, y + 35, 320, size4.height + 15)];
        embassyTextContainer4.layer.borderWidth = 1.0f;
        embassyTextContainer4.layer.borderColor = APP_BORDER_COLOR;
        embassyTextContainer4.backgroundColor = [UIColor clearColor];
        
        [scrollView addSubview:embassyImageView4];
        [scrollView addSubview:embassyLabel4];
        [embassyTextContainer4 addSubview:embassyText4];
        [scrollView addSubview:embassyTextContainer4];
        y = embassyTextContainer4.frame.origin.y + size4.height + 20;
    }
    
    if (![embassyItem.notes isEqualToString:@""]) {
        UIImageView  *embassyImageView5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"embassy-icon"]];
        embassyImageView5.frame = CGRectMake(14, y + 4, 25, 25);
        
        UILabel *embassyLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(50, y + 5, 250, 25)];
        embassyLabel5.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:18];
        embassyLabel5.backgroundColor = [UIColor clearColor];
        embassyLabel5.text = @"Notes";
        embassyLabel5.textColor = APP_TEXT_COLOR;
        
        NSString *content5 = embassyItem.notes;
        UITextView *notesView = [[UITextView alloc] initWithFrame:CGRectMake(15, 5, 290, 25)];
        notesView.font = [UIFont fontWithName:@"ProximaNova-Light" size:15];
        notesView.backgroundColor = [UIColor clearColor];
        notesView.textColor = APP_TEXT_COLOR;
        notesView.editable = NO;
        notesView.scrollEnabled = NO;
        notesView.selectable = YES;
        notesView.dataDetectorTypes = UIDataDetectorTypeAll;
        notesView.text = content5;
        [notesView sizeToFit];
        [notesView layoutIfNeeded];
    
        UIView *embassyTextContainer5 = [[UIView alloc] initWithFrame:CGRectMake(0, y + 35, 320, notesView.frame.size.height + 15)];
        embassyTextContainer5.layer.borderWidth = 1.0f;
        embassyTextContainer5.layer.borderColor = APP_BORDER_COLOR;
        embassyTextContainer5.backgroundColor = [UIColor clearColor];
        
        [scrollView addSubview:embassyImageView5];
        [scrollView addSubview:embassyLabel5];
        [embassyTextContainer5 addSubview:notesView];
        [scrollView addSubview:embassyTextContainer5];
        y = embassyTextContainer5.frame.origin.y + notesView.frame.size.height + 20;
    }
    
    scrollView.contentSize = CGSizeMake(320, y + 80);
}

- (void)moveAllSubviewsDown {
    float barHeight = 45.0;
    for (UIView *view in self.view.subviews) {
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + barHeight, view.frame.size.width, view.frame.size.height - barHeight);
        } else {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + barHeight, view.frame.size.width, view.frame.size.height);
        }
    }
}

@end

//
//  PrivacyPolicyViewController.m
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-30.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "PrivacyPolicyViewController.h"

@interface PrivacyPolicyViewController ()

@end

@implementation PrivacyPolicyViewController

@synthesize exitButton;

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
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"signup-background"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    //create title label
    UILabel *legalLabel = [[UILabel alloc] init];
    legalLabel.frame = CGRectMake(10, self.view.frame.origin.y - 35, 300, 150);
    legalLabel.text = @"Terms of Service";
    legalLabel.font = [UIFont fontWithName:APP_FONT size:24];
    legalLabel.textColor = [UIColor whiteColor];
    legalLabel.backgroundColor = [UIColor clearColor];
    [legalLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:legalLabel];
    
    exitButton.frame = CGRectMake(280, 32, 40, 40);
    [self.view addSubview:exitButton];
    UIImage *exitImage = [UIImage imageNamed:@"close"];
    //create an image and put it overtop of the button?
    UIImageView *exitImageContainer = [[UIImageView alloc] initWithFrame: CGRectMake(290, 32, 15, 15)];
    [exitImageContainer setImage:exitImage];
    [self.view addSubview:exitImageContainer];
    
    CGRect rect=CGRectMake(0, 75, 320, self.view.frame.size.height);
    scrollView = [[UIScrollView alloc] initWithFrame:rect];
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.scrollEnabled = YES;
    
    UITextView *privacyPolicy = [[UITextView alloc] init];
    privacyPolicy.frame = CGRectMake(0, 10, 320, 500);
    privacyPolicy.text = @"No personal information is collected about you on this site except where you voluntarily disclose it. When you voluntarily disclose your personal information on this site, it will be used for the sole purpose of communicating with you to respond to a request or to provide information. Intrepid 24/7 will not sell, rent, or lease your personal information to any third parties. Intrepid 24/7 may access, use, and/or disclose your personal information if required by law. We may also do so where we have reasonable grounds to believe that such access or disclosure is necessary to prevent or investigate any breach of this Agreement or contravention of a law, or in urgent circumstances to protect the life, health, or security of any person. Intrepid 24/7 may also disclose your Personal Information to its successor or any assignee, as necessary, without notice to you provided that that successor or assignee agrees to comply with the then current version of this Privacy Policy. Intrepid 24/7 is committed to protecting the security of your personal information. Intrepid 24/7 uses a variety of security and information technologies and procedures to help protect your personal information from unauthorized access, use, or disclosure.";
    privacyPolicy.editable = NO;
    privacyPolicy.font = [UIFont fontWithName:@"ProximaNova-Light" size:13];
    privacyPolicy.backgroundColor = [UIColor clearColor];
    privacyPolicy.textColor = [UIColor whiteColor];
    privacyPolicy.scrollEnabled = NO;
    privacyPolicy.textAlignment = NSTextAlignmentCenter;
    
    [scrollView addSubview:privacyPolicy];
    
    [self.view addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(320, privacyPolicy.frame.size.height);
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    } else {
        [self moveAllSubviewsDown];
    }
}

- (void)moveAllSubviewsDown{
    float barHeight = 45.0;
    for (UIView *view in self.view.subviews) {
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + barHeight, view.frame.size.width, view.frame.size.height - barHeight);
        } else {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + barHeight, view.frame.size.width, view.frame.size.height);
        }
    }
}

- (IBAction)exit:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

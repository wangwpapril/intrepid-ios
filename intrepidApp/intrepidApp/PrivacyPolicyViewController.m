//
//  PrivacyPolicyViewController.m
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-30.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "PrivacyPolicyViewController.h"
#import "Constants.h"

@interface PrivacyPolicyViewController ()

@end

@implementation PrivacyPolicyViewController

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
    
    UITextView *privacyPolicy = [[UITextView alloc] init];
    privacyPolicy.frame = CGRectMake(0, 10, 320, self.view.frame.size.height);
    privacyPolicy.text = @"No personal information is collected about you on this site except where you voluntarily disclose it. When you voluntarily disclose your personal information on this site, it will be used for the sole purpose of communicating with you to respond to a request or to provide information. Intrepid 24/7 will not sell, rent, or lease your personal information to any third parties. Intrepid 24/7 may access, use, and/or disclose your personal information if required by law. We may also do so where we have reasonable grounds to believe that such access or disclosure is necessary to prevent or investigate any breach of this Agreement or contravention of a law, or in urgent circumstances to protect the life, health, or security of any person. Intrepid 24/7 may also disclose your Personal Information to its successor or any assignee, as necessary, without notice to you provided that that successor or assignee agrees to comply with the then current version of this Privacy Policy. Intrepid 24/7 is committed to protecting the security of your personal information. Intrepid 24/7 uses a variety of security and information technologies and procedures to help protect your personal information from unauthorized access, use, or disclosure.";
    privacyPolicy.editable = NO;
    privacyPolicy.font = [UIFont fontWithName:@"ProximaNova-Light" size:13];
    privacyPolicy.backgroundColor = [UIColor clearColor];
    privacyPolicy.textColor = [UIColor whiteColor];
    privacyPolicy.scrollEnabled = NO;
    privacyPolicy.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:privacyPolicy];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

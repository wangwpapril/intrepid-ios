//
//  AceWebViewController.m
//  intrepidApp
//
//  Created by Chaitanya Shah on 2015-02-03.
//  Copyright (c) 2015 JonCarrHarris Consulting. All rights reserved.
//

#import "AceWebViewController.h"
#import "Reachability.h"

@interface AceWebViewController ()

@end

@implementation AceWebViewController
@synthesize trialView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    trialView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height - 44)];  // status & nav
    trialView.scalesPageToFit = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    
    if(internetStatus == NotReachable) {
        UIAlertView *errorView;
        
        errorView = [[UIAlertView alloc]
                     initWithTitle: NSLocalizedString(@"Network error", @"Network error")
                     message: NSLocalizedString(@"No internet connection found", @"Network error")
                     delegate: self
                     cancelButtonTitle: NSLocalizedString(@"Close", @"Network error") otherButtonTitles: nil];
        
        [errorView show];
    }
}

- (void)setupWithTitle:(NSString *)title withURL:(NSString *)url {
    [self.view addSubview:trialView];
    self.navigationItem.title = title;
    [trialView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

@end

//
//  WebViewController.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/25/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "WebViewController.h"
#import "MenuController.h"
#import "Reachability.h"

@implementation WebViewController
@synthesize mController;
@synthesize trialView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    trialView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height - 44)];  // status & nav
    mController = [MenuController getInstance];
    trialView.scalesPageToFit = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [mController displayMenuWithParent:self];
    
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

- (void)setupWithTitle: (NSString *)title withURL:(NSString *)url {
    [self.view addSubview:trialView];
    self.navigationItem.title = title;
    [trialView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]]; // make custom (NSString string w/ format, must see URLS's first tho)
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

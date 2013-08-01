//
//  WebViewController.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/25/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "WebViewController.h"
#import "MenuController.h"

@implementation WebViewController
@synthesize mController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    mController = [MenuController getInstance];
}

- (void)viewWillAppear:(BOOL)animated {
    [mController displayMenuWithParent:self];
}

- (void)setupWithTitle: (NSString *)title withURL:(NSString *)url {
    
    self.navigationItem.title = title;
    UIWebView *trialView = [[UIWebView alloc] initWithFrame:self.view.bounds];  //Change self.view.bounds to a smaller CGRect if you don't want it to take up the whole screen
    [trialView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]]; // make custom (NSString string w/ format, must see URLS's first tho)
    [self.view addSubview:trialView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

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
    self.navigationItem.hidesBackButton = YES;
     self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];

    mController = [MenuController getInstance];
}

- (void)viewWillAppear:(BOOL)animated {
    [mController displayMenuWithParent:self];
}

- (void)setupWithTitle: (NSString *)title withURL:(NSString *)url {
    
    self.navigationItem.title = title;
    UIWebView *trialView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height - 44)];  // status & nav
    [trialView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]]; // make custom (NSString string w/ format, must see URLS's first tho)
    [self.view addSubview:trialView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

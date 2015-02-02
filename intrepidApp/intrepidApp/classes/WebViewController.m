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
#import "TripManager.h"

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

- (void)setupWithTitle:(NSString *)title withURL:(NSString *)url {
    [self.view addSubview:trialView];
    
    TripManager *manager = [TripManager getInstance];
    if ([title isEqualToString:@"ACE Worldview"] && manager.currentUser[@"user"][@"company"][@"content"] != [NSNull null] && ![manager.currentUser[@"user"][@"company"][@"content"] isEqual:@""]) {
        if (manager.currentUser[@"user"][@"company"][@"content"][@"virtual_wallet_pdf"] != [NSNull null] && ![manager.currentUser[@"user"][@"company"][@"content"][@"virtual_wallet_pdf"] isEqual:@""]) {
            self.navigationItem.title = @"ACE Insurance";
            UIActionSheet *aceOptions = [[UIActionSheet alloc] initWithTitle:nil
                                                                    delegate:self
                                                           cancelButtonTitle:@"Cancel"
                                                      destructiveButtonTitle:nil
                                                           otherButtonTitles:title, @"Virtual Wallet PDF", nil];
            [aceOptions showInView:self.view];
        } else {
            self.navigationItem.title = title;
            [trialView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
        }
    } else {
        self.navigationItem.title = title;
        [trialView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            self.navigationItem.title = [actionSheet buttonTitleAtIndex:buttonIndex];
            [trialView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.aceworldview.com/WVEnt/WorldView/ADLogin"]]];
            break;
            
        case 1:
            self.navigationItem.title = [actionSheet buttonTitleAtIndex:buttonIndex];
            [trialView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[TripManager getInstance].currentUser[@"user"][@"company"][@"content"][@"virtual_wallet_pdf"]]]];
            break;
            
        default:
            break;
    }
}

@end

//
//  AceViewController.m
//  intrepidApp
//
//  Created by Chaitanya Shah on 2015-02-03.
//  Copyright (c) 2015 JonCarrHarris Consulting. All rights reserved.
//

#import "AceViewController.h"
#import "TripManager.h"
#import "AceWebViewController.h"

@interface AceViewController ()

@end

@implementation AceViewController
@synthesize mController;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.tag = 5;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    mController = [MenuController getInstance];
    
    NSDictionary *userDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDict"];
    if (![userDict[@"user"][@"company"][@"content"] isEqual:@""]) {
        if (![userDict[@"user"][@"company"][@"content"][@"virtual_wallet_pdf"] isEqual:@""]) {
        } else {
            self.pdfButton.hidden = YES;
        }
    } else {
        self.pdfButton.hidden = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[SEGAnalytics sharedAnalytics] screen:@"ACE Insurance"];
    
    mController = [MenuController getInstance];
    [mController displayMenuWithParent:self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toWorldview"]) {
        AceWebViewController *awvc = segue.destinationViewController;
        [awvc setupWithTitle:@"ACE Worldview" withURL:@"https://www.aceworldview.com/WVEnt/WorldView/ADLogin"];
        [[SEGAnalytics sharedAnalytics] screen:@"ACE Worldview"];
    } else if ([segue.identifier isEqualToString:@"toWallet"]) {
        AceWebViewController *awvc = segue.destinationViewController;
        NSDictionary *userDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDict"];
        [awvc setupWithTitle:@"ACE Information" withURL:userDict[@"user"][@"company"][@"content"][@"virtual_wallet_pdf"]];
        [[SEGAnalytics sharedAnalytics] screen:@"ACE Information"];
    }
}

@end

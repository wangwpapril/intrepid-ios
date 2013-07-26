//
//  ClinicViewController.m
//  intrepidApp
//
//  Created by Jon Carr-Harris on 7/25/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "ClinicViewController.h"

@implementation ClinicViewController
@synthesize webView;

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
        self.navigationItem.title = @"Clinics";
        UIWebView *trialView = [[UIWebView alloc] initWithFrame:self.view.bounds];  //Change self.view.bounds to a smaller CGRect if you don't want it to take up the whole screen
        [trialView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.intrepid247.com/m/ppn?region=latinamerica&country=Mexico&city=mexico"]]];
        [self.view addSubview:trialView];
//        [webView loadRequest:[NSURLRequest requestWithURL:
//        [NSURL URLWithString:@"http://m.intrepid247.com/m/ppn?region=latinamerica&country=Mexico&city=mexico city"]]];

// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

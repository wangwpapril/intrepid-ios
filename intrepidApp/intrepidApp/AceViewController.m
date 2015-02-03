//
//  AceViewController.m
//  intrepidApp
//
//  Created by Chaitanya Shah on 2015-02-03.
//  Copyright (c) 2015 JonCarrHarris Consulting. All rights reserved.
//

#import "AceViewController.h"
#import "MenuController.h"

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
}

- (void)viewWillAppear:(BOOL)animated {
    mController = [MenuController getInstance];
    [mController displayMenuWithParent:self];
}

- (IBAction)aceAction:(id)sender {
}

- (IBAction)pdfAction:(id)sender {
}

@end

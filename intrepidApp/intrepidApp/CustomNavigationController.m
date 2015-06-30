//
//  CustomNavigationController.m
//  intrepidApp
//
//  Created by Chaitanya Shah on 2015-06-24.
//  Copyright (c) 2015 JonCarrHarris Consulting. All rights reserved.
//

#import "CustomNavigationController.h"
#import "MenuController.h"
#import "TripsViewController.h"
#import "AssistanceViewController.h"
#import "SignUpViewController.h"

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (UIViewController* viewController in self.viewControllers) {
        if (![viewController isKindOfClass:[AssistanceViewController class]] && ![viewController isKindOfClass:[SignUpViewController class]]) {
            // Push is not called this controller is created as part of the storyboard
            [self addButton:viewController.navigationItem];
        }
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (![viewController isKindOfClass:[AssistanceViewController class]] && ![viewController isKindOfClass:[SignUpViewController class]]) {
        [self addButton:viewController.navigationItem];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)addButton:(UINavigationItem *)item{
    if (item.rightBarButtonItem == nil){
        item.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"emergency-assistance"] style:UIBarButtonItemStylePlain target:self action:@selector(callAssistance)];
    }
}

- (void)callAssistance {
    if ([self.viewControllers.lastObject isKindOfClass:[TripsViewController class]]) {
        AssistanceViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"assistance"];
        viewController.tripsAssistance = true;
        [self pushViewController:viewController animated:YES];
    } else {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 6;
        [[MenuController getInstance] goToController:button];
    }
}

@end

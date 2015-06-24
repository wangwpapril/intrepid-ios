//
//  CustomNavigationController.m
//  intrepidApp
//
//  Created by Chaitanya Shah on 2015-06-24.
//  Copyright (c) 2015 JonCarrHarris Consulting. All rights reserved.
//

#import "CustomNavigationController.h"

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (UIViewController* viewController in self.viewControllers){
        // Push is not called this controller is created as part of the storyboard
        [self addButton:viewController.navigationItem];
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [self addButton:viewController.navigationItem];
    [super pushViewController:viewController animated:animated];
}

- (void)addButton:(UINavigationItem *)item{
    if (item.rightBarButtonItem == nil){
        item.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"emergency-assistance"] style:UIBarButtonItemStylePlain target:self action:@selector(callAssistance)];
    }
}

- (void)callAssistance
{
    //    NSDictionary *userDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDict"];
    //    NSArray *providers = userDict[@"user"][@"company"][@"assistance_providers"];
    //    if (providers.count > 0) {
    //        UIActionSheet *assitanceSheet = [[UIActionSheet alloc] init];
    //        assitanceSheet.title = @"Call";
    //        assitanceSheet.delegate = self;
    //        for (id assistance in providers) {
    //            NSString *formattedNum = [assistance[@"phone"] stringByReplacingOccurrencesOfString:@" " withString:@""];
    //            [assitanceSheet addButtonWithTitle:[NSString stringWithFormat:@"%@ (%@)", assistance[@"name"], formattedNum]];
    //        }
    //        assitanceSheet.cancelButtonIndex = [assitanceSheet addButtonWithTitle:@"Cancel"];
    //        [assitanceSheet showInView:self.view];
    //    } else {
    //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry"
    //                                                            message:@"There are no ACE Assistance providers available to help you."
    //                                                           delegate:nil
    //                                                  cancelButtonTitle:@"OK"
    //                                                  otherButtonTitles:nil];
    //        [alertView show];
    //    }
    NSLog(@"working");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://14166463107"]]];
    
}

//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if (buttonIndex != actionSheet.cancelButtonIndex) {
//        NSDictionary *userDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDict"];
//        NSArray *providers = userDict[@"user"][@"company"][@"assistance_providers"];
//        NSString *formattedNum = [providers[buttonIndex][@"phone"] stringByReplacingOccurrencesOfString:@" " withString:@""];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", formattedNum]]];
//    }
//}

@end

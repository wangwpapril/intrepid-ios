//
//  WebViewController.h
//  intrepidApp
//
//  Created by Philip Ojha on 7/25/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuController.h"

@interface WebViewController : UIViewController

@property (nonatomic, strong) MenuController *mController;
@property (nonatomic , strong) UIWebView *trialView;
- (void)setupWithTitle: (NSString *)title withURL:(NSString *)url;
@end

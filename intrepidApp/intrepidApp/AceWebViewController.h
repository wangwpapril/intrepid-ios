//
//  AceWebViewController.h
//  intrepidApp
//
//  Created by Chaitanya Shah on 2015-02-03.
//  Copyright (c) 2015 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AceWebViewController : UIViewController

@property (nonatomic , strong) UIWebView *trialView;

- (void)setupWithTitle:(NSString *)title withURL:(NSString *)url;

@end

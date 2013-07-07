//
//  MenuController.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/7/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "MenuController.h"
#import <QuartzCore/QuartzCore.h>


@implementation MenuController

@synthesize parentController;

-(void)displayMenuWithParent:(UIViewController *)controller {
    NSLog(@"screen height: %f", controller.view.frame.size.height);
    UIView *label = [[UIView alloc] initWithFrame:CGRectMake(0, controller.view.frame.size.height - 80, 320, 80)];
    label.layer.zPosition = MAXFLOAT;
    [label setBackgroundColor:[UIColor orangeColor]];
    [controller.view addSubview:label];
}

@end

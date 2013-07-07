//
//  MenuController.h
//  intrepidApp
//
//  Created by Philip Ojha on 7/7/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuController : NSObject

@property (nonatomic, strong) UIViewController *parentController;
@property (nonatomic, strong) UIImageView *menu;

-(void)displayMenuWithParent:(UIViewController *)controller;

@end

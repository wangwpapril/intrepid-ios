//
//  MenuButton.h
//  intrepidApp
//
//  Created by Chaitanya Shah on 2015-05-26.
//  Copyright (c) 2015 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuButton : UIButton

@property (nonatomic, strong) UIViewController *parentController;

+ (MenuButton *)getInstance;
- (void)displayMenuWithParent:(UIViewController *)controller;

@end

//
//  MenuButton.m
//  intrepidApp
//
//  Created by Chaitanya Shah on 2015-05-26.
//  Copyright (c) 2015 JonCarrHarris Consulting. All rights reserved.
//

#import "MenuButton.h"
#import "MenuController.h"

@implementation MenuButton

static MenuButton *instance =nil;

+ (MenuButton *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            // instantiate some global variables
            instance = [[MenuButton alloc] init];
            [instance setImage:[UIImage imageNamed:@"expand"] forState:UIControlStateNormal];
        }
    }
    return instance;
}

- (void)displayMenuWithParent:(UIViewController *)controller {
    self.parentController = controller;
    instance.frame = CGRectMake(260, self.parentController.view.frame.size.height - 20, 50, 50);
    [instance addTarget:self action:@selector(tapMenu) forControlEvents:UIControlEventTouchUpInside];
    [self.parentController.navigationController.view addSubview:[MenuButton getInstance]];
}

- (void)tapMenu {
    [[MenuController getInstance] toggleMenu];
}

@end

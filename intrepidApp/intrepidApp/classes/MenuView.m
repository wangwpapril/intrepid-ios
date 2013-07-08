//
//  MenuView.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/7/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "MenuView.h"

@implementation MenuView

@synthesize parentController;

- (id)initWithParent:(UIViewController *)parent
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 400)];
    if (self) {
    }
    return self;
}

- (void)displayMenu {
    self.backgroundColor = [UIColor orangeColor];
    [parentController.view addSubview:self];
    [parentController.view bringSubviewToFront:self];
    NSLog(@"all added brah");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

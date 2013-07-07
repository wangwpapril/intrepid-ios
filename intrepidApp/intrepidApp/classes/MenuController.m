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
@synthesize menu;

-(void)displayMenuWithParent:(UIViewController *)controller {
    parentController = controller;
    NSLog(@"screen height: %f", controller.view.frame.size.height);
    menu = [[UIImageView alloc] initWithFrame:CGRectMake(0, controller.view.frame.size.height - 70, 320, 250)];
    menu.layer.zPosition = MAXFLOAT;
//    [menu setBackgroundColor:[UIColor colorWithRed:86.0/255 green:78.0/255 blue:76.0/255 alpha:0.9]];
    menu.image = [UIImage imageNamed:@"menuBack.png"];
    [self addContentButtons];
    menu.userInteractionEnabled = YES;
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleDrag:)];
    [menu addGestureRecognizer:recognizer];
    [controller.view addSubview:menu];
    
}

- (IBAction)handleDrag:(UIPanGestureRecognizer *)recognizer {
    NSLog(@"drag nikkuh");
    CGPoint translation = [recognizer translationInView:parentController.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:parentController.view];
}

-(void)addContentButtons {
    [self makeContentButtonWithImage:@"pic.png" withOrigin:CGPointMake(0, 30) withTag:0];
    [self makeContentButtonWithImage:@"pic.png" withOrigin:CGPointMake(100, 30) withTag:1];
    [self makeContentButtonWithImage:@"pic.png" withOrigin:CGPointMake(220, 30) withTag:2];
    [self makeContentButtonWithImage:@"pic.png" withOrigin:CGPointMake(0, 110) withTag:3];
    [self makeContentButtonWithImage:@"pic.png" withOrigin:CGPointMake(100, 110) withTag:4];
    [self makeContentButtonWithImage:@"pic.png" withOrigin:CGPointMake(220, 110) withTag:5];

}

-(void)goToController{
    NSLog(@"off 2 controller");
}

-(void)makeContentButtonWithImage:(NSString *)image withOrigin:(CGPoint)origin withTag:(NSInteger)tag{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    NSInteger size = 100;
    // buttons in the middle are fatter
    if (tag == 1 || tag == 4) {
        size = 120;
    }
    button.frame = CGRectMake(origin.x, origin.y, size, 80);
    button.backgroundColor = [UIColor clearColor];
    [menu addSubview:button];
    [button addTarget:self action:@selector(goToController) forControlEvents:UIControlEventTouchUpInside];
}

@end

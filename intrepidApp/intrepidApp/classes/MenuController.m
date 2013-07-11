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
@synthesize viewHeight;
@synthesize botPosition;
@synthesize hiding;

-(void)displayMenuWithParent:(UIViewController *)controller {
    parentController = controller;
    NSLog(@"screen height: %f", controller.view.frame.size.height);
    viewHeight = controller.view.frame.size.height;
    botPosition = CGRectMake(0, viewHeight - 70, 320, 206);
    menu = [[UIImageView alloc] initWithFrame:botPosition];
    hiding = true;
//    menu.layer.zPosition = MAXFLOAT;
    menu.image = [UIImage imageNamed:@"menuBack.png"];
    [self addContentButtons];
    menu.userInteractionEnabled = YES;
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleDrag:)];
    [menu addGestureRecognizer:recognizer];
    [controller.view addSubview:menu];
    
}

- (IBAction)handleDrag:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:parentController.view];
    float nextPos = menu.frame.origin.y + translation.y;
    BOOL touchIsOver = (recognizer.state == UIGestureRecognizerStateEnded);
    if (nextPos > viewHeight - 195 && (!hiding || touchIsOver || nextPos > viewHeight - 70)) {
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationCurveEaseInOut animations:^{
            menu.frame = botPosition;
            hiding = true;
        }
         completion:^(BOOL finished){
         }
         ];
    }
    else if (nextPos < viewHeight - 195 && (hiding || touchIsOver || nextPos < viewHeight - 294)) {
        [UIView animateWithDuration:0.2 animations:^ {
            menu.frame = CGRectMake(0, viewHeight - 294, 320, 206);
        }];
        hiding = false;
    }
    else {
        recognizer.view.center = CGPointMake(recognizer.view.center.x,
                                             recognizer.view.center.y + translation.y);
        [recognizer setTranslation:CGPointMake(0, 0) inView:parentController.view];
    }
}

-(void)addContentButtons {
    [self makeContentButtonWithImage:@"pic.png" withOrigin:CGPointMake(0, 30) withTag:0];
    [self makeContentButtonWithImage:@"pic.png" withOrigin:CGPointMake(100, 30) withTag:1];
    [self makeContentButtonWithImage:@"pic.png" withOrigin:CGPointMake(220, 30) withTag:2];
    [self makeContentButtonWithImage:@"pic.png" withOrigin:CGPointMake(0, 110) withTag:3];
    [self makeContentButtonWithImage:@"pic.png" withOrigin:CGPointMake(100, 110) withTag:4];
    [self makeContentButtonWithImage:@"pic.png" withOrigin:CGPointMake(220, 110) withTag:5];

}

-(void)goToController:(id)sender{
    UIButton *button = (UIButton *)sender;
    NSLog(@"off 2 controller with tag: %i", button.tag);
}

-(void)makeContentButtonWithImage:(NSString *)image withOrigin:(CGPoint)origin withTag:(NSInteger)tag{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    NSInteger size = 100;
    button.tag = tag;
    // buttons in the middle are fatter
    if (tag == 1 || tag == 4) {
        size = 120;
    }
    button.frame = CGRectMake(origin.x, origin.y, size, 80);
    button.backgroundColor = [UIColor clearColor];
    [menu addSubview:button];
    [button addTarget:self action:@selector(goToController:) forControlEvents:UIControlEventTouchUpInside];
}

@end

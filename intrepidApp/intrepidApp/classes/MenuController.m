//
//  MenuController.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/7/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "MenuController.h"
#import <QuartzCore/QuartzCore.h>
#import "WebViewController.h"


@implementation MenuController

@synthesize parentController;
@synthesize menu;
@synthesize viewHeight;
@synthesize botPosition;
@synthesize hiding;

-(void)displayMenuWithParent:(UIViewController *)controller {
    parentController = controller;
    NSLog(@"screen height: %f", controller.view.frame.size.height);
    viewHeight = controller.view.frame.size.height - 44; // account for nav bar
    
    botPosition = CGRectMake(0, viewHeight - 25, 320, 206);
    menu = [[UIImageView alloc] initWithFrame:botPosition];
    hiding = true;
    menu.image = [UIImage imageNamed:@"menuBack2.png"];
    menu.layer.zPosition = MAXFLOAT;
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
    if (nextPos > viewHeight - 90 && (!hiding || touchIsOver || nextPos > viewHeight - 25)) {
        [self hideMenu];
    }
    else if (nextPos < viewHeight - 90 && (hiding || touchIsOver || nextPos < viewHeight - 206)) {
        [self showMenu];
    }
    else {
        recognizer.view.center = CGPointMake(recognizer.view.center.x,
                                             recognizer.view.center.y + translation.y);
        [recognizer setTranslation:CGPointMake(0, 0) inView:parentController.view];
    }
}

-(void)showMenu {
    if (menu.frame.origin.y > viewHeight - 206) {
        [UIView animateWithDuration:0.2 animations:^ {
            menu.frame = CGRectMake(0, viewHeight - 206, 320, 206);
        }];
        hiding = false;
    }
}

-(void)hideMenu {
    if (menu.frame.origin.y < viewHeight - 90) {
        [UIView animateWithDuration:0.2 animations:^{
                            menu.frame = botPosition;
                        }];
        hiding = true;
    }
}
-(void)addContentButtons {
    // popup button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 320, 25);
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(toggleMenu) forControlEvents:UIControlEventTouchUpInside];
    [menu addSubview:button];

    // content buttons
    [self makeContentButtonWithImage:@"pic.png" withOrigin:CGPointMake(0, 30) withTag:0];
    [self makeContentButtonWithImage:@"pic.png" withOrigin:CGPointMake(100, 30) withTag:1];
    [self makeContentButtonWithImage:@"pic.png" withOrigin:CGPointMake(220, 30) withTag:2];
    [self makeContentButtonWithImage:@"pic.png" withOrigin:CGPointMake(0, 110) withTag:3];
    [self makeContentButtonWithImage:@"pic.png" withOrigin:CGPointMake(100, 110) withTag:4];
    [self makeContentButtonWithImage:@"pic.png" withOrigin:CGPointMake(220, 110) withTag:5];
}

-(void)toggleMenu {
    if (hiding) {
        [self showMenu];
    }
    else {
        [self hideMenu];
    }
}

-(void)goToController:(id)sender{
    UIButton *button = (UIButton *)sender;
    NSLog(@"tag: %i", button.tag);
    UIViewController *viewController;
    switch (button.tag) {
        case 0:
            viewController = [parentController.storyboard instantiateViewControllerWithIdentifier:@"overView"];
            break;
            
        case 1:
            viewController = [parentController.storyboard instantiateViewControllerWithIdentifier:@"healthView"];
            break;
        default:
            break;
            
        case 4:
            viewController = [parentController.storyboard instantiateViewControllerWithIdentifier:@"webView"];
            [((WebViewController *)viewController) setupWithTitle:@"Clinics" withURL:@"http://m.intrepid247.com/m/ppn?region=latinamerica&country=Mexico&city=mexico"];
            break;
            
        case 5:
            viewController = [parentController.storyboard instantiateViewControllerWithIdentifier:@"webView"];
            viewController = [parentController.storyboard instantiateViewControllerWithIdentifier:@"webView"];
            [((WebViewController *)viewController) setupWithTitle:@"Alerts" withURL:@"http://m.intrepid247.com/m/alert?region=latinamerica&country=Mexico&city=mexico%20city"];
            break;
            
            
    }
    if (parentController.view.tag != button.tag) {
        [parentController.navigationController pushViewController:viewController animated:YES];
    }
    
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    OverViewViewController *controller = segue.destinationViewController;
//    
//}

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

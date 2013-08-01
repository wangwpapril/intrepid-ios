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
@synthesize arrow;
@synthesize upRight;
@synthesize flipped;
@synthesize city;

static MenuController *instance =nil;
+(MenuController *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            // instantiate some global variables
            instance = [[MenuController alloc] init];
            instance.menu = [[UIImageView alloc] init];
            instance.menu.image = [UIImage imageNamed:@"newMenuBack2.png"];
            instance.menu.layer.zPosition = MAXFLOAT;
            [instance addContentButtons];
            // add arrow
            instance.arrow = [[UIImageView alloc] initWithFrame:CGRectMake(156, 4, 9, 4)]; // 9 4
            instance.upRight = [UIImage imageNamed:@"menuArrow.png"];
            instance.flipped = [UIImage imageWithCGImage:instance.upRight.CGImage scale:1.0 orientation:UIImageOrientationDown];
            [instance.menu addSubview:instance.arrow];
        }
    }
    return instance;
}

-(void)displayMenuWithParent:(UIViewController *)controller {
    
    if (parentController) {
        [menu removeFromSuperview];
    }
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleDrag:)];
    [instance.menu addGestureRecognizer:recognizer];
    parentController = controller;
    viewHeight = controller.view.frame.size.height; // account for nav bar
    
    botPosition = CGRectMake(0, viewHeight - 25, 320, 246); // was 206
    menu.frame = botPosition;
    hiding = true;
    menu.userInteractionEnabled = YES;

    [controller.view addSubview:menu];
    
    arrow.image = upRight;
    
}

- (IBAction)handleDrag:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:parentController.view];
    float nextPos = menu.frame.origin.y + translation.y;
    BOOL touchIsOver = (recognizer.state == UIGestureRecognizerStateEnded);
    if (nextPos > viewHeight - 110 && (!hiding || touchIsOver || nextPos > viewHeight - 25)) {
        [self hideMenu];
    }
    else if (nextPos <= viewHeight - 110 && (hiding || touchIsOver || nextPos < viewHeight - 246)) {
        [self showMenu];
    }
    else {
        recognizer.view.center = CGPointMake(recognizer.view.center.x,
                                             recognizer.view.center.y + translation.y);
        [recognizer setTranslation:CGPointMake(0, 0) inView:parentController.view];
    }
}

-(void)showMenu {
    if (menu.frame.origin.y > viewHeight - 246) {
        [UIView animateWithDuration:0.2 animations:^ {
            menu.frame = CGRectMake(0, viewHeight - 246, 320, 246);
        }];
        hiding = false;
        arrow.image = flipped;
    }
}

-(void)hideMenu {
    if (menu.frame.origin.y < viewHeight - 110) {
        [UIView animateWithDuration:0.2 animations:^{
                            menu.frame = botPosition;
                        }];
        hiding = true;
        arrow.image = upRight;
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
    [self makeContentButtonWithOrigin:CGPointMake(0, 25) withTag:0];
    [self makeContentButtonWithOrigin:CGPointMake(107, 25) withTag:1];
    [self makeContentButtonWithOrigin:CGPointMake(214, 25) withTag:2];
    [self makeContentButtonWithOrigin:CGPointMake(0, 90) withTag:3];
    [self makeContentButtonWithOrigin:CGPointMake(107, 90) withTag:4];
    [self makeContentButtonWithOrigin:CGPointMake(214, 90) withTag:5];
    [self makeContentButtonWithOrigin:CGPointMake(0, 155) withTag:6];
    [self makeContentButtonWithOrigin:CGPointMake(107, 155) withTag:7];
    [self makeContentButtonWithOrigin:CGPointMake(214, 155) withTag:8];
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
    UIViewController *viewController;
    switch (button.tag) {
        case 0:
            viewController = [parentController.storyboard instantiateViewControllerWithIdentifier:@"security"];
            break;
            
        case 1:
            viewController = [parentController.storyboard instantiateViewControllerWithIdentifier:@"healthView"];
            break;
        case 2:
            viewController = [parentController.storyboard instantiateViewControllerWithIdentifier:@"overView"];
            break;
            
        case 4:
            viewController = [parentController.storyboard instantiateViewControllerWithIdentifier:@"webView"];
            [((WebViewController *)viewController) setupWithTitle:@"Clinics" withURL:@"http://m.intrepid247.com/m/ppn?region=latinamerica&country=Mexico&city=mexico%20city"];
            viewController.view.tag = 4;
            break;

        case 5:
            viewController = [parentController.storyboard instantiateViewControllerWithIdentifier:@"webView"];
            [((WebViewController *)viewController) setupWithTitle:@"Weather" withURL:@"http://m.intrepid247.com/m/weather?region=latinamerica&country=Mexico&city=mexico%20city"];
            viewController.view.tag = 5;
            break;
            
        case 6:
            viewController = [parentController.storyboard instantiateViewControllerWithIdentifier:@"webView"];
            [((WebViewController *)viewController) setupWithTitle:@"Alerts" withURL:@"http://m.intrepid247.com/m/alert?region=latinamerica&country=Mexico&city=mexico%20city"];
            viewController.view.tag = 6;
            break;
            
        case 7:
            viewController = [parentController.storyboard instantiateViewControllerWithIdentifier:@"myTrips"];
            break;
            
        case 8:
            viewController = [parentController.storyboard instantiateViewControllerWithIdentifier:@"settings"];
            break;
            
        default:
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

-(void)makeContentButtonWithOrigin:(CGPoint)origin withTag:(NSInteger)tag{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    NSInteger size = 107;
    button.tag = tag;
//    button.layer.borderColor = [UIColor orangeColor].CGColor;
//    button.layer.borderWidth = 1;
    // buttons in the middle are fatter
//    if (tag == 1 || tag == 4) {
//        size = 120;
//    }
//    // trips and assistance
//    else if (tag >= 6) {
//        size = 160;
//    }
    button.frame = CGRectMake(origin.x, origin.y, size, 65);
    button.backgroundColor = [UIColor clearColor];
    [menu addSubview:button];
    [button addTarget:self action:@selector(goToController:) forControlEvents:UIControlEventTouchUpInside];
}

@end

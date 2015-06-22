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
#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "MenuButton.h"

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
@synthesize buttonArray;
@synthesize outsideMenu;

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
            instance.menu.image = [UIImage imageNamed:@"rbcMenu"];
            instance.menu.layer.zPosition = MAXFLOAT;
            [instance addContentButtons];
            // add arrow
            instance.arrow = [[UIImageView alloc] initWithFrame:CGRectMake(156, 4, 9, 4)]; // 9 4
            instance.upRight = [UIImage imageNamed:@"menuArrow"];
            instance.flipped = [UIImage imageWithCGImage:instance.upRight.CGImage scale:1.0 orientation:UIImageOrientationDown];
//            [instance.menu addSubview:instance.arrow];
            
            instance.outsideMenu = [UIButton buttonWithType:UIButtonTypeCustom];
            instance.outsideMenu.backgroundColor = [UIColor clearColor];
        }
    }
    return instance;
}

-(void)displayMenuWithParent:(UIViewController *)controller {
    
    if (parentController) {
        [menu removeFromSuperview];
    }
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleDrag:)];
//    [instance.menu addGestureRecognizer:recognizer];
    parentController = controller;
    viewHeight = controller.view.frame.size.height; // account for nav bar
    
    botPosition = CGRectMake(0, viewHeight, 320, 246); // was 206
    menu.frame = botPosition;
    hiding = true;
    [[MenuButton getInstance] setImage:[UIImage imageNamed:@"expand"] forState:UIControlStateNormal];
    [MenuButton getInstance].frame = CGRectMake(260, viewHeight - 20, 50, 50);
    menu.userInteractionEnabled = YES;

    [controller.view addSubview:menu];
    
    arrow.image = upRight;
    
    outsideMenu.frame = CGRectMake(0, 0, 320, viewHeight - 236); //viewHeight - 236
    [outsideMenu addTarget:self action:@selector(hideMenu) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)handleDrag:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:parentController.view];
    float nextPos = menu.frame.origin.y + translation.y;
    NSLog(@"nextPos: %f", nextPos);
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
    NSInteger yPos = viewHeight - 246;
    [UIView animateWithDuration:0.2 animations:^ {
        [[MenuButton getInstance] setImage:[UIImage imageNamed:@"minimize"] forState:UIControlStateNormal];
        [MenuButton getInstance].frame = CGRectMake(260, yPos - 20, 50, 50);
        menu.frame = CGRectMake(0, yPos, 320, 246);
    }];
    hiding = false;
    arrow.image = flipped;
    [parentController.view addSubview:outsideMenu];
    
}

-(void)hideMenu {
    [UIView animateWithDuration:0.2 animations:^{
        [[MenuButton getInstance] setImage:[UIImage imageNamed:@"expand"] forState:UIControlStateNormal];
        [MenuButton getInstance].frame = CGRectMake(260, viewHeight - 20, 50, 50);
        menu.frame = botPosition;
    }];
    hiding = true;
    arrow.image = upRight;
    [outsideMenu removeFromSuperview];
}

-(void)addContentButtons {
    // popup button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 320, 28);
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(toggleMenu) forControlEvents:UIControlEventTouchUpInside];
    [menu addSubview:button];
    
    buttonArray = [NSMutableArray new];

    // content buttons
    [self makeContentButtonWithOrigin:CGPointMake(0, 0) withTag:0];
    [self makeContentButtonWithOrigin:CGPointMake(107, 0) withTag:1];
    [self makeContentButtonWithOrigin:CGPointMake(213, 0) withTag:2];
    [self makeContentButtonWithOrigin:CGPointMake(0, 72) withTag:3];
    [self makeContentButtonWithOrigin:CGPointMake(107, 72) withTag:4];
    [self makeContentButtonWithOrigin:CGPointMake(213, 72) withTag:5];
    [self makeContentButtonWithOrigin:CGPointMake(0, 144) withTag:6];
    [self makeContentButtonWithOrigin:CGPointMake(107, 144) withTag:7];
    [self makeContentButtonWithOrigin:CGPointMake(213, 144) withTag:8];
}

-(void)toggleMenu {
    if (hiding) {
        [self showMenu];
    }
    else {
        [self hideMenu];
    }
}

- (void)selectButtonWithTag:(NSInteger)tag {
    for (UIButton *option in buttonArray) {
        if (option.tag == tag) {
            option.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
            option.layer.borderColor = [UIColor whiteColor].CGColor;
            option.layer.borderWidth = 1;
        }
        else {
            option.backgroundColor = [UIColor clearColor];
            option.layer.borderColor = [UIColor clearColor].CGColor;
            option.layer.borderWidth = 0;
        }
    }
}

-(void)goToController:(id)sender{
    UIButton *button = (UIButton *)sender;
    UIViewController *viewController;
    
    [self selectButtonWithTag:button.tag];
    
    switch (button.tag) {
        case 0:
            viewController = [parentController.storyboard instantiateViewControllerWithIdentifier:@"overView"];
            break;

        case 1:
            viewController = [parentController.storyboard instantiateViewControllerWithIdentifier:@"healthView"];
            break;
       
        case 2:
            viewController = [parentController.storyboard instantiateViewControllerWithIdentifier:@"security"];
            break;
        
        case 3:
            viewController = [parentController.storyboard instantiateViewControllerWithIdentifier:@"alerts"];
            break;
            
        case 4:
            viewController = [parentController.storyboard instantiateViewControllerWithIdentifier:@"webView"];
            break;

        case 5:
            viewController = [parentController.storyboard instantiateViewControllerWithIdentifier:@"aceView"];
            break;
            
        case 6:
            viewController = [parentController.storyboard instantiateViewControllerWithIdentifier:@"assistance"];
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
        if (button.tag == 4) {
            [self getLocation];
            [((WebViewController *)viewController) setupWithTitle:@"Weather" withURL:[NSString stringWithFormat:@"https://m.intrepid247.com/weather.html%@", self.location]];
            viewController.view.tag = 4;
            [[SEGAnalytics sharedAnalytics] screen:@"Weather"];
        } else if (button.tag == 7) {
           [[MenuButton getInstance] removeFromSuperview];
        }
        [parentController.navigationController pushViewController:viewController animated:YES];
    }
    else {
        [self hideMenu];
    }
    
}

- (void)makeContentButtonWithOrigin:(CGPoint)origin withTag:(NSInteger)tag{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = tag;
    button.frame = CGRectMake(origin.x, origin.y, 107, 72);
    button.backgroundColor = [UIColor clearColor];
    [menu addSubview:button];
    [button addTarget:self action:@selector(goToController:) forControlEvents:UIControlEventTouchUpInside];
    [buttonArray addObject:button];
}

- (void)getLocation {
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    if (app.lastLocation) {
        self.location = [NSString stringWithFormat:@"?latitude=%f&longitude=%f&country=%@&country_code=%@", app.lastLocation.coordinate.latitude, app.lastLocation.coordinate.longitude, city.destinationName, city.countryCode];
    } else {
        self.location = [NSString stringWithFormat:@"?country=%@&country_code=%@", city.destinationName, city.countryCode];
    }
}

@end

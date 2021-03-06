//
//  OverViewViewController.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/23/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "OverViewViewController.h"
#import "SlidingTextView.h"
#import "RequestBuilder.h"
#import "CurrencyEntity.h"
#import "TripManager.h"
#import "MenuController.h"
#import "MenuButton.h"

@implementation OverViewViewController

@synthesize firstLoad;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.tag = 0;
    self.navigationItem.title = @"Overview";
         
    NSInteger height = self.view.bounds.size.height;
    CGRect frame = CGRectMake(0, 0, 320, height);
    
    CityEntity *city = [self getCity];
    
    SlidingTextView *history = [[SlidingTextView alloc] initWithFrame:frame];
    [history setupWithImageName1x:city.generalImage1x withImageName2x:city.generalImage2x withImageName3x:city.generalImage3x withTitle:@"General"];
    NSMutableArray *historyArray = [NSMutableArray new];
    if (city.location) {
        [historyArray addObject:@[@"Location", city.location, @"location-icon"]];
    }
    if (city.climate) {
        [historyArray addObject:@[@"Climate", city.climate, @"weather-icon"]];
    }
    if (city.typeOfGovernment) {
        [historyArray addObject:@[@"Type Of Government", city.typeOfGovernment, @"government-icon"]];
    }
    if (city.visaRequirements) {
        [historyArray addObject:@[@"Visa Requirements", city.visaRequirements, @"visa-icon"]];
    }
    if (city.communicationInfrastructure) {
        [historyArray addObject:@[@"Communication Infrastructure", city.communicationInfrastructure, @"communication-icon"]];
    }
    if (city.electricity) {
        [historyArray addObject:@[@"Electricity", city.electricity, @"electricity-icon"]];
    }
    if (city.development) {
        [historyArray addObject:@[@"Development", city.development, @"development-icon"]];
    }
    if (city.money) {
        [historyArray addObject:@[@"Money", city.money, @"currency-icon"]];
    }
    if (city.transportation) {
        [historyArray addObject:@[@"Transportation", city.transportation, @"transport-icon"]];
    }
    if (city.holidays) {
        [historyArray addObject:@[@"Holidays", city.holidays, @"holidays-icon"]];
    }
    [history addTextAreaWithText:historyArray];
    
    
    SlidingTextView *culture = [[SlidingTextView alloc] initWithFrame:frame];
    [culture setupWithImageName1x:city.cultureImage1x withImageName2x:city.cultureImage2x withImageName3x:city.cultureImage3x withTitle:@"Culture"];
    NSMutableArray *cultureArray = [NSMutableArray new];
    if (city.location) {
        [cultureArray addObject:@[@"Language", city.language, @"culture-icon"]];
    }
    if (city.climate) {
        [cultureArray addObject:@[@"Religion", city.religion, @"religion-icon"]];
    }
    if (city.electricity) {
        [cultureArray addObject:@[@"Ethnic Makeup", city.ethnicMakeup, @"diversity-icon"]];
    }
    if (city.development) {
        [cultureArray addObject:@[@"Cultural Norms", city.culturalNorms, @"cultural-norms-icon"]];
    }
    [culture addTextAreaWithText:cultureArray];
    
    SlidingTextView *currency = [[SlidingTextView alloc] initWithFrame:frame];
    [currency setupWithImageName1x:@"" withImageName2x:@"" withImageName3x:@"" withTitle:@"Currency"];
    currency.parentViewController = self;
    [currency addCurrencyWithCity:city];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(handleTap:)];
    [currency addGestureRecognizer:tap];
    
    NSMutableArray *views = [NSMutableArray arrayWithObjects:history, culture, currency, nil];
    [self addViews:views withVerticalOffset:0];
    
    NSArray *names = [NSArray arrayWithObjects:@"GENERAL", @"CULTURE", @"CURRENCY", nil];
    [self addTabs:names];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (firstLoad) {
        MenuButton *menuButton = [MenuButton getInstance];
        [menuButton displayMenuWithParent:self];
        [[MenuController getInstance] showMenu];
        firstLoad = false;
    }
}

- (void)viewSwitched {
    if (self.currentTab == 0) {
        [[SEGAnalytics sharedAnalytics] screen:@"General"];
    } else if (self.currentTab == 1) {
        [[SEGAnalytics sharedAnalytics] screen:@"Culture"];
    } else if (self.currentTab == 2) {
        [[SEGAnalytics sharedAnalytics] screen:@"Currency"];
    }
}

#pragma mark - keyboard stuff

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

- (void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
}

- (void)keyboardWillHide {
    if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    [self.view endEditing:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)sender
{
    if ([sender isEqual:self])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
- (void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= 120;
        //rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += 120;
        //rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.currentTab == 0) {
        [[SEGAnalytics sharedAnalytics] screen:@"General"];
    } else if (self.currentTab == 1) {
        [[SEGAnalytics sharedAnalytics] screen:@"Culture"];
    } else if (self.currentTab == 2) {
        [[SEGAnalytics sharedAnalytics] screen:@"Currency"];
    }
    
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[MenuController getInstance] displayMenuWithParent:self];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
    [super viewWillDisappear:animated];
}

@end

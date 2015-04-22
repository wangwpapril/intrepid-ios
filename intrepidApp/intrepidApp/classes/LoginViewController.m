//
//  LoginViewController.m
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-13.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LoginViewController.h"
#import "RequestBuilder.h"
#import "Constants.h"
#import "MyTripsViewController.h"
#import "TripManager.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize loginButton;
@synthesize learnMore;
@synthesize legal;
@synthesize intrepidTitle;
@synthesize tagline;
@synthesize email;
@synthesize password;
@synthesize signupButton;
@synthesize underlinePassword;
@synthesize underlineEmail;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UITextField appearance] setTintColor:[UIColor whiteColor]];
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    
//    email.text = @"cshah3@alumni.uwo.ca";
//    password.text = @"iloveapple";
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userDict"]) {
        NSDictionary *userDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDict"];

        [[SEGAnalytics sharedAnalytics] identify:[userDict[@"user"][@"id"] stringValue]
              traits:@{@"email": userDict[@"user"][@"email"], @"first_name": userDict[@"user"][@"first_name"], @"last_name": userDict[@"user"][@"last_name"], @"country_code": userDict[@"user"][@"country_code"]}];
        
        MyTripsViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"myTrips"];
        [self.navigationController pushViewController:viewController animated:NO];
    }
}

- (IBAction)login:(id)sender {
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.view.center;
    [self.view addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    
    NSDictionary *body = @{@"user": @{@"email": self.email.text, @"password": self.password.text}};
    
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@users/login", BASE_URL]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestURL];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:body options:0 error:nil];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error) {
            NSDictionary *responseBody = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@", responseBody);
            if (responseBody[@"user"]) {
                [[SEGAnalytics sharedAnalytics] identify:[responseBody[@"user"][@"id"] stringValue]
                      traits:@{@"email": responseBody[@"user"][@"email"], @"first_name": responseBody[@"user"][@"first_name"], @"last_name": responseBody[@"user"][@"last_name"], @"country_code": responseBody[@"user"][@"country_code"]}];
                [[SEGAnalytics sharedAnalytics] track:@"Email Login" properties:@{@"category" : @"Login"}];
                
                NSMutableDictionary *userDict = [self cleanDictionary:[[NSMutableDictionary alloc] initWithDictionary:responseBody]];
                [[NSUserDefaults standardUserDefaults] setObject:[[NSDictionary alloc] initWithDictionary:userDict] forKey:@"userDict"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [self.activityIndicator stopAnimating];
                [self performSegueWithIdentifier:@"toTrips" sender:self];
            } else {
                [self.activityIndicator stopAnimating];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:responseBody[@"error"][@"message"][0] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
            }
        } else {
            [self.activityIndicator stopAnimating];            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
            [alertView show];
        }
    }];
}

#pragma mark - Helper methods

- (NSMutableDictionary *)cleanDictionary:(NSMutableDictionary *)dictionary {
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (obj == [NSNull null]) {
            [dictionary setObject:@"" forKey:key];
        } else if ([obj isKindOfClass:[NSDictionary class]]) {
            [dictionary setObject:[self cleanDictionary:[[NSMutableDictionary alloc] initWithDictionary:obj]] forKey:key];
        }
    }];
    return dictionary;
}

# pragma mark - keyboard stuff

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == email) {
        [[SEGAnalytics sharedAnalytics] track:@"Email Field" properties:@{@"category" : @"Login"}];
    } else if (textField == password) {
        [[SEGAnalytics sharedAnalytics] track:@"Password Field" properties:@{@"category" : @"Login"}];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == self.email) {
        [textField resignFirstResponder];
        [self.password becomeFirstResponder];
    }
    if (textField == self.password) {
        [textField resignFirstResponder];
        [self login:self];
    }
    return YES;
}

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

// added so that you can click outside of keyboard for finishing typing - JCH
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [email resignFirstResponder];
    [password resignFirstResponder];
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
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
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        //rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        //rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[SEGAnalytics sharedAnalytics] screen:@"Login"];
    
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

@end


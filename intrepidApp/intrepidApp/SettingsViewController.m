//
//  SettingsViewController.m
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-30.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "SettingsViewController.h"
#import "MenuController.h"
#import <QuartzCore/QuartzCore.h>
#import "TripManager.h"
#import "RequestBuilder.h"
#import <Crashlytics/Crashlytics.h>
#import "MenuButton.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize firstName;
@synthesize lastName;
@synthesize email;
@synthesize username;
@synthesize oldPassword;
@synthesize changePassword;
@synthesize updateButton;
@synthesize signOutButton;
@synthesize mController;
@synthesize newMedia;

- (void)viewDidLoad
{
    [[UITextField appearance] setTintColor:[UIColor whiteColor]];
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    mController = [MenuController getInstance];
    self.view.tag = 8;
    self.navigationItem.title = @"Settings";
    self.versionLabel.text = [NSString stringWithFormat:@"Version: %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"login-background"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    
    //Initalize the TextFields and keyboard
    NSDictionary *userDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDict"];
    firstName.text = userDict[@"user"][@"first_name"];
    lastName.text = userDict[@"user"][@"last_name"];
    email.text = userDict[@"user"][@"email"];
    username.text = userDict[@"user"][@"username"];
}

- (IBAction)update:(id)sender {
    if (firstName.text.length < 1 || lastName.text.length < 1) {
        [self sendAlertWithError:@"First and last name are required."];
        return;
    }
    if (![self NSStringIsValidEmail:email.text]) {
        [self sendAlertWithError:@"The email format is invalid."];
        return;
    }
    if (username.text.length < 3) {
        [self sendAlertWithError:@"Username must be at least 3 characters."];
        return;
    }
    
    if (oldPassword.text.length > 0 || changePassword.text.length > 0) {
        if (oldPassword.text.length < 7 || changePassword.text.length < 7) {
            [self sendAlertWithError:@"Password must be at least 7 characters."];
            return;
        } else {
            self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            self.activityIndicator.center = self.view.center;
            [self.view addSubview:self.activityIndicator];
            [self.activityIndicator startAnimating];
            [self resetPassword];
        }
    } else {
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.activityIndicator.center = self.view.center;
        [self.view addSubview:self.activityIndicator];
        [self.activityIndicator startAnimating];
        [self updateProfile];
    }
}

- (void)resetPassword {
    NSDictionary *userDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDict"];
    NSDictionary *body = @{@"user": @{@"old_password": oldPassword.text,
                                      @"new_password": changePassword.text}
                           };
    
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@users/%@/resetPassword?token=%@", BASE_URL, userDict[@"user"][@"id"], userDict[@"user"][@"token"]]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestURL];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:body options:0 error:nil];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error) {
            NSDictionary *responseBody = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@", responseBody);
            if (responseBody[@"success"]) {
                [[SEGAnalytics sharedAnalytics] track:@"Change Password"
                                           properties:@{@"category" : @"Settings"}];
                
                [self updateProfile];
            } else {
                [self sendAlertWithError:responseBody[@"error"][@"message"][0]];
            }
        } else {
            [self sendAlertWithError:error.localizedDescription];
        }
    }];
}

- (void)updateProfile {
    NSDictionary *userDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDict"];
    NSDictionary *body = @{@"user": @{@"email": email.text,
                                      @"first_name": firstName.text,
                                      @"last_name": lastName.text,
                                      @"username": username.text}
                           };
    
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@users/%@?token=%@", BASE_URL, userDict[@"user"][@"id"], userDict[@"user"][@"token"]]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestURL];
    request.HTTPMethod = @"PUT";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:body options:0 error:nil];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error) {
            NSDictionary *responseBody = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@", responseBody);
            if (responseBody[@"user"]) {
                [[SEGAnalytics sharedAnalytics] track:@"Update Profile"
                                           properties:@{@"category" : @"Settings"}];
                
                NSMutableDictionary *userDict = [self cleanDictionary:[[NSMutableDictionary alloc] initWithDictionary:responseBody]];
                [[NSUserDefaults standardUserDefaults] setObject:[[NSDictionary alloc] initWithDictionary:userDict] forKey:@"userDict"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [self sendAlertWithError:@"Your profile has been updated."];
            } else {
                [self sendAlertWithError:responseBody[@"error"][@"message"][0]];
            }
        } else {
            [self sendAlertWithError:error.localizedDescription];
        }
    }];
}

- (IBAction)signout:(id)sender {
    [[SEGAnalytics sharedAnalytics] track:@"Signout"
                               properties:@{@"category" : @"Settings"}];
    [[SEGAnalytics sharedAnalytics] reset];
    [CrashlyticsKit setUserIdentifier:@""];
    [CrashlyticsKit setUserName:@""];
    [CrashlyticsKit setUserEmail:@""];
    
    [[TripManager getInstance] deleteAllObjects:@"CityEntity"];
    [[TripManager getInstance] deleteAllObjects:@"CurrencyEntity"];
    [[TripManager getInstance] deleteAllObjects:@"EmbassyEntity"];
    [[TripManager getInstance] deleteAllObjects:@"HealthEntity"];
    [[TripManager getInstance] deleteAllObjects:@"AlertEntity"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userDict"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[MenuButton getInstance] removeFromSuperview];
    [self performSegueWithIdentifier:@"toLogin" sender:self];
}

- (void)moveAllSubviewsDown {
    float barHeight = 45.0;
    for (UIView *view in self.view.subviews) {
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + barHeight, view.frame.size.width, view.frame.size.height - barHeight);
        } else {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + barHeight, view.frame.size.width, view.frame.size.height);
        }
    }
}

#pragma mark - Helper methods

- (BOOL)NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

- (void)sendAlertWithError:(NSString *)errorString {
    [self.activityIndicator stopAnimating];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:errorString
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}

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

#pragma mark - keyboard stuff

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == firstName) {
        [[SEGAnalytics sharedAnalytics] track:@"First Name Field"
                                   properties:@{@"category" : @"Settings"}];
    } else if (textField == lastName) {
        [[SEGAnalytics sharedAnalytics] track:@"Last Name Field"
                                   properties:@{@"category" : @"Settings"}];
    } else if (textField == email) {
        [[SEGAnalytics sharedAnalytics] track:@"Email Field"
                                   properties:@{@"category" : @"Settings"}];
    } else if (textField == username) {
        [[SEGAnalytics sharedAnalytics] track:@"Username Field"
                                   properties:@{@"category" : @"Settings"}];
    } else if (textField == oldPassword) {
        [[SEGAnalytics sharedAnalytics] track:@"Old Password Field"
                                   properties:@{@"category" : @"Settings"}];
    } else if (textField == changePassword) {
        [[SEGAnalytics sharedAnalytics] track:@"New Password Field"
                                   properties:@{@"category" : @"Settings"}];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == self.firstName) {
        [textField resignFirstResponder];
        [self.lastName becomeFirstResponder];
    }
    if(textField == self.lastName) {
        [textField resignFirstResponder];
        [self.email becomeFirstResponder];
    }
    if(textField == self.email) {
        [textField resignFirstResponder];
        [self.username becomeFirstResponder];
    }
    if(textField == self.username) {
        [textField resignFirstResponder];
        [self.oldPassword becomeFirstResponder];
    }
    if (textField == self.oldPassword) {
        [textField resignFirstResponder];
        [self.changePassword becomeFirstResponder];
    }
    if (textField == self.changePassword) {
        [textField resignFirstResponder];
        [self update:self];
    }
    return YES;
}

- (void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        if (oldPassword.isEditing || changePassword.isEditing) {
            [self setViewMovedUp:YES];
        }
    }
}

- (void)keyboardWillHide {
    if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

// added so that you can click outside of keyboard for finishing typing - JCH
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [firstName resignFirstResponder];
    [lastName resignFirstResponder];
    [email resignFirstResponder];
    [username resignFirstResponder];
    [oldPassword resignFirstResponder];
    [changePassword resignFirstResponder];
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
- (void)setViewMovedUp:(BOOL)movedUp
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


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[SEGAnalytics sharedAnalytics] screen:@"Settings"];
    
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [mController displayMenuWithParent:self];
    
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

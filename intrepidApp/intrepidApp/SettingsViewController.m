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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [[UITextField appearance] setTintColor:[UIColor whiteColor]];
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    mController = [MenuController getInstance];
    self.view.tag = 8;
    self.navigationItem.title = @"Settings";
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"login-background"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    //Initalize the Labels
    UILabel *firstNameLabel = [[UILabel alloc] init];
    firstNameLabel.frame = CGRectMake(20, 40, 125, 20);
    firstNameLabel.backgroundColor = [UIColor clearColor];
    firstNameLabel.font = [UIFont fontWithName:APP_FONT size:13];
    firstNameLabel.textColor = [UIColor whiteColor];
    [firstNameLabel setTextAlignment:NSTextAlignmentLeft];
    firstNameLabel.text = @"First Name:";
    [self.view addSubview:firstNameLabel];
    
    UILabel *lastNameLabel = [[UILabel alloc] init];
    lastNameLabel.frame = CGRectMake(20, 90, 125, 20);
    lastNameLabel.backgroundColor = [UIColor clearColor];
    lastNameLabel.font = [UIFont fontWithName:APP_FONT size:13];
    lastNameLabel.textColor = [UIColor whiteColor];
    [lastNameLabel setTextAlignment:NSTextAlignmentLeft];
    lastNameLabel.text = @"Last Name:";
    [self.view addSubview:lastNameLabel];
    
    UILabel *emailLabel = [[UILabel alloc] init];
    emailLabel.frame = CGRectMake(20, 140, 125, 20);
    emailLabel.backgroundColor = [UIColor clearColor];
    emailLabel.font = [UIFont fontWithName:APP_FONT size:13];
    emailLabel.textColor = [UIColor whiteColor];
    [emailLabel setTextAlignment:NSTextAlignmentLeft];
    emailLabel.text = @"Email:";
    [self.view addSubview:emailLabel];
    
    UILabel *usernameLabel = [[UILabel alloc] init];
    usernameLabel.frame = CGRectMake(20, 190, 125, 20);
    usernameLabel.backgroundColor = [UIColor clearColor];
    usernameLabel.font = [UIFont fontWithName:APP_FONT size:13];
    usernameLabel.textColor = [UIColor whiteColor];
    [usernameLabel setTextAlignment:NSTextAlignmentLeft];
    usernameLabel.text = @"Username:";
    [self.view addSubview:usernameLabel];
    
    UILabel *passwordLabel = [[UILabel alloc] init];
    passwordLabel.frame = CGRectMake(20, 240, 125, 20);
    passwordLabel.backgroundColor = [UIColor clearColor];
    passwordLabel.font = [UIFont fontWithName:APP_FONT size:13];
    passwordLabel.textColor = [UIColor whiteColor];
    [passwordLabel setTextAlignment:NSTextAlignmentLeft];
    passwordLabel.text = @"Old Password:";
    [self.view addSubview:passwordLabel];
    
    UILabel *passwordConfirmationLabel = [[UILabel alloc] init];
    passwordConfirmationLabel.frame = CGRectMake(20, 290, 125, 20);
    passwordConfirmationLabel.backgroundColor = [UIColor clearColor];
    passwordConfirmationLabel.font = [UIFont fontWithName:APP_FONT size:13];
    passwordConfirmationLabel.textColor = [UIColor whiteColor];
    [passwordConfirmationLabel setTextAlignment:NSTextAlignmentLeft];
    passwordConfirmationLabel.text = @"New Password:";
    [self.view addSubview:passwordConfirmationLabel];
    
    
    //Initalize the TextFields and keyboard
    
    firstName.font = [UIFont fontWithName:APP_FONT size:14];
    firstName.frame = CGRectMake(125, 40, 165, 24);
    firstName.textColor = [UIColor whiteColor];
    firstName.text = [TripManager getInstance].currentUser[@"user"][@"first_name"];
    [firstName setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [firstName setReturnKeyType:UIReturnKeyDone];
    firstName.delegate = self;
    [self.view addSubview:firstName];
    
    UILabel *underlineFirstName = [[UILabel alloc] init];
    underlineFirstName.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider-mid-1"]];
    underlineFirstName.frame = CGRectMake(125, 65, 175, 1);
    [self.view addSubview:underlineFirstName];
    
    lastName.font = [UIFont fontWithName:APP_FONT size:14];
    lastName.frame = CGRectMake(125, 90, 175, 24);
    lastName.textColor = [UIColor whiteColor];
    lastName.text = [TripManager getInstance].currentUser[@"user"][@"last_name"];
    [lastName setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [lastName setReturnKeyType:UIReturnKeyDone];
    lastName.delegate = self;
    [self.view addSubview:lastName];
    
    UILabel *underlineLastName = [[UILabel alloc] init];
    underlineLastName.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider-mid-1"]];
    underlineLastName.frame = CGRectMake(125, 115, 175, 1);
    [self.view addSubview:underlineLastName];
    
    email.font = [UIFont fontWithName:APP_FONT size:14];
    email.frame = CGRectMake(125, 140, 175, 24);
    email.textColor = [UIColor whiteColor];
    email.text = [TripManager getInstance].currentUser[@"user"][@"email"];
    [email setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [email setReturnKeyType:UIReturnKeyDone];
    email.delegate = self;
    [self.view addSubview:email];
    
    UILabel *underlineEmail = [[UILabel alloc] init];
    underlineEmail.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider-mid-1"]];
    underlineEmail.frame = CGRectMake(125, 165, 175, 1);
    [self.view addSubview:underlineEmail];
    
    username.font = [UIFont fontWithName:APP_FONT size:14];
    username.frame = CGRectMake(125, 190, 175, 24);
    username.textColor = [UIColor whiteColor];
    username.text = [TripManager getInstance].currentUser[@"user"][@"username"];
    [username setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [username setReturnKeyType:UIReturnKeyDone];
    username.delegate = self;
    [self.view addSubview:username];
    
    UILabel *underlineUsername = [[UILabel alloc] init];
    underlineUsername.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider-mid-1"]];
    underlineUsername.frame = CGRectMake(125, 215, 175, 1);
    [self.view addSubview:underlineUsername];
    
    oldPassword.font = [UIFont fontWithName:APP_FONT size:14];
    oldPassword.frame = CGRectMake(125, 240, 175, 24);
    oldPassword.textColor = [UIColor whiteColor];
    oldPassword.placeholder = @"(Optional)";
    [oldPassword setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [oldPassword setReturnKeyType:UIReturnKeyDone];
    oldPassword.delegate = self;
    [self.view addSubview:oldPassword];
    
    UILabel *underlinePassword = [[UILabel alloc] init];
    underlinePassword.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider-mid-1"]];
    underlinePassword.frame = CGRectMake(125, 265, 175, 1);
    [self.view addSubview:underlinePassword];
    
    changePassword.font = [UIFont fontWithName:APP_FONT size:14];
    changePassword.frame = CGRectMake(125, 290, 175, 24);
    changePassword.textColor = [UIColor whiteColor];
    changePassword.placeholder = @"(Optional)";
    [changePassword setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [changePassword setReturnKeyType:UIReturnKeyDone];
    changePassword.delegate = self;
    [self.view addSubview:changePassword];
    
    UILabel *underlinePasswordConfirmation = [[UILabel alloc] init];
    underlinePasswordConfirmation.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider-mid-1"]];
    underlinePasswordConfirmation.frame = CGRectMake(125, 315, 175, 1);
    [self.view addSubview:underlinePasswordConfirmation];
    
    
    UIImage *buttonImage = [[UIImage imageNamed:@"ace_button"] stretchableImageWithLeftCapWidth:5 topCapHeight:10];
    updateButton.frame = CGRectMake(68, underlinePasswordConfirmation.frame.origin.y + 50, 183, 36);
    [updateButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [updateButton setTitle:@"UPDATE" forState:UIControlStateNormal];
    [updateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    updateButton.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:15];
    [self.view addSubview:updateButton];

    
    NSMutableAttributedString *signOutString = [[NSMutableAttributedString alloc] initWithString:@"Sign Out"];
    // making text property to underline text-
    [signOutString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [signOutString length])];
    [signOutButton setAttributedTitle:signOutString forState:UIControlStateNormal];
    [signOutString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.53 green:0.73 blue:0.14 alpha:1] range:NSMakeRange(0,[signOutString length])];
    signOutButton.frame = CGRectMake(77, updateButton.frame.origin.y + 70, 166, 15);
    signOutButton.titleLabel.font = [UIFont fontWithName:APP_FONT size:15];
    signOutButton.backgroundColor = [UIColor clearColor];
    [signOutButton setTitle:@"SIGN OUT" forState:UIControlStateNormal];
    signOutButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:signOutButton];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    } else {
        [self moveAllSubviewsDown];
    }
    
    if ([[UIDevice currentDevice].model rangeOfString:@"iPad"].location != NSNotFound) {
        CGRect ipadFrame = updateButton.frame;
        ipadFrame.origin.y = updateButton.frame.origin.y - 30;
        updateButton.frame = ipadFrame;
        
        CGRect ipadFrame2 = signOutButton.frame;
        ipadFrame2.origin.y = signOutButton.frame.origin.y - 50;
        signOutButton.frame = ipadFrame2;
    }
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
    NSDictionary *body = @{@"user": @{@"old_password": oldPassword.text,
                                      @"new_password": changePassword.text}
                           };
    
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@users/%@/resetPassword?token=%@", BASE_URL, [TripManager getInstance].currentUser[@"user"][@"id"], [TripManager getInstance].currentUser[@"user"][@"token"]]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestURL];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:body options:0 error:nil];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error) {
            NSDictionary *responseBody = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@", responseBody);
            if (responseBody[@"success"]) {
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
    NSDictionary *body = @{@"user": @{@"email": email.text,
                                      @"first_name": firstName.text,
                                      @"last_name": lastName.text,
                                      @"username": username.text}
                           };
    
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@users/%@?token=%@", BASE_URL, [TripManager getInstance].currentUser[@"user"][@"id"], [TripManager getInstance].currentUser[@"user"][@"token"]]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestURL];
    request.HTTPMethod = @"PUT";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:body options:0 error:nil];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error) {
            NSDictionary *responseBody = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@", responseBody);
            if (responseBody[@"user"]) {
                [RequestBuilder fetchUser:responseBody];
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
    [[TripManager getInstance] deleteAllObjects:@"CityEntity"];
    [[TripManager getInstance] deleteAllObjects:@"CurrencyEntity"];
    [[TripManager getInstance] deleteAllObjects:@"EmbassyEntity"];
    [[TripManager getInstance] deleteAllObjects:@"HealthEntity"];
    [[TripManager getInstance] deleteAllObjects:@"AlertEntity"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userDict"];
    [[NSUserDefaults standardUserDefaults] synchronize];
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

#pragma mark - keyboard stuff

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
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
}


@end

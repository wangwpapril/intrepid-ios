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
    firstNameLabel.frame = CGRectMake(20, 50, 125, 20);
    firstNameLabel.backgroundColor = [UIColor clearColor];
    firstNameLabel.font = [UIFont fontWithName:APP_FONT size:13];
    firstNameLabel.textColor = [UIColor whiteColor];
    [firstNameLabel setTextAlignment:NSTextAlignmentLeft];
    firstNameLabel.text = @"First Name:";
    [self.view addSubview:firstNameLabel];
    
    UILabel *lastNameLabel = [[UILabel alloc] init];
    lastNameLabel.frame = CGRectMake(20, 100, 125, 20);
    lastNameLabel.backgroundColor = [UIColor clearColor];
    lastNameLabel.font = [UIFont fontWithName:APP_FONT size:13];
    lastNameLabel.textColor = [UIColor whiteColor];
    [lastNameLabel setTextAlignment:NSTextAlignmentLeft];
    lastNameLabel.text = @"Last Name:";
    [self.view addSubview:lastNameLabel];
    
    UILabel *emailLabel = [[UILabel alloc] init];
    emailLabel.frame = CGRectMake(20, 150, 125, 20);
    emailLabel.backgroundColor = [UIColor clearColor];
    emailLabel.font = [UIFont fontWithName:APP_FONT size:13];
    emailLabel.textColor = [UIColor whiteColor];
    [emailLabel setTextAlignment:NSTextAlignmentLeft];
    emailLabel.text = @"Email:";
    [self.view addSubview:emailLabel];
    
    UILabel *usernameLabel = [[UILabel alloc] init];
    usernameLabel.frame = CGRectMake(20, 200, 125, 20);
    usernameLabel.backgroundColor = [UIColor clearColor];
    usernameLabel.font = [UIFont fontWithName:APP_FONT size:13];
    usernameLabel.textColor = [UIColor whiteColor];
    [usernameLabel setTextAlignment:NSTextAlignmentLeft];
    usernameLabel.text = @"Username:";
    [self.view addSubview:usernameLabel];
    
    UILabel *passwordLabel = [[UILabel alloc] init];
    passwordLabel.frame = CGRectMake(20, 250, 125, 20);
    passwordLabel.backgroundColor = [UIColor clearColor];
    passwordLabel.font = [UIFont fontWithName:APP_FONT size:13];
    passwordLabel.textColor = [UIColor whiteColor];
    [passwordLabel setTextAlignment:NSTextAlignmentLeft];
    passwordLabel.text = @"Old Password:";
    [self.view addSubview:passwordLabel];
    
    UILabel *passwordConfirmationLabel = [[UILabel alloc] init];
    passwordConfirmationLabel.frame = CGRectMake(20, 300, 125, 20);
    passwordConfirmationLabel.backgroundColor = [UIColor clearColor];
    passwordConfirmationLabel.font = [UIFont fontWithName:APP_FONT size:13];
    passwordConfirmationLabel.textColor = [UIColor whiteColor];
    [passwordConfirmationLabel setTextAlignment:NSTextAlignmentLeft];
    passwordConfirmationLabel.text = @"New Password:";
    [self.view addSubview:passwordConfirmationLabel];
    
    
    //Initalize the TextFields and keyboard
    
    firstName.font = [UIFont fontWithName:APP_FONT size:14];
    firstName.frame = CGRectMake(125, 50, 175, 24);
    firstName.textColor = [UIColor whiteColor];
    firstName.text = [TripManager getInstance].currentUser[@"user"][@"first_name"];
    [firstName setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [firstName setReturnKeyType:UIReturnKeyDone];
    firstName.delegate = self;
    [self.view addSubview:firstName];
    
    UILabel *underlineFirstName = [[UILabel alloc] init];
    underlineFirstName.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider-mid-1"]];
    underlineFirstName.frame = CGRectMake(125, 75, 175, 1);
    [self.view addSubview:underlineFirstName];
    
    lastName.font = [UIFont fontWithName:APP_FONT size:14];
    lastName.frame = CGRectMake(125, 100, 175, 24);
    lastName.textColor = [UIColor whiteColor];
    lastName.text = [TripManager getInstance].currentUser[@"user"][@"last_name"];
    [lastName setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [lastName setReturnKeyType:UIReturnKeyDone];
    lastName.delegate = self;
    [self.view addSubview:lastName];
    
    UILabel *underlineLastName = [[UILabel alloc] init];
    underlineLastName.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider-mid-1"]];
    underlineLastName.frame = CGRectMake(125, 125, 175, 1);
    [self.view addSubview:underlineLastName];
    
    email.font = [UIFont fontWithName:APP_FONT size:14];
    email.frame = CGRectMake(125, 150, 175, 24);
    email.textColor = [UIColor whiteColor];
    email.text = [TripManager getInstance].currentUser[@"user"][@"email"];
    [email setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [email setReturnKeyType:UIReturnKeyDone];
    email.delegate = self;
    [self.view addSubview:email];
    
    UILabel *underlineEmail = [[UILabel alloc] init];
    underlineEmail.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider-mid-1"]];
    underlineEmail.frame = CGRectMake(125, 175, 175, 1);
    [self.view addSubview:underlineEmail];
    
    username.font = [UIFont fontWithName:APP_FONT size:14];
    username.frame = CGRectMake(125, 200, 175, 24);
    username.textColor = [UIColor whiteColor];
    username.text = [TripManager getInstance].currentUser[@"user"][@"username"];
    [username setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [username setReturnKeyType:UIReturnKeyDone];
    username.delegate = self;
    [self.view addSubview:username];
    
    UILabel *underlineUsername = [[UILabel alloc] init];
    underlineUsername.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider-mid-1"]];
    underlineUsername.frame = CGRectMake(125, 225, 175, 1);
    [self.view addSubview:underlineUsername];
    
    oldPassword.font = [UIFont fontWithName:APP_FONT size:14];
    oldPassword.frame = CGRectMake(125, 250, 175, 24);
    oldPassword.textColor = [UIColor whiteColor];
    oldPassword.placeholder = @"(Optional)";
    [oldPassword setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [oldPassword setReturnKeyType:UIReturnKeyDone];
    oldPassword.delegate = self;
    [self.view addSubview:oldPassword];
    
    UILabel *underlinePassword = [[UILabel alloc] init];
    underlinePassword.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider-mid-1"]];
    underlinePassword.frame = CGRectMake(125, 275, 175, 1);
    [self.view addSubview:underlinePassword];
    
    changePassword.font = [UIFont fontWithName:APP_FONT size:14];
    changePassword.frame = CGRectMake(125, 300, 175, 24);
    changePassword.textColor = [UIColor whiteColor];
    changePassword.placeholder = @"(Optional)";
    [changePassword setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [changePassword setReturnKeyType:UIReturnKeyDone];
    changePassword.delegate = self;
    [self.view addSubview:changePassword];
    
    UILabel *underlinePasswordConfirmation = [[UILabel alloc] init];
    underlinePasswordConfirmation.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider-mid-1"]];
    underlinePasswordConfirmation.frame = CGRectMake(125, 325, 175, 1);
    [self.view addSubview:underlinePasswordConfirmation];
    
    //Initalize the Update Profile button
    [updateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    updateButton.titleLabel.font = [UIFont fontWithName:APP_FONT size:14];
    updateButton.frame = CGRectMake(68, underlinePasswordConfirmation.frame.origin.y + 25, 183, 36);
    UIGraphicsBeginImageContext(updateButton.frame.size);
    [[UIImage imageNamed:@"rounded-rectangle-"] drawInRect:signOutButton.bounds];
    UIImage *updateImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [updateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [updateButton setTitle:@"UPDATE PROFILE" forState:UIControlStateNormal];
    updateButton.titleLabel.font = [UIFont fontWithName:APP_FONT size:14];
    [updateButton setBackgroundImage:updateImage forState:UIControlStateNormal];
    [self.view addSubview:updateButton];
    
    //Initalize the Sign Out button
    [signOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    signOutButton.titleLabel.font = [UIFont fontWithName:APP_FONT size:14];
    signOutButton.frame = CGRectMake(68, updateButton.frame.origin.y + 50, 183, 36);
    UIGraphicsBeginImageContext(signOutButton.frame.size);
    [[UIImage imageNamed:@"signout-button2"] drawInRect:signOutButton.bounds];
    UIImage *signoutImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [signOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signOutButton setTitle:@"SIGN OUT" forState:UIControlStateNormal];
    signOutButton.titleLabel.font = [UIFont fontWithName:APP_FONT size:14];
    [signOutButton setBackgroundImage:signoutImage forState:UIControlStateNormal];
    [self.view addSubview:signOutButton];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
    } else {
        [self moveAllSubviewsDown];
    }
}

- (IBAction)update:(id)sender {
}

- (IBAction)signout:(id)sender {
    [[TripManager getInstance] deleteAllObjects:@"CityEntity"];
    [[TripManager getInstance] deleteAllObjects:@"CurrencyEntity"];
    [[TripManager getInstance] deleteAllObjects:@"EmbassyEntity"];
    [[TripManager getInstance] deleteAllObjects:@"HealthEntity"];
    [[TripManager getInstance] deleteAllObjects:@"AlertEntity"];
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

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
@synthesize oldPassword;
@synthesize changePassword;
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
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.frame = CGRectMake(20, 150, 75, 20);
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = [UIFont fontWithName:APP_FONT size:14];
    nameLabel.textColor = [UIColor whiteColor];
    [nameLabel setTextAlignment:NSTextAlignmentLeft];
    nameLabel.text = @"Name:";
    [self.view addSubview:nameLabel];
    
    UILabel *emailLabel = [[UILabel alloc] init];
    emailLabel.frame = CGRectMake(20, 200, 75, 20);
    emailLabel.backgroundColor = [UIColor clearColor];
    emailLabel.font = [UIFont fontWithName:APP_FONT size:14];
    emailLabel.textColor = [UIColor whiteColor];
    [emailLabel setTextAlignment:NSTextAlignmentLeft];
    emailLabel.text = @"Email:";
    [self.view addSubview:emailLabel];
    
    UILabel *passwordLabel = [[UILabel alloc] init];
    passwordLabel.frame = CGRectMake(20, 250, 150, 20);
    passwordLabel.backgroundColor = [UIColor clearColor];
    passwordLabel.font = [UIFont fontWithName:APP_FONT size:14];
    passwordLabel.textColor = [UIColor whiteColor];
    [passwordLabel setTextAlignment:NSTextAlignmentLeft];
    passwordLabel.text = @"Old Password:";
    [self.view addSubview:passwordLabel];
    
    UILabel *passwordConfirmationLabel = [[UILabel alloc] init];
    passwordConfirmationLabel.frame = CGRectMake(20, 300, 150, 20);
    passwordConfirmationLabel.backgroundColor = [UIColor clearColor];
    passwordConfirmationLabel.font = [UIFont fontWithName:APP_FONT size:14];
    passwordConfirmationLabel.textColor = [UIColor whiteColor];
    [passwordConfirmationLabel setTextAlignment:NSTextAlignmentLeft];
    passwordConfirmationLabel.text = @"New Password:";
    [self.view addSubview:passwordConfirmationLabel];
    
    
    //Initalize the TextFields and keyboard
    
    firstName.font = [UIFont fontWithName:APP_FONT size:13];
    firstName.frame = CGRectMake(125, 150, 235, 24);
    firstName.textColor = [UIColor whiteColor];
    firstName.text = [NSString stringWithFormat:@"%@ %@", [TripManager getInstance].currentUser[@"user"][@"first_name"], [TripManager getInstance].currentUser[@"user"][@"last_name"]];
    [firstName setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [firstName setReturnKeyType:UIReturnKeyDone];
    firstName.delegate = self;
    [self.view addSubview:firstName];
    
    UILabel *underlineName = [[UILabel alloc] init];
    underlineName.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider-mid-1"]];
    underlineName.frame = CGRectMake(125, 175, 170, 1);
    [self.view addSubview:underlineName];
    
    email.font = [UIFont fontWithName:APP_FONT size:13];
    email.frame = CGRectMake(125, 200, 235, 24);
    email.textColor = [UIColor whiteColor];
    email.text = [TripManager getInstance].currentUser[@"user"][@"email"];
    [email setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [email setReturnKeyType:UIReturnKeyDone];
    email.delegate = self;
    [self.view addSubview:email];
    
    UILabel *underlineEmail = [[UILabel alloc] init];
    underlineEmail.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider-mid-1"]];
    underlineEmail.frame = CGRectMake(125, 225, 170, 1);
    [self.view addSubview:underlineEmail];
    
    oldPassword.font = [UIFont fontWithName:APP_FONT size:13];
    oldPassword.frame = CGRectMake(125, 250, 160, 24);
    oldPassword.textColor = [UIColor whiteColor];
    oldPassword.placeholder = @"(Optional)";
    [oldPassword setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [oldPassword setReturnKeyType:UIReturnKeyDone];
    oldPassword.delegate = self;
    [self.view addSubview:oldPassword];
    
    UILabel *underlinePassword = [[UILabel alloc] init];
    underlinePassword.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider-mid-1"]];
    underlinePassword.frame = CGRectMake(125, 275, 170, 1);
    [self.view addSubview:underlinePassword];
    
    changePassword.font = [UIFont fontWithName:APP_FONT size:13];
    changePassword.frame = CGRectMake(125, 300, 160, 24);
    changePassword.textColor = [UIColor whiteColor];
    changePassword.placeholder = @"(Optional)";
    [changePassword setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [changePassword setReturnKeyType:UIReturnKeyDone];
    changePassword.delegate = self;
    [self.view addSubview:changePassword];
    
    UILabel *underlinePasswordConfirmation = [[UILabel alloc] init];
    underlinePasswordConfirmation.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider-mid-1"]];
    underlinePasswordConfirmation.frame = CGRectMake(125, 325, 170, 1);
    [self.view addSubview:underlinePasswordConfirmation];
    
    //Initalize the Sign Out button
//    UIImage *buttonImage = [[UIImage imageNamed:@"signout-button"] stretchableImageWithLeftCapWidth:5 topCapHeight:10];
    [signOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    signOutButton.titleLabel.font = [UIFont fontWithName:APP_FONT size:14];
    signOutButton.frame = CGRectMake(68, underlinePasswordConfirmation.frame.origin.y + 25, 183, 36);
    
    UIGraphicsBeginImageContext(signOutButton.frame.size);
    [[UIImage imageNamed:@"signout-button2"] drawInRect:signOutButton.bounds];
    UIImage *imageZ = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [signOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signOutButton setTitle:@"SIGN OUT" forState:UIControlStateNormal];
    signOutButton.titleLabel.font = [UIFont fontWithName:APP_FONT size:14];
    [signOutButton setBackgroundImage:imageZ forState:UIControlStateNormal];
    
    [self.view addSubview:signOutButton];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
    } else {
        [self moveAllSubviewsDown];
    }
}

- (IBAction)useCameraRoll:(id)sender
{
//    if ([UIImagePickerController isSourceTypeAvailable:
//         UIImagePickerControllerSourceTypePhotoLibrary])
//    {
//        UIImagePickerController *imagePicker =
//        [[UIImagePickerController alloc] init];
//        imagePicker.delegate = self;
//        imagePicker.sourceType =
//        UIImagePickerControllerSourceTypePhotoLibrary;
//        imagePicker.allowsEditing = NO;
//        [self presentViewController:imagePicker
//                           animated:YES completion:nil];
//        newMedia = NO;
//    }
}

- (IBAction)signout:(id)sender {
    [[TripManager getInstance] deleteAllObjects:@"CityEntity"];
    [[TripManager getInstance] deleteAllObjects:@"CurrencyEntity"];
    [[TripManager getInstance] deleteAllObjects:@"EmbassyEntity"];
    [[TripManager getInstance] deleteAllObjects:@"HealthEntity"];
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
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

- (void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

// added so that you can click outside of keyboard for finishing typing - JCH
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [email resignFirstResponder];
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
        rect.origin.y -= 130;
        //rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += 130;
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

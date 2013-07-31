//
//  SettingsViewController.m
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-30.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "SettingsViewController.h"
#import "Constants.h"

#define kOFFSET_FOR_KEYBOARD 80.0

@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize signOutButton;
@synthesize name;
@synthesize email;
@synthesize password;
@synthesize addPhoto;

@synthesize underlineEmail;
@synthesize underlineName;
@synthesize underlinePassword;

@synthesize acceptanceLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.tag = 8;
    self.navigationItem.title = @"Settings";
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"signUp-background.png"]];
    [self.view addSubview:backgroundView];
    
    self.name.delegate = self;
    self.email.delegate = self;
    self.password.delegate = self;
    //    [signUpButton setBackgroundImage:[UIImage imageNamed:@"login-and-signup-button.png"]
    //                        forState:UIControlStateNormal];
    
    UIImage *buttonImage = [[UIImage imageNamed:@"Signout.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:10];
    [signOutButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    
    [signOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    signOutButton.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
    signOutButton.frame = CGRectMake(68, self.view.frame.size.height - 150, 183, 36);
    [self.view addSubview:signOutButton];
    
    
    name.font = [UIFont fontWithName:@"ProximaNova-Regular" size:13];
    name.textColor = [UIColor whiteColor];
    name.placeholder = @"NAME";
    [name setReturnKeyType:UIReturnKeyDone];
    [self.view addSubview:name];
    
    underlineName.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider-mid-1.png"]];
    [self.view addSubview:underlineName];
    
    email.font = [UIFont fontWithName:@"ProximaNova-Regular" size:13];
    email.textColor = [UIColor whiteColor];
    email.placeholder = @"EMAIL";
    [email setReturnKeyType:UIReturnKeyDone];
    [self.view addSubview:email];
    
    underlineEmail.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider-mid-1.png"]];
    [self.view addSubview:underlineEmail];
    
    password.font = [UIFont fontWithName:@"ProximaNova-Regular" size:13];
    password.textColor = [UIColor whiteColor];
    password.placeholder = @"PASSWORD";
    [password setReturnKeyType:UIReturnKeyDone];
    [self.view addSubview:password];
    
    underlinePassword.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider-mid-1.png"]];
    [self.view addSubview:underlinePassword];
    
    [addPhoto setBackgroundImage:[UIImage imageNamed:@"Add@2x.png"]
                        forState:UIControlStateNormal];
    [self.view addSubview:addPhoto];
    
    acceptanceLabel.font = [UIFont fontWithName:@"ProximaNova-Light" size:13];
    acceptanceLabel.textColor = [UIColor whiteColor];
    acceptanceLabel.textAlignment = NSTextAlignmentCenter;
    acceptanceLabel.frame = CGRectMake(68, self.view.frame.size.height - 90, 183, 21);
    [self.view addSubview:acceptanceLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
# pragma mark - keyboard stuff

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

-(void)keyboardWillShow {
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

-(void)keyboardWillHide {
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

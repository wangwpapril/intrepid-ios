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

@synthesize editPhoto;
@synthesize signOutButton;

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
    
    [editPhoto setBackgroundImage:[UIImage imageNamed:@"Add@2x.png"]
                        forState:UIControlStateNormal];
    [self.view addSubview:editPhoto];
    
    //Initalize the Labels
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.frame = CGRectMake(25, 150, 150, 20);
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:18];
    nameLabel.textColor = [UIColor whiteColor];
    [nameLabel setTextAlignment:NSTextAlignmentLeft];
    nameLabel.text = @"Name:";
    [self.view addSubview:nameLabel];
    
    UILabel *emailLabel = [[UILabel alloc] init];
    emailLabel.frame = CGRectMake(25, 200, 150, 20);
    emailLabel.backgroundColor = [UIColor clearColor];
    emailLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:18];
    emailLabel.textColor = [UIColor whiteColor];
    [emailLabel setTextAlignment:NSTextAlignmentLeft];
    emailLabel.text = @"Email:";
    [self.view addSubview:emailLabel];
    
    UILabel *passwordLabel = [[UILabel alloc] init];
    passwordLabel.frame = CGRectMake(25, 250, 150, 20);
    passwordLabel.backgroundColor = [UIColor clearColor];
    passwordLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:18];
    passwordLabel.textColor = [UIColor whiteColor];
    [passwordLabel setTextAlignment:NSTextAlignmentLeft];
    passwordLabel.text = @"Password:";
    [self.view addSubview:passwordLabel];
    
    
    //Initalize the TextFields and keyboard
    
    UITextField *name = [[UITextField alloc] init];
    name.font = [UIFont fontWithName:@"ProximaNova-Regular" size:13];
    name.frame = CGRectMake(180, 150, 135, 34);
    name.textColor = [UIColor whiteColor];
    name.placeholder = @"Your Name";
    name.delegate = self;
    [self.view addSubview:name];
    
    UILabel *underlineName = [[UILabel alloc] init];
    underlineName.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider-mid-1.png"]];
    underlineName.frame = CGRectMake(25, 175, 300, 1);
    [self.view addSubview:underlineName];
    
    UITextField *email = [[UITextField alloc] init];
    email.font = [UIFont fontWithName:@"ProximaNova-Regular" size:13];
    email.frame = CGRectMake(180, 200, 135, 34);
    email.textColor = [UIColor whiteColor];
    email.placeholder = @"Your Email";
    [email setReturnKeyType:UIReturnKeyDone];
    email.delegate = self;
    [self.view addSubview:email];
    
    UILabel *underlineEmail = [[UILabel alloc] init];
    underlineEmail.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider-mid-1.png"]];
    underlineEmail.frame = CGRectMake(25, 225, 300, 1);
    [self.view addSubview:underlineEmail];
    
    UITextField *password = [[UITextField alloc] init];
    password.font = [UIFont fontWithName:@"ProximaNova-Regular" size:13];
    password.frame = CGRectMake(180, 250, 135, 34);
    password.textColor = [UIColor whiteColor];
    password.placeholder = @"Your Password";
    [password setReturnKeyType:UIReturnKeyDone];
    password.delegate = self;
    [self.view addSubview:password];
    
    UILabel *underlinePassword = [[UILabel alloc] init];
    underlinePassword.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider-mid-1.png"]];
    underlinePassword.frame = CGRectMake(25, 275, 300, 1);
    [self.view addSubview:underlinePassword];
    
    //Initalize the Sign Out button
    UIImage *buttonImage = [[UIImage imageNamed:@"Signout.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:10];
    [signOutButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [signOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    signOutButton.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
    signOutButton.frame = CGRectMake(68, self.view.frame.size.height - 150, 183, 36);
    [self.view addSubview:signOutButton];
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
    [_email resignFirstResponder];
    [_password resignFirstResponder];
    
    
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

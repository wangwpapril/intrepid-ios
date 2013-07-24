//
//  LoginViewController.m
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-13.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LoginViewController.h"
#import "Constants.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize loginButton;
@synthesize signUp;
@synthesize learnMore;

@synthesize intrepidTitle;
@synthesize tagline;

@synthesize email;
@synthesize password;
@synthesize forgotPassword;

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
    
    //set background image
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login-background.png"]];
    [self.view addSubview:backgroundView];
    
    UIImage *buttonImage = [[UIImage imageNamed:@"rounded-rectangle-.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:0];
    [loginButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    
    [self.view addSubview:loginButton];

    
    [self.view addSubview:signUp];
    [self.view addSubview:learnMore];
    
    intrepidTitle.font = [UIFont fontWithName:@"ProximaNova-Bold" size:24];
    intrepidTitle.textColor = UIColorFromRGB(0xe7eee2);
    [intrepidTitle setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:intrepidTitle];
    
    tagline.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
    tagline.textColor = UIColorFromRGB(0xe7eee2);
    [tagline setTextAlignment:NSTextAlignmentCenter];
    tagline.text = @"YOUR PERSONAL TRAVEL ASSISTANT";
    [self.view addSubview:tagline];
    
    email.font = [UIFont fontWithName:@"ProximaNova-Regular" size:15];
    email.textColor = UIColorFromRGB(0xe7eee2);
    email.text = @"EMAIL";
    [email setReturnKeyType:UIReturnKeyDone];
    [self.view addSubview:email];
    
    password.font = [UIFont fontWithName:@"ProximaNova-Regular" size:15];
    password.textColor = UIColorFromRGB(0xe7eee2);
    password.text = @"PASSWORD";
    [password setReturnKeyType:UIReturnKeyDone];
    [self.view addSubview:password];
    
    forgotPassword.font = [UIFont fontWithName:@"ProximaNova-Regular" size:12];
    forgotPassword.textColor = UIColorFromRGB(0xd7503e);
    forgotPassword.text = @"Forgot Password?";
    [self.view addSubview:forgotPassword];
    
    
    
	// Do any additional setup after loading the view.

}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

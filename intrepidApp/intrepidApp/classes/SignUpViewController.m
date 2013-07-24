//
//  SignUpViewController.m
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-13.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "SignUpViewController.h"
#import "Constants.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

@synthesize signUpButton;
@synthesize name;
@synthesize email;
@synthesize password;
@synthesize addPhoto;

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
    
    //set up background
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"signUp-background.png"]];
    [self.view addSubview:backgroundView];
    
//    [signUpButton setBackgroundImage:[UIImage imageNamed:@"login-and-signup-button.png"]
//                        forState:UIControlStateNormal];
    [signUpButton setBackgroundColor:[UIColor clearColor]];
    [signUpButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    UIImage *btnImage = [UIImage imageNamed:@"login-and-signup-button.png"];
    [signUpButton setImage:btnImage forState:UIControlStateNormal];
    [self.view addSubview:signUpButton];
    
    name.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
    name.textColor = UIColorFromRGB(0xe7eee2);
    name.text = @"NAME";
    [self.view addSubview:name];
    
    email.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
    email.textColor = UIColorFromRGB(0xe7eee2);
    email.text = @"EMAIL";
    [self.view addSubview:email];
    
    password.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
    password.textColor = UIColorFromRGB(0xe7eee2);
    password.text = @"PASSWORD";
    [self.view addSubview:password];
    
    [addPhoto setBackgroundImage:[UIImage imageNamed:@"add-signup-photo.png"]
                        forState:UIControlStateNormal];
    [self.view addSubview:addPhoto];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

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
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

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

@synthesize underlineEmail;
@synthesize underlineName;
@synthesize underlinePassword;

@synthesize termsOfService;
@synthesize privacyPolicy;
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
    
    //set up background
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"signUp-background.png"]];
    [self.view addSubview:backgroundView];
    
    self.name.delegate = self;
    self.email.delegate = self;
    self.password.delegate = self;
//    [signUpButton setBackgroundImage:[UIImage imageNamed:@"login-and-signup-button.png"]
//                        forState:UIControlStateNormal];
    
    UIImage *buttonImage = [[UIImage imageNamed:@"rounded-rectangle-.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:10];
    [signUpButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    
    [signUpButton setTitleColor:UIColorFromRGB(0xe7eee2) forState:UIControlStateNormal];
    signUpButton.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
    [self.view addSubview:signUpButton];

    
    name.font = [UIFont fontWithName:@"ProximaNova-Regular" size:13];
    name.textColor = UIColorFromRGB(0xe7eee2);
    name.placeholder = @"NAME";
    [name setReturnKeyType:UIReturnKeyDone];
    [self.view addSubview:name];
    
    underlineName.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"underline.png"]];
    [self.view addSubview:underlineName];
    
    email.font = [UIFont fontWithName:@"ProximaNova-Regular" size:13];
    email.textColor = UIColorFromRGB(0xe7eee2);
    email.placeholder = @"EMAIL";
    [email setReturnKeyType:UIReturnKeyDone];
    [self.view addSubview:email];
    
    underlineEmail.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"underline.png"]];
    [self.view addSubview:underlineEmail];
    
    password.font = [UIFont fontWithName:@"ProximaNova-Regular" size:13];
    password.textColor = UIColorFromRGB(0xe7eee2);
    password.placeholder = @"PASSWORD";
    [password setReturnKeyType:UIReturnKeyDone];
    [self.view addSubview:password];
    
    underlinePassword.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"underline.png"]];
    [self.view addSubview:underlinePassword];
    
    [addPhoto setBackgroundImage:[UIImage imageNamed:@"add-signup-photo.png"]
                        forState:UIControlStateNormal];
    [self.view addSubview:addPhoto];
    
    acceptanceLabel.font = [UIFont fontWithName:@"ProximaNova-Light" size:13];
    acceptanceLabel.textColor = UIColorFromRGB(0xe7eee2);
    acceptanceLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:acceptanceLabel];
    
    NSMutableAttributedString *termsOfServiceString = [[NSMutableAttributedString alloc] initWithString:@"Terms of Service"];
    
    // making text property to underline text-
    [termsOfServiceString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [termsOfServiceString length])];
    [termsOfService setAttributedTitle: termsOfServiceString forState:UIControlStateNormal];
    [termsOfServiceString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xe7eee2) range:NSMakeRange(0,[termsOfServiceString length])];
    termsOfService.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:13];
    [self.view addSubview:termsOfService];
    
    NSMutableAttributedString *privacyPolicyString = [[NSMutableAttributedString alloc] initWithString:@"Privacy Policy"];
    
    // making text property to underline text-
    [privacyPolicyString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [privacyPolicyString length])];
    [privacyPolicy setAttributedTitle: privacyPolicyString forState:UIControlStateNormal];
    [privacyPolicyString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xe7eee2) range:NSMakeRange(0,[privacyPolicyString length])];
    privacyPolicy.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:13];
    privacyPolicy.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.view addSubview:privacyPolicy];
    
	// Do any additional setup after loading the view.
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

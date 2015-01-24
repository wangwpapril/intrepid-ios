//
//  ForgotPasswordViewController.m
//  intrepidApp
//
//  Created by Jon Carr-Harris on 7/30/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "Constants.h"

@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController
@synthesize email;
@synthesize underlineEmail;
@synthesize signUpButton;
@synthesize exitButton;

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
	// Do any additional setup after loading the view.
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"login-background"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    //create title label
    UILabel *forgotLabel = [[UILabel alloc] init];
    forgotLabel.frame = CGRectMake(40, self.view.frame.origin.y - 35, 240, 150);
    forgotLabel.text = @"Forgot Password?";
    forgotLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:24];
    forgotLabel.textColor = [UIColor colorWithRed:231/255.0f green:238/255.0f blue:226/255.0f alpha:1.0f];
    forgotLabel.backgroundColor = [UIColor clearColor];
    [forgotLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:forgotLabel];
    
    exitButton.frame = CGRectMake(280, 32, 40, 40);
    [self.view addSubview:exitButton];
    UIImage *exitImage = [UIImage imageNamed:@"close"];
    //create an image and put it overtop of the button?
    UIImageView *exitImageContainer = [[UIImageView alloc] initWithFrame: CGRectMake(290, 32, 15, 15)];
    [exitImageContainer setImage:exitImage];
    [self.view addSubview:exitImageContainer];
    
    UILabel *enterEmailLabel = [[UILabel alloc] init];
    enterEmailLabel.frame = CGRectMake(0, 180, 320, 35);
    enterEmailLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:18];
    enterEmailLabel.textColor = [UIColor whiteColor];
    enterEmailLabel.backgroundColor = [UIColor clearColor];
    enterEmailLabel.text = @"Please Enter Your Email:";
    enterEmailLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:enterEmailLabel];
    
    self.email.delegate = self;
    
    UIImage *buttonImage = [[UIImage imageNamed:@"rounded-rectangle-"] stretchableImageWithLeftCapWidth:5 topCapHeight:10];
    [signUpButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [signUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signUpButton setTitle:@"SUBMIT" forState:UIControlStateNormal];
    signUpButton.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
    signUpButton.frame = CGRectMake(68, self.view.frame.size.height - 250, 183, 36);
    [self.view addSubview:signUpButton];
    
    
    email.font = [UIFont fontWithName:@"ProximaNova-Regular" size:15];
    email.textColor = [UIColor whiteColor];
    email.frame = CGRectMake(68, 235, 183, 35);
    email.backgroundColor = [UIColor clearColor];
    [email setReturnKeyType:UIReturnKeyDone];
    [self.view addSubview:email];
    
    underlineEmail.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"underline"]];
    underlineEmail.frame = CGRectMake(68, 271, 183, 1);
    [self.view addSubview:underlineEmail];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
    } else {
        [self moveAllSubviewsDown];
    }

}
- (void) moveAllSubviewsDown{
    float barHeight = 45.0;
    for (UIView *view in self.view.subviews) {
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + barHeight, view.frame.size.width, view.frame.size.height - barHeight);
        } else {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + barHeight, view.frame.size.width, view.frame.size.height);
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    //set up background
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

- (IBAction)exit:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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

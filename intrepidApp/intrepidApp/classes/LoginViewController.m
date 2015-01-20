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
#import "RequestBuilder.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface LoginViewController ()

#define kOFFSET_FOR_KEYBOARD 80.0

@end

@implementation LoginViewController

@synthesize loginButton;
@synthesize signUp;
@synthesize learnMore;
@synthesize legal;

@synthesize intrepidTitle;
@synthesize tagline;

@synthesize email;
@synthesize password;
@synthesize forgotPassword;
@synthesize underlinePassword;
@synthesize underlineEmail;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationItem.hidesBackButton = YES;
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.email.delegate = self;
    self.password.delegate = self;
    
    //set background image
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"login-background"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    UIImage *buttonImage = [[UIImage imageNamed:@"rounded-rectangle-"] stretchableImageWithLeftCapWidth:5 topCapHeight:10];
    [loginButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    
    [loginButton setTitleColor:UIColorFromRGB(0xe7eee2) forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
    [self.view addSubview:loginButton];
    
    
    NSMutableAttributedString *signUpString = [[NSMutableAttributedString alloc] initWithString:@"Sign Up"];
    
    // making text property to underline text-
    [signUpString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [signUpString length])];
    
    // using text on button
    [signUp setAttributedTitle: signUpString forState:UIControlStateNormal];
    [signUpString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,[signUpString length])];
    signUp.frame = CGRectMake(9, self.view.frame.size.height - 50, 81, 44);
    
    signUp.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:15];
    [self.view addSubview:signUp];
    
    
    NSMutableAttributedString *learnMoreString = [[NSMutableAttributedString alloc] initWithString:@"Learn More"];
    
    // making text property to underline text-
    [learnMoreString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [learnMoreString length])];
    
    // using text on button
    [learnMore setAttributedTitle: learnMoreString forState:UIControlStateNormal];
    [learnMoreString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,[learnMoreString length])];
    learnMore.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:15];
    learnMore.frame = CGRectMake(215, self.view.frame.size.height - 50, 81, 44);
    [self.view addSubview:learnMore];
    
//    intrepidTitle.font = [UIFont fontWithName:@"ProximaNova-Bold" size:24];
//    intrepidTitle.textColor = [UIColor whiteColor];
//    [intrepidTitle setTextAlignment:NSTextAlignmentCenter];
//    [self.view addSubview:intrepidTitle];
    
    tagline.font = [UIFont fontWithName:@"ProximaNova-Regular" size:15];
    tagline.textColor = [UIColor whiteColor];
    [tagline setTextAlignment:NSTextAlignmentCenter];
    tagline.text = @"TRAVEL SMART";
    [self.view addSubview:tagline];
    
    email.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
    email.textColor = [UIColor whiteColor];
    email.placeholder = @"EMAIL";
    [email setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [email setReturnKeyType:UIReturnKeyDone];
    [self.view addSubview:email];
    
    underlineEmail.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"underline"]];
    [self.view addSubview:underlineEmail];
    
    underlinePassword.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"underline"]];
    [self.view addSubview:underlinePassword];

    
    password.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
    password.textColor = [UIColor whiteColor];
    [password setReturnKeyType:UIReturnKeyDone];
    password.placeholder =@"PASSWORD";
    [password setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];

    password.secureTextEntry = YES;
    [self.view addSubview:password];
    
    
    
    NSMutableAttributedString *forgotPasswordString = [[NSMutableAttributedString alloc] initWithString:@"Forgot Password?"];
    
    // making text property to underline text-
    [forgotPasswordString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [forgotPasswordString length])];
    
    // using text on button
    [forgotPassword setAttributedTitle: forgotPasswordString forState:UIControlStateNormal];
    [forgotPasswordString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.53 green:0.73 blue:0.14 alpha:1] range:NSMakeRange(0,[forgotPasswordString length])];
    forgotPassword.frame = CGRectMake(77, loginButton.frame.origin.y + 50, 166, 15);
    forgotPassword.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:13];
    forgotPassword.backgroundColor = [UIColor clearColor];
    
    forgotPassword.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:forgotPassword];
    
    legal.frame = CGRectMake(240, 5, 100, 50);
    legal.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:13];
    legal.backgroundColor = [UIColor clearColor];
    legal.titleLabel.textAlignment = NSTextAlignmentCenter;
    [legal setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:legal];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
    } else {
        [self moveAllSubviewsDown];
    }
    
    
	// Do any additional setup after loading the view.
    email.text = @"cherry@swishlabs.co";
    password.text = @"pass@swish123";
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
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y < 0)
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

- (IBAction)login:(id)sender {    
    NSDictionary *body = @{@"user": @{@"email": self.email.text,
                                      @"password": self.password.text}
                           };

    NSURL *requestURL = [NSURL URLWithString:@"https://staging.intrepid247.com/v1/users/login"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestURL];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:body options:0 error:nil];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error) {
            NSDictionary *responseBody = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@", responseBody);
            if (responseBody[@"user"]) {
                [RequestBuilder fetchUser:responseBody];
                [self performSegueWithIdentifier:@"toTrips" sender:self];
            } else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                    message:responseBody[@"error"][@"message"][0]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                [alertView show];
            }
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                message:error.localizedDescription
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
    }];
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
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
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
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

@end


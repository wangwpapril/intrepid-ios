//
//  SignUpViewController.m
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-13.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>
#import "SignUpViewController.h"
#import "RequestBuilder.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

static NSString *baseURL = @"https://api.intrepid247.com/v1/";

@synthesize signUpButton;
@synthesize firstName;
@synthesize lastName;
@synthesize country;
@synthesize policyNumber;
@synthesize name;
@synthesize email;
@synthesize password;
@synthesize underlineFirstName;
@synthesize underlineLastName;
@synthesize underlineCountry;
@synthesize underlinePolicyNumber;
@synthesize underlineName;
@synthesize underlineEmail;
@synthesize underlinePassword;
@synthesize termsOfService;
@synthesize privacyPolicy;
@synthesize acceptanceLabel;
@synthesize newMedia;

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
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"signup-background"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.name.delegate = self;
    self.email.delegate = self;
    self.password.delegate = self;
    self.firstName.delegate = self;
    self.lastName.delegate = self;
    self.country.delegate = self;
    self.policyNumber.delegate = self;
//    [signUpButton setBackgroundImage:[UIImage imageNamed:@"login-and-signup-button"]
//                        forState:UIControlStateNormal];
    
    UIImage *buttonImage = [[UIImage imageNamed:@"rounded-rectangle-"] stretchableImageWithLeftCapWidth:5 topCapHeight:10];
    [signUpButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    
    [signUpButton setTitleColor:UIColorFromRGB(0xe7eee2) forState:UIControlStateNormal];
    signUpButton.titleLabel.font = [UIFont fontWithName:APP_FONT size:14];
    signUpButton.frame = CGRectMake(68, self.view.frame.size.height - 150, 183, 36);
    [self.view addSubview:signUpButton];

    firstName.font = [UIFont fontWithName:APP_FONT size:14];
    firstName.textColor = UIColorFromRGB(0xe7eee2);
    firstName.placeholder = @"FIRST NAME";
    [firstName setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [firstName setReturnKeyType:UIReturnKeyDone];
    [self.view addSubview:firstName];
    
    underlineFirstName.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"underline"]];
    [self.view addSubview:underlineFirstName];
    
    lastName.font = [UIFont fontWithName:APP_FONT size:14];
    lastName.textColor = UIColorFromRGB(0xe7eee2);
    lastName.placeholder = @"LAST NAME";
    [lastName setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [lastName setReturnKeyType:UIReturnKeyDone];
    [self.view addSubview:lastName];
    
    underlineLastName.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"underline"]];
    [self.view addSubview:underlineLastName];
    
    country.font = [UIFont fontWithName:APP_FONT size:14];
    country.textColor = UIColorFromRGB(0xe7eee2);
    country.placeholder = @"COUNTRY";
    [country setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [country setReturnKeyType:UIReturnKeyDone];
    
    UIPickerView *picker = [[UIPickerView alloc] init];
    picker.delegate = self;
    picker.showsSelectionIndicator = YES;
    country.inputView = picker;
    [self fetchCountries];
    
    [self.view addSubview:name];
    
    underlineCountry.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"underline"]];
    [self.view addSubview:underlineCountry];
    
    policyNumber.font = [UIFont fontWithName:APP_FONT size:14];
    policyNumber.textColor = UIColorFromRGB(0xe7eee2);
    policyNumber.placeholder = @"POLICY NUMBER";
    [policyNumber setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [policyNumber setReturnKeyType:UIReturnKeyDone];
    [self.view addSubview:policyNumber];
    
    underlinePolicyNumber.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"underline"]];
    [self.view addSubview:underlinePolicyNumber];
    
    name.font = [UIFont fontWithName:APP_FONT size:14];
    name.textColor = UIColorFromRGB(0xe7eee2);
    name.placeholder = @"NAME";
    [name setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [name setReturnKeyType:UIReturnKeyDone];
    [self.view addSubview:name];
    
    underlineName.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"underline"]];
    [self.view addSubview:underlineName];
    
    email.font = [UIFont fontWithName:APP_FONT size:14];
    email.textColor = UIColorFromRGB(0xe7eee2);
    email.placeholder = @"EMAIL";
    [email setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [email setReturnKeyType:UIReturnKeyDone];
    [self.view addSubview:email];
    
    underlineEmail.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"underline"]];
    [self.view addSubview:underlineEmail];
    
    password.font = [UIFont fontWithName:APP_FONT size:14];
    password.textColor = UIColorFromRGB(0xe7eee2);
    password.placeholder = @"PASSWORD";
    [password setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [password setReturnKeyType:UIReturnKeyDone];
    [self.view addSubview:password];
    
    underlinePassword.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"underline"]];
    [self.view addSubview:underlinePassword];
    
    acceptanceLabel.font = [UIFont fontWithName:@"ProximaNova-Light" size:14];
    acceptanceLabel.textColor = UIColorFromRGB(0xe7eee2);
    acceptanceLabel.textAlignment = NSTextAlignmentCenter;
    acceptanceLabel.frame = CGRectMake(68, self.view.frame.size.height - 90, 183, 21);
    [self.view addSubview:acceptanceLabel];
    
    NSMutableAttributedString *termsOfServiceString = [[NSMutableAttributedString alloc] initWithString:@"Terms of Service"];
    
    // making text property to underline text-
    [termsOfServiceString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [termsOfServiceString length])];
    [termsOfService setAttributedTitle: termsOfServiceString forState:UIControlStateNormal];
    [termsOfServiceString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xe7eee2) range:NSMakeRange(0,[termsOfServiceString length])];
    termsOfService.titleLabel.font = [UIFont fontWithName:APP_FONT size:13];
    termsOfService.frame = CGRectMake(43, self.view.frame.size.height - 70, 121, 19);
    [self.view addSubview:termsOfService];
    
    NSMutableAttributedString *privacyPolicyString = [[NSMutableAttributedString alloc] initWithString:@"Privacy Policy"];
    
    // making text property to underline text-
    [privacyPolicyString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [privacyPolicyString length])];
    [privacyPolicy setAttributedTitle: privacyPolicyString forState:UIControlStateNormal];
    [privacyPolicyString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xe7eee2) range:NSMakeRange(0,[privacyPolicyString length])];
    privacyPolicy.titleLabel.font = [UIFont fontWithName:APP_FONT size:13];
    privacyPolicy.frame = CGRectMake(163, self.view.frame.size.height - 70, 102, 19);
    privacyPolicy.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.view addSubview:privacyPolicy];
    
//    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
//        
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//        
//    } else {
//        [self moveAllSubviewsDown];
//    }
    
    
	// Do any additional setup after loading the view.
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

- (void)fetchCountries {
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@countries", baseURL]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestURL];
    request.HTTPMethod = @"GET";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (!error) {
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.countryArray = responseObject[@"countries"];
        NSLog(@"%@", self.countryArray);
    } else {
        NSLog(@"error: %@", error.localizedDescription);
    }
}

- (IBAction)signup:(id)sender {
    NSDictionary *body = @{@"company": @{@"group_num": name.text}};
    
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@companies/checkGroupNum", baseURL]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestURL];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:body options:0 error:nil];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error) {
            NSDictionary *responseBody = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@", responseBody);
            if (responseBody[@"company"]) {
//                [RequestBuilder fetchUser:responseBody];
//                [self performSegueWithIdentifier:@"toTrips" sender:self];
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

#pragma mark - Picker View methods

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.countryArray.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.countryArray[row][@"name"];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedCountry = self.countryArray[row][@"country_code"];
    country.text = self.countryArray[row][@"name"];
    [country resignFirstResponder];
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
        rect.origin.y -= 110.0;
        //rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += 110.0;
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

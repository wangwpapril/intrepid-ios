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

@synthesize signUpButton;
@synthesize firstName;
@synthesize lastName;
@synthesize country;
@synthesize policyNumber;
@synthesize username;
@synthesize email;
@synthesize password;
@synthesize underlineFirstName;
@synthesize underlineLastName;
@synthesize underlineCountry;
@synthesize underlinePolicyNumber;
@synthesize underlineUsername;
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
    [[UITextField appearance] setTintColor:[UIColor whiteColor]];
    //set up background
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"login-background"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.username.delegate = self;
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
    
    
    [signUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    signUpButton.titleLabel.font = [UIFont fontWithName:APP_FONT size:14];
    signUpButton.frame = CGRectMake(68, self.view.frame.size.height - 230, 183, 36);
    [self.view addSubview:signUpButton];

    firstName.font = [UIFont fontWithName:APP_FONT size:14];
    firstName.textColor = [UIColor whiteColor];
    firstName.placeholder = @"FIRST NAME";
    [firstName setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [firstName setReturnKeyType:UIReturnKeyDone];
    [self.view addSubview:firstName];
    
    underlineFirstName.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"underline"]];
    [self.view addSubview:underlineFirstName];
    
    lastName.font = [UIFont fontWithName:APP_FONT size:14];
    lastName.textColor = [UIColor whiteColor];
    lastName.placeholder = @"LAST NAME";
    [lastName setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [lastName setReturnKeyType:UIReturnKeyDone];
    [self.view addSubview:lastName];
    
    underlineLastName.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"underline"]];
    [self.view addSubview:underlineLastName];
    
    country.font = [UIFont fontWithName:APP_FONT size:14];
    country.textColor = [UIColor whiteColor];
    country.placeholder = @"COUNTRY";
    [country setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [country setReturnKeyType:UIReturnKeyDone];
    
    UIPickerView *picker = [[UIPickerView alloc] init];
    picker.delegate = self;
    picker.showsSelectionIndicator = YES;
    country.inputView = picker;
    country.tag = 1;
    country.tintColor = [UIColor clearColor];
    [self fetchCountries];
    [self.view addSubview:country];
    
    underlineCountry.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"underline"]];
    [self.view addSubview:underlineCountry];
    
    policyNumber.font = [UIFont fontWithName:APP_FONT size:14];
    policyNumber.textColor = [UIColor whiteColor];
    policyNumber.placeholder = @"POLICY NUMBER";
    [policyNumber setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [policyNumber setReturnKeyType:UIReturnKeyDone];
    [self.view addSubview:policyNumber];
    
    underlinePolicyNumber.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"underline"]];
    [self.view addSubview:underlinePolicyNumber];
    
    username.font = [UIFont fontWithName:APP_FONT size:14];
    username.textColor = [UIColor whiteColor];
    username.placeholder = @"USERNAME";
    [username setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [username setReturnKeyType:UIReturnKeyDone];
    [self.view addSubview:username];
    
    underlineUsername.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"underline"]];
    [self.view addSubview:underlineUsername];
    
    email.font = [UIFont fontWithName:APP_FONT size:14];
    email.textColor = [UIColor whiteColor];
    email.placeholder = @"EMAIL";
    [email setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [email setReturnKeyType:UIReturnKeyDone];
    [self.view addSubview:email];
    
    underlineEmail.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"underline"]];
    [self.view addSubview:underlineEmail];
    
    password.font = [UIFont fontWithName:APP_FONT size:14];
    password.textColor = [UIColor whiteColor];
    password.placeholder = @"PASSWORD";
    [password setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [password setReturnKeyType:UIReturnKeyDone];
    [self.view addSubview:password];
    
    underlinePassword.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"underline"]];
    [self.view addSubview:underlinePassword];
    
    acceptanceLabel.font = [UIFont fontWithName:@"ProximaNova-Light" size:11];
    acceptanceLabel.textColor = [UIColor whiteColor];
    acceptanceLabel.textAlignment = NSTextAlignmentCenter;
    acceptanceLabel.frame = CGRectMake(68, self.view.frame.size.height - 170, 183, 21);
    [self.view addSubview:acceptanceLabel];
    
    NSMutableAttributedString *termsOfServiceString = [[NSMutableAttributedString alloc] initWithString:@"Terms of Service, "];
    
    // making text property to underline text-
    [termsOfServiceString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [termsOfServiceString length])];
    [termsOfService setAttributedTitle: termsOfServiceString forState:UIControlStateNormal];
    [termsOfServiceString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,[termsOfServiceString length])];
    termsOfService.titleLabel.font = [UIFont fontWithName:APP_FONT size:11];
    termsOfService.frame = CGRectMake(70, self.view.frame.size.height - 150, 111, 19);
    [self.view addSubview:termsOfService];
    
    NSMutableAttributedString *privacyPolicyString = [[NSMutableAttributedString alloc] initWithString:@"Privacy Policy"];
    
    // making text property to underline text-
    [privacyPolicyString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [privacyPolicyString length])];
    [privacyPolicy setAttributedTitle: privacyPolicyString forState:UIControlStateNormal];
    [privacyPolicyString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,[privacyPolicyString length])];
    privacyPolicy.titleLabel.font = [UIFont fontWithName:APP_FONT size:11];
    privacyPolicy.frame = CGRectMake(133, self.view.frame.size.height - 150, 102, 19);
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

- (IBAction)signup:(id)sender {
    NSDictionary *body = @{@"company": @{@"group_num": policyNumber.text}};
    
    if (firstName.text.length < 1 || lastName.text.length < 1 || email.text.length < 1 || country.text.length < 1 || username.text.length < 1 || password.text.length < 1 || policyNumber.text.length < 1) {
        [self sendAlertWithError:@"All fields are required."];
        return;
    }
    if (![self NSStringIsValidEmail:email.text]) {
        [self sendAlertWithError:@"The email format is invalid."];
        return;
    }
    if (username.text.length < 3) {
        [self sendAlertWithError:@"Username must be at least 3 characters."];
        return;
    }
    if (password.text.length < 7) {
        [self sendAlertWithError:@"Password must be at least 7 characters."];
        return;
    }
    
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@companies/checkGroupNum", BASE_URL]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestURL];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:body options:0 error:nil];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error) {
            NSDictionary *responseBody = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@", responseBody);
            if (responseBody[@"company"]) {
                [self createUserWithCompanyId:responseBody[@"company"][@"group_number"]];
            } else {
                [self sendAlertWithError:responseBody[@"error"][@"message"][0]];
            }
        } else {
            [self sendAlertWithError:error.localizedDescription];
        }
    }];
}

- (void)createUserWithCompanyId:(NSNumber *)companyId {
    NSDictionary *body = @{@"user": @{@"email": email.text,
                                      @"first_name": firstName.text,
                                      @"last_name": lastName.text,
                                      @"username": username.text,
                                      @"password": password.text,
                                      @"roles": @[@"end_user"],
                                      @"locale_code": @"en_CA",
                                      @"country_code": self.selectedCountry,
                                      @"company_id": companyId
                                      }
                           };
    
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@users", BASE_URL]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestURL];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:body options:0 error:nil];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error) {
            NSDictionary *responseBody = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@", responseBody);
            if (responseBody[@"user"]) {
                [self sendEmailWithActivationCode:responseBody[@"user"][@"activation_code"]];
            } else {
                [self sendAlertWithError:responseBody[@"error"][@"message"][0]];
            }
        } else {
            [self sendAlertWithError:error.localizedDescription];
        }
    }];
}

- (void)sendEmailWithActivationCode:(NSString *)activationCode {
    NSDictionary *body = @{@"key": @"2Hw47otRRKIaEQ3sQwoXAg",
                           @"message": @{
                               @"text": [NSString stringWithFormat:@"Hi %@,\n\nThank you for signing up with ACE Travel Smart.\nPlease click on the confirmation link below to activate your account.\n%@%@", firstName.text, ACTIVATE_URL, activationCode],
                               @"subject": @"Thank you for signing up",
                               @"from_email": @"do-not-reply@acetravelsmart.com",
                               @"from_name": @"ACE Travel Smart",
                               @"to": @[@{@"email": email.text,
                                          @"name": [NSString stringWithFormat:@"%@ %@", firstName.text, lastName.text]}],
                               },
                           };
    
    NSURL *requestURL = [NSURL URLWithString:EMAIL_URL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestURL];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:body options:0 error:nil];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error) {
            id responseBody = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@", responseBody);
            if ([responseBody isKindOfClass:[NSArray class]]) {
                if ([responseBody[0][@"status"] isEqual:@"sent"]) {
                    [self sendAlertWithError:@"Thank you for signing up. Please check your email to activate your account."];
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    [self sendAlertWithError:@"Please try again later."];
                }
            } else if ([responseBody isKindOfClass:[NSDictionary class]]) {
                [self sendAlertWithError:@"Please try again later."];
            }
        } else {
            [self sendAlertWithError:error.localizedDescription];
        }
    }];
}

#pragma mark - Helper methods

- (void)fetchCountries {
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@countries", BASE_URL]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestURL];
    request.HTTPMethod = @"GET";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (!error) {
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.countryArray = responseObject[@"countries"];
    } else {
        NSLog(@"error: %@", error.localizedDescription);
    }
}

- (BOOL)NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

- (void)sendAlertWithError:(NSString *)errorString {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:errorString
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.tag == 1) {
        return NO;
    } else {
        return YES;
    }
}

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
    [firstName resignFirstResponder];
    [lastName resignFirstResponder];
    [email resignFirstResponder];
    [username resignFirstResponder];
    [password resignFirstResponder];
    [policyNumber resignFirstResponder];
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
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
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

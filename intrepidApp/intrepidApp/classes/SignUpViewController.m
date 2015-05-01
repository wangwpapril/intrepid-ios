//
//  SignUpViewController.m
//  intrepidApp
//
//  Created by Jon Carr-Harris on 2013-07-13.
//  Copyright (c) 2013 Swish Labs Inc. All rights reserved.
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
@synthesize termsOfService;
@synthesize acceptanceLabel;
@synthesize acceptanceLabel2;
@synthesize newMedia;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UITextField appearance] setTintColor:[UIColor whiteColor]];
    //set up background
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.countryPicker = [[UIPickerView alloc] init];
    self.countryPicker.delegate = self;
    self.countryPicker.showsSelectionIndicator = YES;
    country.inputView = self.countryPicker;
    country.tag = 1;
    country.tintColor = [UIColor clearColor];
    [self fetchCountries];
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
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.view.center;
    [self.view addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    
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
    }};
    
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
                    [[SEGAnalytics sharedAnalytics] track:@"Email Signup"
                                               properties:@{@"category" : @"Signup"}];
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
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error) {
            NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.countryArray = responseObject[@"countries"];
            [self.countryPicker reloadAllComponents];
        } else {
            NSLog(@"error: %@", error.localizedDescription);
        }
    }];
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
    [self.activityIndicator stopAnimating];
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == firstName) {
        [[SEGAnalytics sharedAnalytics] track:@"First Name Field"
                                   properties:@{@"category" : @"Signup"}];
    } else if (textField == lastName) {
        [[SEGAnalytics sharedAnalytics] track:@"Last Name Field"
                                   properties:@{@"category" : @"Signup"}];
    } else if (textField == country) {
        [[SEGAnalytics sharedAnalytics] track:@"Country Field"
                                   properties:@{@"category" : @"Signup"}];
    } else if (textField == email) {
        [[SEGAnalytics sharedAnalytics] track:@"Email Field"
                                   properties:@{@"category" : @"Signup"}];
    } else if (textField == country) {
        [[SEGAnalytics sharedAnalytics] track:@"Country Field"
                                   properties:@{@"category" : @"Signup"}];
    } else if (textField == username) {
        [[SEGAnalytics sharedAnalytics] track:@"Username Field"
                                   properties:@{@"category" : @"Signup"}];
    } else if (textField == password) {
        [[SEGAnalytics sharedAnalytics] track:@"Password Field"
                                   properties:@{@"category" : @"Signup"}];
    } else if (textField == policyNumber) {
        [[SEGAnalytics sharedAnalytics] track:@"Policy Number Field"
                                   properties:@{@"category" : @"Signup"}];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.tag == 1) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == self.firstName) {
        [textField resignFirstResponder];
        [self.lastName becomeFirstResponder];
    }
    if(textField == self.lastName) {
        [textField resignFirstResponder];
        [self.email becomeFirstResponder];
    }
    if(textField == self.email) {
        [textField resignFirstResponder];
        [self.country becomeFirstResponder];
    }
    if(textField == self.country) {
        [textField resignFirstResponder];
        [self.username becomeFirstResponder];
    }
    if(textField == self.username) {
        [textField resignFirstResponder];
        [self.password becomeFirstResponder];
    }
    if (textField == self.password) {
        [textField resignFirstResponder];
        [self.policyNumber becomeFirstResponder];
    }
    if (textField == self.policyNumber) {
        [textField resignFirstResponder];
        [self signup:self];
    }
    return YES;
}

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        if (username.isEditing || password.isEditing || policyNumber.isEditing) {
            [self setViewMovedUp:YES];
        }
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
    [super viewWillAppear:animated];
    [[SEGAnalytics sharedAnalytics] screen:@"Signup"];
    
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
    
    [super viewWillDisappear:animated];
}

@end

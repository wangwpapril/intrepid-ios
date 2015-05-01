//
//  SignUpViewController.h
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-13.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *country;
@property (weak, nonatomic) IBOutlet UITextField *policyNumber;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UILabel *underlineFirstName;
@property (weak, nonatomic) IBOutlet UILabel *underlineLastName;
@property (weak, nonatomic) IBOutlet UILabel *underlineCountry;
@property (weak, nonatomic) IBOutlet UILabel *underlinePolicyNumber;
@property (weak, nonatomic) IBOutlet UILabel *underlineUsername;
@property (weak, nonatomic) IBOutlet UILabel *underlineEmail;
@property (weak, nonatomic) IBOutlet UILabel *underlinePassword;
@property (weak, nonatomic) IBOutlet UILabel *acceptanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *acceptanceLabel2;
@property (weak, nonatomic) IBOutlet UIButton *termsOfService;
@property BOOL newMedia;
@property (strong, nonatomic) NSArray *countryArray;
@property (strong, nonatomic) NSString *selectedCountry;
@property (strong, nonatomic) UIPickerView *countryPicker;
@property (nonatomic,retain) UIActivityIndicatorView *activityIndicator;

- (IBAction)signup:(id)sender;

@end

//
//  LoginViewController.h
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-13.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signUp;
@property (weak, nonatomic) IBOutlet UIButton *learnMore;
@property (weak, nonatomic) IBOutlet UIButton *legal;

@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UILabel *intrepidTitle;
@property (weak, nonatomic) IBOutlet UILabel *tagline;
@property (weak, nonatomic) IBOutlet UIButton *forgotPassword;
@property (weak, nonatomic) IBOutlet UILabel *underlinePassword;
@property (weak, nonatomic) IBOutlet UILabel *underlineEmail;


//- (IBAction)typeBox:(id)sender;
//- (IBAction)button;
- (void)keyboardWillShow;
- (void)keyboardWillHide;
- (void)textFieldDidBeginEditing:(UITextField *)sender;
- (void)setViewMovedUp:(BOOL)movedUp;


@end

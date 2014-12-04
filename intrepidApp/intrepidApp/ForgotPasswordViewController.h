//
//  ForgotPasswordViewController.h
//  intrepidApp
//
//  Created by Jon Carr-Harris on 7/30/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPasswordViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UILabel *underlineEmail;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

//- (IBAction)typeBox:(id)sender;
- (void)keyboardWillShow;
- (void)keyboardWillHide;
- (void)textFieldDidBeginEditing:(UITextField *)sender;
- (void)setViewMovedUp:(BOOL)movedUp;


@end

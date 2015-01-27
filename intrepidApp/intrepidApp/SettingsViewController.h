//
//  SettingsViewController.h
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-30.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuController.h"

@interface SettingsViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *signOutButton;
@property(weak, nonatomic) IBOutlet UITextField *firstName;
@property(weak, nonatomic) IBOutlet UITextField *lastName;
@property(weak, nonatomic) IBOutlet UITextField *email;
@property(weak, nonatomic) IBOutlet UITextField *oldPassword;
@property(weak, nonatomic) IBOutlet UITextField *changePassword;
@property (nonatomic, strong) MenuController *mController;

@property BOOL newMedia;
- (IBAction)signout:(id)sender;

@end

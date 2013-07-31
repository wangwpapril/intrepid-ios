//
//  SettingsViewController.h
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-30.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *addPhoto;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *signOutButton;

@property (weak, nonatomic) IBOutlet UILabel *underlineName;
@property (weak, nonatomic) IBOutlet UILabel *underlineEmail;
@property (weak, nonatomic) IBOutlet UILabel *underlinePassword;
@property (weak, nonatomic) IBOutlet UILabel *acceptanceLabel;


@end

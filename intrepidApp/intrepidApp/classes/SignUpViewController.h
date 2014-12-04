//
//  SignUpViewController.h
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-13.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController <UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *addPhoto;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

@property (weak, nonatomic) IBOutlet UILabel *underlineName;
@property (weak, nonatomic) IBOutlet UILabel *underlineEmail;
@property (weak, nonatomic) IBOutlet UILabel *underlinePassword;
@property (weak, nonatomic) IBOutlet UILabel *acceptanceLabel;
@property (weak, nonatomic) IBOutlet UIButton *termsOfService;
@property (weak, nonatomic) IBOutlet UIButton *privacyPolicy;

@property BOOL newMedia;
- (IBAction)useCameraRoll:(id)sender;
//- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;

@end

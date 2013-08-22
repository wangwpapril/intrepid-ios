//
//  SettingsViewController.m
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-30.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "SettingsViewController.h"
#import "Constants.h"
#import "MenuController.h"
#import <QuartzCore/QuartzCore.h>

#define kOFFSET_FOR_KEYBOARD 130.0

@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize editPhoto;
@synthesize signOutButton;
@synthesize mController;

@synthesize newMedia;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    mController = [MenuController getInstance];
    self.view.tag = 8;
    self.navigationItem.title = @"Settings";
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"signUp-background.png"]];
    [self.view addSubview:backgroundView];
    
    [editPhoto setBackgroundImage:[UIImage imageNamed:@"Add@2x.png"]
                        forState:UIControlStateNormal];
    [self.view addSubview:editPhoto];
    
    //Initalize the Labels
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.frame = CGRectMake(10, 150, 150, 20);
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = [UIFont fontWithName:@"ProximaNova-Semi-Bold" size:15];
    nameLabel.textColor = [UIColor whiteColor];
    [nameLabel setTextAlignment:NSTextAlignmentLeft];
    nameLabel.text = @"Name:";
    [self.view addSubview:nameLabel];
    
    UILabel *emailLabel = [[UILabel alloc] init];
    emailLabel.frame = CGRectMake(10, 200, 150, 20);
    emailLabel.backgroundColor = [UIColor clearColor];
    emailLabel.font = [UIFont fontWithName:@"ProximaNova-Semi-Bold" size:15];
    emailLabel.textColor = [UIColor whiteColor];
    [emailLabel setTextAlignment:NSTextAlignmentLeft];
    emailLabel.text = @"Email:";
    [self.view addSubview:emailLabel];
    
    UILabel *passwordLabel = [[UILabel alloc] init];
    passwordLabel.frame = CGRectMake(10, 250, 150, 20);
    passwordLabel.backgroundColor = [UIColor clearColor];
    passwordLabel.font = [UIFont fontWithName:@"ProximaNova-Semi-Bold" size:15];
    passwordLabel.textColor = [UIColor whiteColor];
    [passwordLabel setTextAlignment:NSTextAlignmentLeft];
    passwordLabel.text = @"Password:";
    [self.view addSubview:passwordLabel];
    
    UILabel *passwordConfirmationLabel = [[UILabel alloc] init];
    passwordConfirmationLabel.frame = CGRectMake(10, 300, 150, 20);
    passwordConfirmationLabel.backgroundColor = [UIColor clearColor];
    passwordConfirmationLabel.font = [UIFont fontWithName:@"ProximaNova-Semi-Bold" size:15];
    passwordConfirmationLabel.textColor = [UIColor whiteColor];
    [passwordConfirmationLabel setTextAlignment:NSTextAlignmentLeft];
    passwordConfirmationLabel.text = @"Confirm Password:";
    [self.view addSubview:passwordConfirmationLabel];
    
    
    //Initalize the TextFields and keyboard
    
    UITextField *name = [[UITextField alloc] init];
    name.font = [UIFont fontWithName:@"ProximaNova-Regular" size:15];
    name.frame = CGRectMake(200, 150, 135, 34);
    name.textColor = [UIColor whiteColor];
    name.placeholder = @"Your Name";
    [name setReturnKeyType:UIReturnKeyDone];
    name.delegate = self;
    [self.view addSubview:name];
    
    UILabel *underlineName = [[UILabel alloc] init];
    underlineName.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider-mid-1.png"]];
    underlineName.frame = CGRectMake(10, 175, 295, 1);
    [self.view addSubview:underlineName];
    
    UITextField *email = [[UITextField alloc] init];
    email.font = [UIFont fontWithName:@"ProximaNova-Regular" size:15];
    email.frame = CGRectMake(200, 200, 135, 34);
    email.textColor = [UIColor whiteColor];
    email.placeholder = @"Your Email";
    [email setReturnKeyType:UIReturnKeyDone];
    email.delegate = self;
    [self.view addSubview:email];
    
    UILabel *underlineEmail = [[UILabel alloc] init];
    underlineEmail.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider-mid-1.png"]];
    underlineEmail.frame = CGRectMake(10, 225, 295, 1);
    [self.view addSubview:underlineEmail];
    
    UITextField *password = [[UITextField alloc] init];
    password.font = [UIFont fontWithName:@"ProximaNova-Regular" size:15];
    password.frame = CGRectMake(200, 250, 135, 34);
    password.textColor = [UIColor whiteColor];
    password.placeholder = @"Your Password";
    [password setReturnKeyType:UIReturnKeyDone];
    password.delegate = self;
    [self.view addSubview:password];
    
    UILabel *underlinePassword = [[UILabel alloc] init];
    underlinePassword.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider-mid-1.png"]];
    underlinePassword.frame = CGRectMake(10, 275, 295, 1);
    [self.view addSubview:underlinePassword];
    
    UITextField *passwordConfirmation = [[UITextField alloc] init];
    passwordConfirmation.font = [UIFont fontWithName:@"ProximaNova-Regular" size:15];
    passwordConfirmation.frame = CGRectMake(200, 300, 135, 34);
    passwordConfirmation.textColor = [UIColor whiteColor];
    passwordConfirmation.placeholder = @"Your Password";
    [passwordConfirmation setReturnKeyType:UIReturnKeyDone];
    passwordConfirmation.delegate = self;
    [self.view addSubview:passwordConfirmation];
    
    UILabel *underlinePasswordConfirmation = [[UILabel alloc] init];
    underlinePasswordConfirmation.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider-mid-1.png"]];
    underlinePasswordConfirmation.frame = CGRectMake(10, 325, 295, 1);
    [self.view addSubview:underlinePasswordConfirmation];
    
    //Initalize the Sign Out button
    UIImage *buttonImage = [[UIImage imageNamed:@"Signout_new@2x.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:10];
    [signOutButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [signOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    signOutButton.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
    signOutButton.frame = CGRectMake(68, underlinePasswordConfirmation.frame.origin.y + 25, 183, 36);
    [self.view addSubview:signOutButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)useCameraRoll:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker
                           animated:YES completion:nil];
        newMedia = NO;
    }
}
#pragma mark -
#pragma mark UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [editPhoto setImage:image forState:UIControlStateNormal];
    
    editPhoto.layer.cornerRadius = 50;
    editPhoto.layer.masksToBounds = YES;
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
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
    [_email resignFirstResponder];
    [_password resignFirstResponder];
    
    
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
    [mController displayMenuWithParent:self];
    
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

//
//  AceViewController.h
//  intrepidApp
//
//  Created by Chaitanya Shah on 2015-02-03.
//  Copyright (c) 2015 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuController.h"

@interface AceViewController : UIViewController

@property (nonatomic, strong) MenuController *mController;
@property (weak, nonatomic) IBOutlet UIButton *aceButton;
@property (weak, nonatomic) IBOutlet UIButton *pdfButton;

- (IBAction)aceAction:(id)sender;
- (IBAction)pdfAction:(id)sender;

@end
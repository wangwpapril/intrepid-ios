//
//  PrivacyPolicyViewController.h
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-30.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrivacyPolicyViewController : UIViewController {
    IBOutlet UIScrollView *scrollView;
}
@property (weak, nonatomic) IBOutlet UIButton *exitButton;

- (IBAction)exit:(id)sender;
@end
